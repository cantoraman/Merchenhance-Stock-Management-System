DROP TABLE shop_log;
DROP TABLE items;
DROP TABLE manufacturers;

CREATE TABLE manufacturers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
  website VARCHAR(255)
);

CREATE TABLE items (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255),
  tag VARCHAR(144),
  cost INT4,
  price INT4,
  stock_level INT4,
  stock_low INT4,
  stock_medium INT4
  manufacturer_id INT8 REFERENCES manufacturers(id)
);

CREATE TABLE shop_log (
  id SERIAL4 PRIMARY KEY,
  _date DATE,
  item_id INT8 REFERENCES items(id),
  amount INT4,
  sold? BOOLEAN
);
