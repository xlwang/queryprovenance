Setup

* install libraries

        pip install pygg
        pip install sqlalchemy
        pip install wuutils

* install R and ggplot2


To run this you need to 

1. create a new database
2. load the sql file
3. add mappings between the experiment algorithm names (e.g., solver+opt_approx) and names used in the paper
4. run script to generate plots

You can do this using the following commands

        # does steps 1 - 3
        sh setup.sh

        python plot.py
