import time

# Make sure to import your database library and create a session/connection.

# Assuming you're using a placeholder like %s (this syntax may vary based on your database library)
sql = "INSERT INTO `userinfo` ('name', 'email', 'password', 'dob', 'address', 'city', 'state_id', 'zip', 'country_id', 'account_type', 'closest_airport') VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

# Parameters for the insert query
params = ["John", "john.smith@email.com", "1234", "1986-02-14", "1795 Santiago de Compostela Way", "Austin", None, "18743 , 1", "customer account", "aut"]

# Assuming you want to start with state_id 0
state_id = 0

# Start measuring time
start_time = time.time()

# Assuming you have a database session (e.g., using pymysql or psycopg2)
for x in range(0, 1000000):
    # Increment state_id by 1 for each iteration
    state_id += 1

    # Create a tuple of parameters
    params_tuple = (params[0], params[1], params[2], params[3], params[4], params[5], state_id, params[7], params[8], params[9])

    # Execute the SQL query
    result = session.run_sql(sql, params_tuple)

# Calculate total time
total_time = time.time() - start_time

# Print the total time
print("Total time: %s seconds" % total_time)
