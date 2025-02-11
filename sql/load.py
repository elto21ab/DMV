import pandas as pd
from sqlalchemy import create_engine
import os

# PostgreSQL connection settings
DB_NAME = "airbnb"
DB_USER = "e"  # Replace with your PostgreSQL username
DB_PASSWORD = ""      # Replace with your PostgreSQL password
DB_HOST = "localhost"
DB_PORT = "5432"

# Create SQLAlchemy engine
engine = create_engine(f'postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')

# File paths
files = {
    'calendar': 'data/processed/03_calendar.parquet',
    'listings': 'data/processed/03_listings.parquet',
    'reviews': 'data/processed/03_reviews.parquet'
}

# Load and write each file
for table_name, file_path in files.items():
    print(f"Loading {table_name}...")
    df = pd.read_parquet(file_path)
    
    # Write to PostgreSQL
    df.to_sql(
        name=table_name,
        con=engine,
        if_exists='replace',  # 'replace' will drop existing table and create new one
        index=False,
        chunksize=10000  # Process in chunks to handle large datasets
    )
    print(f"Finished loading {table_name}")

print("All data loaded successfully!")
