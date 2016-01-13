#!/bin/bash

dropdb queryprovdbsize
createdb queryprovdbsize
psql -f dbsize.sql queryprovdbsize
psql -f ../setup.ddl queryprovdbsize