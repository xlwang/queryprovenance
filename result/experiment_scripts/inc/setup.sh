#!/bin/bash

dropdb queryprovinc
createdb queryprovinc
psql -f inc.sql queryprovinc
psql -f ../setup.ddl queryprovinc