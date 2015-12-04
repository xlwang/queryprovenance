#!/bin/bash

for d in */ ; do
  cd $d; sh setup.sh; python plot.py; cd -;
done