# Files

create_tables.ddl

* SQL queries to create CUSTOMER table

customer.csv

* comma separated file of CUSTOMER table data

customer_params

* query template parameter values used to generate corrupted query log

gen.py

* python script to read and corrupt CUSTOMER query log

        # get help
        python gen.py --help

        # read queries, corrupt one query, and print them
        python gen.py --bprint

