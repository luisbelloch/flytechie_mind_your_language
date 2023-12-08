DROP TABLE IF EXISTS pancake_orders;

CREATE TABLE IF NOT EXISTS pancake_orders (
    `ts` DateTime,
    `price` Float64,
    `item_count` UInt8,
    `source_country` FixedString(2),
    `coupon_code` FixedString(6)
)
ENGINE = MergeTree
ORDER BY ts;

INSERT INTO pancake_orders SELECT * FROM file('./pancake_orders.10M.parquet', 'Parquet');
