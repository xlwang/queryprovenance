Setup

    createdb qp

Install R packages

    ggplot2
    ddply


To generate graphs:


    # create the database if needed createdb pq
    psql -f queryprovenance2.sql qp
    psql pq -c "copy result to '/tmp/pq.csv' with csv"
    mv /tmp/pq.csv .
    R -f plot.r


I plotted the same metrics plus a couple others:

1. correctidx: was the index of the query that was fixed correct?
2. correctsize: was the fixed query structure (# clauses) the same as the correct query for all runs?
3. correctsizecondidx: the above, but only for runs where we picked the correct query to fix.
4. diffidx: the difference between the real query index and the fixed, to see if we are making a skewed mistake

Some interesting points:

correctidx: 

* DT gets the index more wrong when the # clauses goes up.  Correlation not obvious for dbsize or logsize (!)

correctsize

* looks like correctidx

correctsizecondidx:

* flat.  if we find the right query, we get the structure rigt

diffidx:

* the difference we pick appears random
* the variance increases with decreasing dbsize (less examples), and increasing logsize and cardinality

totaltime:

* exponential relationship with dbsize
* exponential relationship with cardinality
