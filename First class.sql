In the first class we worked on creation of a contacts data base in the terminal. 

From the terminal, type: 
  
  sudo -u postgres psql
  CREATE DATABASE contacts;
  CREATE TABLE categories(
    cat_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
  );
  CREATE TABLE contacts (
    c_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    summary TEXT,
    address TEXT,
    cat_id INTEGER,
    FOREING KEY (cat_id) REFERENCES categories(cat_id)
  );

  
