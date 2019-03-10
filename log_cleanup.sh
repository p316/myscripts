#!/bin/sh

find /tmp -type d -regex ".*[0-9].*" -mmin +15 | xargs rm -rf
find /tmp -type f  -name "soap_*" -mmin +15 | xargs rm -rf
