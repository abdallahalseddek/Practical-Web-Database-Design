import mysql.connector
import random
import faker

# Connect to the MySQL database
connection = mysql.connector.connect(
    host="localhost",
    user="your_username",
    password="your_password",
    database="your_database"
)
cursor = connection.cursor()

# Create tables if they don't exist
cursor.execute("CREATE TABLE IF NOT EXISTS customers (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255))")
cursor.execute("CREATE TABLE IF NOT EXISTS products (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), price DECIMAL(10, 2))")
cursor.execute("CREATE TABLE IF NOT EXISTS orders (id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT, order_date DATE)")
cursor.execute("CREATE TABLE IF NOT EXISTS order_details (id INT AUTO_INCREMENT PRIMARY KEY, order_id INT, product_id INT, quantity INT)")

# Generate random data for customers and products
fake = faker.Faker()
customers = [(fake.name(), fake.email()) for _ in range(1000)]
products = [(fake.unique.first_name(), round(random.uniform(1, 100), 2)) for _ in range(100)]

# Insert customer data
cursor.executemany("INSERT INTO customers (name, email) VALUES (%s, %s)", customers)
connection.commit()

# Insert product data
cursor.executemany("INSERT INTO products (name, price) VALUES (%s, %s)", products)
connection.commit()

# Generate and insert order data
for _ in range(100000):
    customer_id = random.randint(1, 1000)
    order_date = fake.date_of_birth(minimum_age=18, maximum_age=65)
    cursor.execute("INSERT INTO orders (customer_id, order_date) VALUES (%s, %s)", (customer_id, order_date))
connection.commit()

# Generate and insert order_details data
for _ in range(100000):
    order_id = random.randint(1, 100000)
    product_id = random.randint(1, 100)
    quantity = random.randint(1, 10)
    cursor.execute("INSERT INTO order_details (order_id, product_id, quantity) VALUES (%s, %s, %s)", (order_id, product_id, quantity))
connection.commit()

# Close the database connection
connection.close()

print("Data inserted successfully.")
