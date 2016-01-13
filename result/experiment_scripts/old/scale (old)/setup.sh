#!/bin/bash

dropdb queryprov
createdb queryprov
psql -f all_no_lotsize.sql queryprov
psql -f ../setup.ddl queryprov