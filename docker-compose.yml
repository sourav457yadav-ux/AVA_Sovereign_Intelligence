FROM python:3.11-slim

WORKDIR /app

# Copy repository contents
COPY . /app

# Install dependencies if requirements.txt exists
RUN if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

# Make scripts executable
RUN chmod +x ./start_sequence.sh

# Default command: run start sequence (maps iron to sentinel_shield if present)
CMD ["./start_sequence.sh", "--map-iron=sentinel_shield.py"]