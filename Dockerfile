# Step 1: Use an official lightweight Python image
FROM python:3.11-slim

# Step 2: Set working directory in container
WORKDIR /app

# Step 3: Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 4: Copy the rest of the app
COPY . .

# Step 5: Expose port
EXPOSE 5000

# Step 6: Run the Flask app
CMD ["python", "app.py"]

