-- CREACIÓN DE TABLAS

-- Categorías del menú
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Platos
CREATE TABLE dishes (
    dish_id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories(category_id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    available BOOLEAN DEFAULT TRUE
);

-- Ingredientes
CREATE TABLE ingredients (
    ingredient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    unit_cost NUMERIC(10, 2) NOT NULL
);

-- Relación platos-ingredientes
CREATE TABLE dish_ing (
    dish_id INT REFERENCES dishes(dish_id),
    ingredient_id INT REFERENCES ingredients(ingredient_id),
    PRIMARY KEY (dish_id, ingredient_id)
);

-- Mesas
CREATE TABLE tables (
    table_id SERIAL PRIMARY KEY,
    number INT NOT NULL,
    capacity INT NOT NULL,
    state VARCHAR(20) CHECK (state IN ('free', 'occupied', 'reserved')) NOT NULL
);

-- Bartenders
CREATE TABLE bartenders (
    bartender_id SERIAL PRIMARY KEY,
    document VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- Comandas (órdenes)
CREATE TABLE commands (
    command_id SERIAL PRIMARY KEY,
    table_id INT REFERENCES tables(table_id),
    bartender_id INT REFERENCES bartenders(bartender_id),
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    state VARCHAR(20) CHECK (state IN ('preparation', 'served', 'closed')) NOT NULL
);

-- Relación platos-comandas
CREATE TABLE dish_com (
    dish_id INT REFERENCES dishes(dish_id),
    command_id INT REFERENCES commands(command_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (dish_id, command_id)
);

-- Facturación
CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    command_id INT REFERENCES commands(command_id),
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(10, 2) NOT NULL,
    payment_form VARCHAR(20) CHECK (payment_form IN ('cash', 'credit card')) NOT NULL
);


INSERT INTO categories (category_id, name, description) VALUES
(1, 'Category 1', 'Early ready put outside large better.'),
(2, 'Category 2', 'Go start indeed understand try.'),
(3, 'Category 3', 'Clearly hot get wall.'),
(4, 'Category 4', 'Practice investment before wide million.'),
(5, 'Category 5', 'Pass third born Republican.');

INSERT INTO dishes (dish_id, category_id, name, description, price, available) VALUES
(1, 5, 'Sancocho', 'Avoid father whole different.', 27.44, TRUE),
(2, 2, 'Arroz con pollo', 'Talk action yes me wrong card.', 25.63, TRUE),
(3, 1, 'Carne con arroz', 'Like order specific bring.', 19.05, TRUE),
(4, 3, 'Pastas con queso', 'Fire choose business fill believe place.', 9.00, TRUE),
(5, 4, 'Frijoles con garra', 'Feeling hospital foreign could.', 28.26, TRUE);

INSERT INTO ingredients (ingredient_id, name, stock, available, unit_cost) VALUES
(1, 'Cebolla', 79, TRUE, 1.18),
(2, 'Tomate', 19, TRUE, 3.14),
(3, 'Lechuga', 124, FALSE, 3.51),
(4, 'Carne', 350, TRUE, 2.36),
(5, 'Pollo', 338, FALSE, 3.30),


INSERT INTO tables (table_id, number, capacity, state) VALUES
(1, 1, 4, 'occupied'),
(2, 2, 2, 'free'),
(3, 3, 2, 'reserved'),
(4, 4, 7, 'reserved'),
(5, 5, 5, 'occupied');

INSERT INTO bartenders (bartender_id, document, name, last_name, phone, email) VALUES
(1, '79742924', 'Kenneth', 'Williams', '(976)921-6274', 'jeanette19@smith.biz'),
(2, '68846538', 'Don', 'Phelps', '314.702.6556x43292', 'russellhayes@robbins.com'),
(3, '64489443', 'Michele', 'Dorsey', '038.616.6047x274', 'walkershawn@yahoo.com'),
(4, '89200270', 'Logan', 'Conner', '1091391289', 'jennifer34@baker.org'),
(5, '50173199', 'Tammy', 'Kramer', '681.053.4024', 'lisa43@hotmail.com');
