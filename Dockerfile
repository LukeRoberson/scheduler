# Use the official Python image from the Docker Hub
# This tag is the latest Alpine with the latest Python 3.12
FROM python:3.12-alpine

# OCI labels for the image
LABEL org.opencontainers.image.title="AI Assistant Task Scheduler"
LABEL org.opencontainers.image.description="A simple service to schedule tasks. For example, to refresh API tokens before they expire."
LABEL org.opencontainers.image.base.name="python:3.12-alpine"
LABEL org.opencontainers.image.source="https://github.com/LukeRoberson/scheduler"
LABEL org.opencontainers.image.version="1.0.0"

# The health check URL for the service
LABEL net.networkdirection.healthz="http://localhost:5100/api/health"

# The name of the service, as it should appear in the compose file
LABEL net.networkdirection.service.name="scheduler"

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
