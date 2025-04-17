# Base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy all Django app files
COPY . .

# Expose Cloud Run port
EXPOSE 8080

# Run using gunicorn (change `your_project` to your Django project name)
CMD gunicorn your_project.wsgi:application --bind 0.0.0.0:8080
