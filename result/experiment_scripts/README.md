Setup

* install libraries

        pip install pygg
        pip install sqlalchemy
        pip install wuutils

* install R and ggplot2


To run all the scripts run:

        sh setup.sh


This script goes into each directory and runs

        # in the directory:
        sh setup.sh
        python plot.py

To clean databases created for the experiments

        sh clean.sh