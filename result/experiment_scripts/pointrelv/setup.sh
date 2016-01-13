#!/bin/bash

dropdb queryprovpointrelv
createdb queryprovpointrelv
psql -f pointrelative.sql queryprovpointrelv
psql -f ../setup.ddl queryprovpointrelv