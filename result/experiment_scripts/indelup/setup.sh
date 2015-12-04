#!/bin/bash

dropdb queryprovindel; createdb queryprovindel
psql -f exps_insert_delete_update.sql queryprovindel
psql -f ../setup.ddl queryprovindel