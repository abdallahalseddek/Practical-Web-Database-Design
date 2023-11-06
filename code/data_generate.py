import time
sql = "INSERT INTO userinfo (`name`, `email`, `password`, `dob`, `address`, `city`, `state_id`, `zip`, `country_id`, `account_type`, `closest_airport`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
params = [
    "John", "john.smith@email.com", "1234", "1986-02-14",
    "1795 Santiago de Compostela Way", "Austin", "1", "18743", "1", "customer account", "aut"
]
state_id = 0
start_time = time.time()
for x in range(0, 10000000):
    if (x % 100 == 0):
        state_id += 1
    result = session.run_sql(sql, (params[0], params[1]+str(x) , params[2], params[3], params[4], params[5], state_id, params[7], params[8], params[9], params[10]))

total_time = time.time() - start_time
print("Total time: %s seconds" % total_time)
