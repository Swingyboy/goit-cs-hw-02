# Use Python 3.10 base image
FROM python:3.10

# Set environment variables
ENV PORT=8080

# Set working directory in the container
WORKDIR /app

# Copy requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the entire current directory into the container
COPY . .

# Expose the port your app runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["python", "main.py"]
