DROP TABLE transactions;
DROP TABLE item_tags;
DROP TABLE items;
DROP TABLE manufacturers;

CREATE TABLE manufacturers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  website VARCHAR(255)
);

CREATE TABLE tags (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(144),
);

CREATE TABLE items (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255),
  cost INT8,
  price INT8,
  stock_level INT4,
  stock_low INT4,
  stock_medium INT4,
  manufacturer_id INT8 REFERENCES manufacturers(id)
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  _date DATE,
  item_id INT8 REFERENCES items(id),
  amount INT4,
  is_sold BOOLEAN
);

CREATE TABLE item_tags(
  id SERIAL8 PRIMARY KEY,
  tag_id INT8 REFERENCES tag(id),
  item_id INT8 REFERENCES items(id),
);
