CREATE DATABASE contacts; 
CREATE TABLE categories( 
  cat_id SERIAL PRIMARY KEY, 
  name VARCHAR(100) 
); 
CREATE TABLE contacts( 
  c_id SERIAL PRIMARY KEY, 
  name VARCHAR(100), 
  phone VARCHAR(20), 
  email VARCHAR(100), 
  summary TEXT, 
  address TEXT, 
  cat_id INTEGER, 
  FOREIGN KEY (cat_id) REFERENCES categories(cat_id) 
); 
