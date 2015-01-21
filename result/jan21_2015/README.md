
Steps to generate charts for cost metric scores for false positives

1. get data in format of `perc,TupleID,FalsePositive,modifiedtupleamt,cost,label`
2. place data in costdata.tsv as space or tab delimited file
3. run script

    python proc.py > costdata.csv

4. run R

    R -f plot.r