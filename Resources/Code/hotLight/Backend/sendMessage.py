#!/usr/bin/python3
# ^ that should be the path to your python

import SMS  # should be another .py file in this same directory
import sys  # I believe this comes pre-packaged with python3, but you might have to install it

SMS.send(sys.argv[1])   # all this script does is pass argv[1] into SMS's send() method
