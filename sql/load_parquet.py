import pandas as pd
import numpy as np
from sqlalchemy import create_engine, text
import os

# PostgreSQL connection settings
DB_NAME = "airbnb"
DB_USER = "postgres"  # Replace with your PostgreSQL username
DB_PASSWORD = ""      # Replace with your PostgreSQL password
DB_HOST = "localhost"
DB_PORT = "5432"

def get_postgres_type(dtype):
    """Map pandas/numpy dtypes to PostgreSQL data types"""
    if pd.api.types.is_datetime64_any_dtype(dtype):
        return 'TIMESTAMP'
    elif pd.api.types.is_bool_dtype(dtype):
        return 'BOOLEAN'
    elif pd.api.types.is_integer_dtype(dtype):
        return 'BIGINT'
    elif pd.api.types.is_float_dtype(dtype):
        return 'DOUBLE PRECISION'
    elif pd.api.types.is_string_dtype(dtype):
        return 'TEXT'
    else:
        return 'TEXT'  # Default to TEXT for unknown types

def create_table_sql(df, table_name, schema='airbnb'):
    """Generate CREATE TABLE SQL statement based on DataFrame schema"""
    columns = []
    for column, dtype in df.dtypes.items():
        pg_type = get_postgres_type(dtype)
        columns.append(f'"{column}" {pg_type}')
    
    columns_sql = ',\n    '.join(columns)
    return f"""
    DROP TABLE IF EXISTS {schema}.{table_name};
    CREATE TABLE {schema}.{table_name} (
        {columns_sql}
    );
    """

# Create SQLAlchemy engine
engine = create_engine(f'postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')

# Create schema if it doesn't exist
with engine.connect() as conn:
    conn.execute(text("CREATE SCHEMA IF NOT EXISTS airbnb;"))
    conn.commit()

# File paths
files = {
    'calendar': '../data/processed/03_calendar.parquet',
    'listings': '../data/processed/03_listings.parquet',
    'reviews': '../data/processed/03_reviews.parquet'
}

# Load and write each file
for table_name, file_path in files.items():
    print(f"Loading {table_name}...")
    
    # Read parquet file
    df = pd.read_parquet(file_path)
    
    # Replace NaN/None with NULL for PostgreSQL
    df = df.replace({np.nan: None})
    
    # Create table with proper schema
    create_sql = create_table_sql(df, table_name)
    with engine.connect() as conn:
        conn.execute(text(create_sql))
        conn.commit()
    
    # Write to PostgreSQL
    df.to_sql(
        name=table_name,
        schema='airbnb',
        con=engine,
        if_exists='append',  # append since we just created the table
        index=False,
        chunksize=10000,  # Process in chunks to handle large datasets
        method='multi'  # Faster insertion method
    )
    print(f"Finished loading {table_name}")

print("All data loaded successfully!") 