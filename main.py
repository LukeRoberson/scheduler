"""
Module: main.py

Schedule tasks to run regularly
    This is a simple scheduler that will be improved in the future.

Usage:
    This is a Flask application that should run behind a WSGI server inside
        a Docker container.
    Build the Docker image and run it with the provided Dockerfile.

Dependencies:
    - time: For sleep functionality.
    - requests: For making HTTP requests to refresh the token.
"""

import time
import requests

TOKEN_URL = "http://security:5100/api/refresh_token"

# Run forever
while True:
    # Wait for 55 minutes before the next run
    time.sleep(60 * 55)

    # Refresh the token
    try:
        r = requests.get(TOKEN_URL)
        print("Refresh result:", r.text)

    # Handle errors
    except Exception as e:
        print("Error refreshing token:", e)
