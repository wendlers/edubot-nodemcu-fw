import time
import requests

while True:

	r = requests.get("http://192.168.1.112/range");

	if r.status_code == 200:
		j = r.json()
		print("%d Distance %s cm" % (time.time(), j["d"]))

	time.sleep(0.1)
