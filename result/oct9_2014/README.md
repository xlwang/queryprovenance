To generate graphs:


    # create the database if needed createdb pq
    psql -f queryprovenance2.sql qp
    psql pq -c "copy result to '/tmp/pq.csv' with csv"
    mv /tmp/pq.csv .
    R -f plot.r