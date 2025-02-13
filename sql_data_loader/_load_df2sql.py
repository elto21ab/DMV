import pandas as pd
from sqlalchemy import create_engine
import numpy as np

# PostgreSQL connection settings
DB_NAME = "airbnb"
DB_USER = "e"  # Replace with your PostgreSQL username
DB_PASSWORD = ""      # Replace with your PostgreSQL password
DB_HOST = "localhost"
DB_PORT = "5432"

# Create SQLAlchemy engine
engine = create_engine(f'postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')

# Read and load each parquet file
def load_parquet_to_postgres(file_path, table_name):
    print(f"Loading {table_name}...")
    df = pd.read_parquet(file_path)
    df = df.replace([np.inf, -np.inf], np.nan)  # Handle any infinite values
    df.to_sql(table_name, engine, if_exists='replace', index=False)
    print(f"{table_name} loaded successfully!")

# Load all three datasets
load_parquet_to_postgres('data/processed/03_listings.parquet', 'listings')
load_parquet_to_postgres('data/processed/05_sentiment_bert.parquet', 'reviews') 

print("All data loaded successfully!")
