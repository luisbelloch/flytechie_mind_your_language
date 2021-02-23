import pandas as pd
from tabulate import tabulate

orders = pd.read_parquet("./pancake_orders.10M", columns=['source_country', 'price'])
totals = orders.groupby(by=["source_country"]).sum()

print(tabulate(totals, headers=['Country', 'Total'], tablefmt='psql'))
