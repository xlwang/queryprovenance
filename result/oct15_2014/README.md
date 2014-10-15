Setup

    createdb qp

Install R packages

    ggplot2
    ddply


To generate graphs:


    # create the database if needed createdb pq
    psql -f queryprovenance3.sql qp
    psql pq -c "copy result to '/tmp/pq.csv' with csv"
    mv /tmp/pq.csv .
    R -f plot.r


# Summary of the plots below


xlwang fills in
