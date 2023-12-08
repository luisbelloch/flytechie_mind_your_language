import pandas as pd

orders = pd.read_csv("./pancake_orders.10M.csv")
orders.to_parquet(path="pancake_orders.10M", engine="pyarrow", partition_cols=["source_country"])
orders.to_parquet(path="pancake_orders.10M.flat.parquet", engine="pyarrow")
