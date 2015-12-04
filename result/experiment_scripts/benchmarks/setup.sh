#!/bin/bash

dropdb queryprovauction; createdb queryprovauction
psql -f auctionmark_exps.sql queryprovauction
psql -f ../setup.ddl queryprovauction

dropdb queryprovtpcc; createdb queryprovtpcc
psql -f tpcc_exps.sql queryprovtpcc
psql -f ../setup.ddl queryprovtpcc