-- Create Category Table
CREATE TABLE category (
category_id INT PRIMARY KEY,
category_name VARCHAR(255) NOT NULL
);

-- Create Product Table
CREATE TABLE product (
 product_id INT PRIMARY KEY,
 category_id INT NOT NULL ,
 name VARCHAR(255) NOT NULL,
 description TEXT,
 price DECIMAL(10, 2) NOT NULL,
 stock_quantity INT NOT NULL,
 FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- Create Customer Table
CREATE TABLE customer (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  hashed_password VARCHAR(255) NOT NULL
);
-- Create Order Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

-- Create Order Details Table
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);


-- Indexes
CREATE INDEX idx_product_category_id ON product (category_id);
CREATE INDEX idx_order_customer_id ON orders (customer_id);
CREATE INDEX idx_order_details_order_id ON order_details (order_id);
CREATE INDEX idx_order_details_product_id ON order_details (product_id);
CREATE INDEX idx_customer_email ON customer (email);

