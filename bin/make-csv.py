import markdown2
import re
import sys

rings = [ "Adopt", "Trial", "Assess", "Hold" ]
rows = { ring:[] for ring in rings }
quadrants = { "Techniques": 0, "Tools": 0, "Platforms": 0, "Languages & Frameworks": 0 }
if len(sys.argv) == 1:
    raise RuntimeError("Must specify the list of files to parse.")

def writeLine(name, ring, quadrant, description):
    if name != "" and ring != "" and quadrant != "" and description != "":
        try:
            quadrant_index = quadrants.keys().index(quadrant)
            quadrants[quadrants.keys()[quadrant_index]] += 1
            try:
                ring_index = rows.keys().index(ring)
                rows[ring].append([name, quadrant, description])
            except ValueError:
                raise RuntimeError("Invalid ring found [%s]" % ring)
        except ValueError:
            raise RuntimeError("Invalid quadrant found [%s]" % quadrant)

def addPlaceholder(quadrant):
    for ring in rings:
        if len(rows[ring]) == 0:
            writeLine("Placeholder", ring, quadrant, "TBD")
            return
    writeLine("Placeholder", rings[3], quadrant, "TBD")

def unusedQuadrant():
    for quadrant in quadrants.keys():
        if quadrants[quadrant] == 0:
            return quadrant
    return quadrants.keys[0]

file_list = sys.argv[1]
filenames = re.split("\s*;\s*", file_list)

description = ""
name = ""
quadrant = ""
ring = ""
for filename in filenames:
    file = open(filename, "r")
    for line in file:
        quadrant_match = re.match("^#\s+(.*)$", line)
        if quadrant_match:
            writeLine(name, ring, quadrant, description)
            ring = ""
            name = ""
            quadrant = quadrant_match.group(1)
        else:
            ring_match = re.match("^##\s+(.*)$", line)
            if ring_match:
                writeLine(name, ring, quadrant, description)
                name = ""
                ring = ring_match.group(1)
            else:
                name_match = re.match("^###\s+(.*)$", line)
                if name_match: 
                    writeLine(name, ring, quadrant, description)
                    name = name_match.group(1)
                    description = ""
                else:
                    description += line
writeLine(name, ring, quadrant, description)

for quadrant in quadrants.keys():
    if quadrants[quadrant] == 0:
        addPlaceholder(quadrant)

for ring in rings:
    if len(rows[ring]) == 0:
        addPlaceholder(unusedQuadrant())

print "name,ring,quadrant,isNew,description"
for ring in rings:
    for row in rows[ring]:
        print "\"%s\",\"%s\",\"%s\",FALSE,\"%s\"" % (row[0], ring, row[1], markdown2.markdown(row[2]).strip())
