import time
query = ("SELECT count(*) FROM userinfo WHERE 'name' =? AND 'state_id' =?", ['John100',100])

nb_of_requests  = 30
start_time = time.time()
for x in range(0, nb_of_requests):
    sql = query [0]
    param = query[1]
    result = session.run_sql(sql,(param[0] ,param[1],))
total_time = time.time() - start_time
qps = nb_of_requests / total_time
print("Total time: %s seconds" % total_time)
print("--- %s QPS ---" % qps)