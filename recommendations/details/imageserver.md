# Image Server

### Use cases
* Optimize images for the web site
* Make images available for other applications
* Provide product images for Supply Chain implementation

### Current state
Right now, we use the [Sharp](https://sharp.pixelplumbing.com) library, built and embedded in an AWS Lambda@Edge function, to resize JPEG images on demand from the web site.  This approach is limited, was written quickly, has some performance issues that need to be corrected, and embeds the system in our infrastructure instead of within application logic.

### Difficulties with the current implementation
* For JavaScript dependencies that rely on bindings to libraries written in C or C++ to run in a Lambda, we have to pre-compile the C binaries to the Lambda Linux target, and manually include in into the zip file that we upload.  Deploying this using Terraform has some issues that need to be worked around, and it takes about 20 minutes or so to fully deploy due to the time it takes to propagate the change to the various edge servers around the world.
* The current implementation was written quickly, and without much oversight.  It got the job done when it was needed, but it isn't the easiest code to read.  And, its initial author is gone.
* The current implementation writes its resized images to a different S3 bucket, using it as an ersatz permanent cache.  This incurs unnecessary storage charges.
* Lambda@Edge carries limitations, chief among them that it occasionally suffers from a "cold start penalty", which adds time onto the request.  Also, if a request ever takes longer than a strict time limit, it will be cut off and a 403 response is sent.  While it is usable this way, we're clearly using it in a way that wasn't intended.
* Our infrastructure-as-code system is simply the wrong place to put application code.

### Suggested replacement
In keeping with our recent basic technology strategy, we're looking into replacing the Lambda@Edge implementation with a dedicated service.  This will be a web server, which only serves images.

Its primary actions will be:
* Resize images to a different dimension, if a different dimension is requested,
* Optimize images, independent of size, so that they have the smallest file size possible, regardless of the image dimension.

Other operations are possible, but shouldn't be needed at present.  We can add conversion to WEBP, for example.

### Implmentation notes
* Our basic choices for services have come down to using either JavaScript through Node, or Scala.  Image processing support is in the JVM world is limited in what it can do as well as being generally slow.  This leaves an implementation in Node to be the starting point.
* While Sharp is a pretty good library, it is based on [libvips](https://github.com/libvips/libvips), and packages its default build for use given a clean install.  As a result, Sharp has the following limitations out of the box:
  * Sharp can read GIF formatted files, but it can't write them out of the box.  It also doesn't handle animated GIF files especially well, since that's not a primary consideration of the GIF libraries that it can include.  And, that's our primary use case for GIFs.
  * Sharp can read and write JPEG files, which is our largest use case - product images.  But, it doesn't write files to be as small as they can be.  It uses the reference implementation from libjpeg, rather than the more recent mozjpeg.
  * Sharp can read and write PNG files, but can't optimize them out of the box.  This is a small, but existing, use case.
* One way to mitigate some of the shortcomings of a default libvips build is to create a custom build, and make it available on the server's LD_LIBRARY_PATH before starting up the service.  Sharp will automatically use a global libvips library over its default build, if it can find it.  This can give us mozjpeg and libpngquant, which will better optimize JPEG and PNG images, respectively.
* For animated GIFs, our choices are more limited.  The "best" (and, possibly only) tool for processing animated GIFs is [gifsicle](https://www.lcdf.org/gifsicle).  Unfortunately, this is only built as a command line tool. This means that we have to spawn a full process to run it, limiting runtime performance.  (This is done using Node child_process library.)  Thankfully, we don't use a lot of these.  And, it would probably be for the best to ban animated GIFs from the site outright.
* We'll be heavily relying on Cloudfront for caching.  Since the product teams check the products on the site routinely before products are release, they'll be effectively warming the cache for most product images on the site.