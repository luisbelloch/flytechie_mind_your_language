import pyarrow.csv as csv
import pyarrow.parquet as pq

column_types = {
  'ts': 'timestamp[ms]',
  'price': 'float64',
  'item_count': 'int32',
  'source_country': 'string',
  'coupon_code': 'string'
}

csv_table = csv.read_csv('pancake_orders.10M.csv',
      read_options=csv.ReadOptions(column_names=column_types.keys(), skip_rows=1),
      parse_options=csv.ParseOptions(delimiter=','),
      convert_options=csv.ConvertOptions(column_types=column_types))

pq.write_table(csv_table, 'pancake_orders.10M.parquet')
