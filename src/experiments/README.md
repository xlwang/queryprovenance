# How to run synthetic experiments using the harness:


## Configuration Files

Edit a configs file (configs.txt is an example) that defines what configurations to run and what to plot:

        experiment_1
          config
            N_D: 100 1000
            N_q: 5, 10

Experiment name

* `experiment_1` is the both the name of the experiment, and the prefix of the plots that will be generated
  * e.g., `experiment_1_nbadcomplaints.pdf`, `experiment_1_removerate.pdf`
* Each experiment is a record in the `plots` table in the database

Configurations

* the `config` section describes the configuration parameters to vary for an experiment
* each attribute (e.g., `N_D`) is a paramater defined in `configgen.py`
* the syntax to define one or more values for an attribute is

        <attribute>: <number> (SPACE <number>)*

* The harness will generate a cross product of all the configuration values
* Each configuration is a record in the `configs` table
* The default values are defined in `configgen.py`

Plots

* The `plot` section defines how to plot the experimental results.
* For plot attributes `x`, `y`, `group`, `color`, set them to `config` attributes.  
* `y` takes a comma separated list of measurements that you wat to plot along the y axis.
  each measurement will create a new pdf file.  For example

        experiment_1
          plot
            y: badcomplaints, foo

  will produce the files `experiment_1_badcomplaints.pdf` and `experiment_1_foo.pdf`
* The `nruns` attribute is the number of runs for each configuration.  
  We plot the average of all `nruns` runs.


## Generating configurations


* The following lists the commands for the harness:

        python harness.py --help

* The following command creates and stores each configuration parameter in the database

        python harness.py load --fname <config file>

  You can now open `psql queryprov` and query the `plots` and `configs` tables

* You can list the available plots:

        python harness.py list

* Run the configurations for a given plot using the following command.  

        python harness.py run <plotid>

  * It will set up the database states, and query logs, execute the java program, store the results, and
  delete the database states and query logs.  
  * (If I don't delete state, the file system runs out of disk space!)
  * This will cache results and not execute an experimental run if there is already a record for it...

* Use the `--dryrun` flag to print the java commands that will be executed but not run them

        python harness.py --dryrun run <plotid> 

* Generate pdfs:

        python harness.py plot <plotid>
