import pandas as pd
from tabulate import tabulate

orders = pd.read_csv("./pancake_orders.10M.csv", usecols=['source_country', 'price'])
totals = orders.groupby(by=["source_country"]).sum()

print(tabulate(totals, headers=['Country', 'Total'], tablefmt='psql'))
