#!/usr/bin/env python
import sys, os, hashlib
myhash = {}

def file_as_bytes(file):
    with file:
        return file.read()

if len(sys.argv) == 1:
    path = "/Users/pradeep/Documents/Pradeep/"
else:
    path = sys.argv[0]

print "Scanning folders or files from path %s"%path
for root, dirs, files in os.walk(path):
    for name in files:
        filepath = os.path.join(root, name)
        filehash = hashlib.md5(file_as_bytes(open(filepath, 'rb'))).hexdigest()
        print filepath filehash 
