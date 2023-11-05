import time
import mysql.connector

# Establish a connection to the database
conn = mysql.connector.connect(user='your_user', password='your_password', database='your_database')
cursor = conn.cursor()

# Define the INSERT query template
insert_query = "INSERT INTO userinfo (`name`, `email`, `password`, `dob`, `address`, `city`, `state_id`, `zip`, `country_id`, `account_type`, `closest_airport`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

# Start measuring time
start_time = time.time()

# Assuming you want to insert 1,000,000 rows
max_rows = 1000000
state_id = 0

# Use a transaction for bulk insert
try:
    conn.start_transaction()

    for x in range(max_rows):
        state_id += 1
        values = (
            f'John{x}',
            'john.smith@email.com',
            '1234',
            '1986-02-14',
            '1795 Santiago de Compostela Way',
            'Austin',
            state_id,
            '18743',  # Split the zip and country_id
            1,  # Provide a separate value for country_id
            'customer account',
            'aut'
        )
        cursor.execute(insert_query, values)

    conn.commit()  # Commit the transaction

except Exception as e:
    conn.rollback()  # Rollback the transaction if an error occurs
    print(f"Error: {e}")

finally:
    cursor.close()
    conn.close()

# Calculate total time
total_time = time.time() - start_time
print("Total time: %s seconds" % total_time)

