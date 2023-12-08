import pyarrow.parquet as pq

orders = pq.read_table("./pancake_orders.10M.parquet")
totals = orders.group_by("source_country").aggregate([("price", "sum")])
print(totals)
