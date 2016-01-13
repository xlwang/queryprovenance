#!/bin/bash

dropdb queryprovattr100
createdb queryprovattr100
psql -f attr100.sql queryprovattr100
psql -f ../setup.ddl queryprovattr100