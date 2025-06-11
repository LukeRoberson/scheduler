"""
Schedule a task to run regularly
This is a simple scheduler that will be improved in the future.
"""

import time
import requests


REFRESH_TOKEN_URL = "http://security:5100/api/refresh_token"


print("Starting the scheduler")

# Run forever
while True:
    # Wait for 55 minutes before the next run
    time.sleep(60*55)

    # Refresh the token
    try:
        r = requests.get(REFRESH_TOKEN_URL, timeout=3)
        print("Refresh result:", r.text)

    # Handle errors
    except Exception as e:
        print("Error refreshing token:", e)
