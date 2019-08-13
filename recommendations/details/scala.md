# Scala

- Language features (mostly used)
   - immutability by default
   - null safety (kind of) 
      ```scala
         case class Point(x : Int, y : Int)
         val a : Point = null //danger
         a.x //OOPS, NPE
         
         val b : Option[Point] = Option(javaFunctionReturningPoint())
         
         b.map{ point => 
            //safely use point
         }
         
      ```
   - type inference
      ```scala
      val a = "hello world"
      val b : String = "hello world"
      ```
   - data types
      ```scala
      case class Point(x : int, y : Int)
      ```
   - Pattern matching 
      ```scala
      val point = Point(34, 65)
      point match {
      case Point(x, y) => //x = 34 y = 65
      }
      def calcSomePoint() : Point
      val Point(x, y) = calcSomePoint()
      //values x and y is available here
      
      val ages = List(3, 6, 43, 1, 0)
      ages match {
      case head :: tail => //head : Int 
      //tail : List[Int]
      case Nil => //list is empty
      }
      ```
   - for-comprehansion 
   ```scala
   def callService1 : Future[Result]
   def callService2 : Futire[Result]
   
   val results : Futire[(Result, Result)] = (for{
    res1 <- callService1
    res2 <- callService2
    } yield (res1, res2))
   ```
   - higher order functions 
   ```scala 
   def double(x) = x * 2
   
   val numbers : List(1, 2, 3)
   numbers.map(double)
   //List(2,4,6)
   ```
   - sealed traits
   ```scala
   sealed trait Direction
   case object North extends Direction
   case object South extends Direction
   case object West extends Direction
   case object East extends Direction
   case class Unknown(name : String)
   
   val dir : Direction = calcDirection()
   //following is exhaustive pattern matching
   dir match {
      case North =>
      case South =>
      case West =>
      case East =>
      case Unknown(unknownDirection) => println(s"you shell not pass $unknownDirection")
   }
   ```
   - Algepraic Data Types (ADT)
      - sealed traits (sums)
      - case clusses (products)
      
   - inplicits (very low level language feature, many usefull things may be implemented using it)
      - type classes
      ```scala
      //type class
      trait Addable[T] {
         def add(left: T, right: T): T
      }

      def add1[A: Addable](left: A, right: A): A = {
         implicitly[Addable[A]].add(left, right)
      }
      //add2 is identical to add1, just more explicit syntax
      def add2[A](left: A, right: A)(implicit Addable: Addable[A]): A = {
         Addable.add(left, right)
      }

      implicit object IntAdder extends Addable[Int] {
         override def add(left: Int, right: Int): Int = left + right
      }

      add2(1, 3) //4

      implicit object StringAdder extends Addable[String] {
         override def add(left: String, right: String): String = s"$left $right"
      }
      add1("one", "two") //"one two"
      
      add2(Point(1,3), Point(3,5)) // compilation Error, no typeclass implementation for Addable[Point]
      ```
   - Standard library 
      - powerfull collections framework 
      - Scala futures
      
   - Scala and Pure FP
      - Cats
      - ZIO
      - take a look into effects management, referential transparency and function purity and totality
      
 - Frameworks
   - Play Framework, Akka HTTP, Http4S (RESTful HTTP)
   - Anorm, Slick, Doobie (JDBC wrappers, ORM)
   - Akka (Actors framework, inspired by Erlang, very low level for distributed, concurrent applications)
   - Akka Streams, FS2, Monix (reactive streams, pull, push or hibrid design)
   - Circe (Json encoder/decoder based on shapless)
   - Scalacheck (very poerfull concept of property testing)
   - Scalatest
   - also all Java libraries are available including Spring, Java SDK etc, but not recommended to use, because of mutable nature
 