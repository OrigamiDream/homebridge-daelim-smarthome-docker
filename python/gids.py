#!/bin/python

import pwd
import os

print(pwd.getpwuid(os.getuid()).pw_gid)
