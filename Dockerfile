# Use the official Python image from the Docker Hub
# This tag is the latest Alpine with the latest Python 3.12
FROM python:3.12-alpine
LABEL description="A task scheduler"
LABEL version="1.0.0"

# Create non-root user with no password
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Set the working directory in the container
WORKDIR /app

# Change ownership of the application code to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Copy the requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Start the application (unbuffered mode so we can see terminal output)
CMD ["python", "-u", "/app/main.py"]
