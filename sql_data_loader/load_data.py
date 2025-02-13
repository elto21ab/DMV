import pandas as pd
from sqlalchemy import create_engine
import numpy as np

# PostgreSQL connection settings
DB_PARAMS = {
    'host': 'localhost',
    'database': 'airbnb',
    'user': 'bastianmeyer',    # Change this to your PostgreSQL username
    'password': ''  # Change to your PostgreSQL password
}

# Create SQLAlchemy engine
engine = create_engine(f"postgresql://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}/{DB_PARAMS['database']}")

# Read and load each parquet file
def load_parquet_to_postgres(file_path, table_name):
    print(f"Loading {table_name}...")
    df = pd.read_parquet(file_path)
    df = df.replace([np.inf, -np.inf], np.nan)  # Handle any infinite values
    df.to_sql(table_name, engine, if_exists='replace', index=False)
    print(f"{table_name} loaded successfully!")

# Load all three datasets
load_parquet_to_postgres('data/processed/05_listings.parquet', 'listings')
load_parquet_to_postgres('data/processed/05_sentiment_bert.parquet', 'reviews') #- Wait with this until we have the sentiment scores

print("All data successfully loaded into PostgreSQL!") 