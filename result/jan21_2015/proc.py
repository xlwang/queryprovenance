with file('costdata.tsv', 'r') as f:
  header = f.readline().split()
  print 'perc,TupleID,FalsePositive,modifiedtupleamt,cost,label'
  costs = []
  for l in f:
    vals = map(float, l.split())
    base = [vals[0], vals[1], vals[2], vals[-1]]
    costs.append(base + [vals[2], 'cost1'])
    costs.append(base + [vals[3], 'cost2'])
    costs.append(base + [vals[4], 'cost3'])

  for vals in costs:
    print ','.join(map(str, vals))
