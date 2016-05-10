#!/usr/bin/env python2.7
import os
import sys

if len(sys.argv) != 3:
    print "Usage: render_config <template_file> <output_file>"
    sys.exit(1)

template_filename = sys.argv[1]
output_filename = sys.argv[2]

with open(template_filename, 'r') as template:
   template_data = template.read()

failure = False
# Securely create file for current user
flags = os.O_WRONLY | os.O_CREAT
with os.fdopen(os.open(output_filename, flags, 0o600), 'w') as output:
    kwargs = { k: v for k, v in os.environ.items()
               if k.startswith('LS_') }
    try:
        output_data = template_data % kwargs
        output.write(output_data)
    except KeyError,e:
        failure = True
        print "Missing environment variable {}".format(str(e))

if failure:
    sys.exit(1)
