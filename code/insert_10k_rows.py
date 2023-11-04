import mysql.connector
import random
import lorem

# Function to generate random product data
def generate_product_data():
    category_id = random.randint(1, 10)  # Assuming you have 10 categories
    name = f'Product {random.randint(1, 10000)}'
    description = lorem.sentence()

    return (category_id, name, description)

# MySQL database configuration
db_config = {
    'host': 'your_mysql_host',
    'user': 'your_mysql_user',
    'password': 'your_mysql_password',
    'database': 'your_database_name'
}

# Connect to the MySQL database
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

# Create the product table if it doesn't exist
create_table_query = '''
    CREATE TABLE IF NOT EXISTS product (
        product_id INT AUTO_INCREMENT PRIMARY KEY,
        category_id INT,
        name VARCHAR(255),
        description TEXT
    )
'''
cursor.execute(create_table_query)
conn.commit()

# Insert 10,000 rows of data
insert_query = 'INSERT INTO product (category_id, name, description) VALUES (%s, %s, %s)'

for _ in range(10000):
    product_data = generate_product_data()
    cursor.execute(insert_query, product_data)

# Commit the changes and close the database connection
conn.commit()
conn.close()

print("Data inserted successfully.")
