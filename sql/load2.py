import pandas as pd
import subprocess  # Import the subprocess module
import os

# PostgreSQL connection settings
DB_NAME = "airbnb"
DB_USER = "postgres"
DB_PASSWORD = "your_actual_password"  # REPLACE WITH YOUR PASSWORD
DB_HOST = "localhost"
DB_PORT = "5432"

files = {
    'calendar': 'data/processed/03_calendar.parquet',
    'listings': 'data/processed/03_listings.parquet',
    'reviews': 'data/processed/03_reviews.parquet'
}

for table_name, file_path in files.items():
    df = pd.read_parquet(file_path)

    # Create a CSV string in memory
    csv_data = df.to_csv(index=False, header=True)

    # Construct the COPY command
    copy_command = f"""
    \\copy {table_name} FROM STDIN WITH (FORMAT CSV, HEADER)
    """

    # Execute the COPY command using psql
    command = [
        "psql",
        "-U", DB_USER,
        "-d", DB_NAME,
        "-h", DB_HOST,
        "-p", DB_PORT,
        "-c", copy_command  # Pass the COPY command
    ]

    # Use subprocess.run to execute the command and pipe the CSV data
    try:
        process = subprocess.run(
            command,
            input=csv_data,  # Pipe the CSV data to STDIN
            text=True,  # Handle text input/output
            capture_output=True,  # Capture stdout and stderr
            check=True  # Raise an exception for non-zero exit codes
        )
        print(f"Successfully imported {table_name}")
        # Optionally, print stdout and stderr from psql
        #print("psql output:", process.stdout)
        #print("psql errors:", process.stderr)

    except subprocess.CalledProcessError as e:
        print(f"Error importing {table_name}:")
        print("  Return code:", e.returncode)
        print("  Stdout:", e.stdout)
        print("  Stderr:", e.stderr)