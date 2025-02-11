import pandas as pd
from sqlalchemy import create_engine

class DataManager:
    def init(self, csv_paths: dict, db_uri: str):
        """Initialize with a dictionary of CSV paths and the database URI.
        Parameters:
        csv_paths (dict): A mapping, e.g. {"calendar": "calendar2024.csv", ...}
        db_uri (str): Connection string for PostgreSQL."""
        self.csv_paths = csv_paths
        self.engine = create_engine(db_uri)
        self.dataframes = {}
    
    def load_csvs(self) -> dict:
        """Load each CSV into a Pandas DataFrame."""
        for name, path in self.csv_paths.items():
        self.dataframes[name] = pd.read_csv(path)
        return self.dataframes
   
    def to_db(self, table_name: str, dataframe_key: str) -> None:
        """
        Upload a DataFrame to PostgreSQL.
        Parameters:
        table_name (str): Destination table name in Postgres.
        dataframe_key (str): Key of the DataFrame in self.dataframes.
        """
        if dataframe_key in self.dataframes:
            self.dataframes[dataframe_key].to_sql(table_name, self.engine, if_exists='replace', index=False)
        else:
            raise KeyError(f"DataFrame '{dataframe_key}' not loaded.")

    def query_db(self, query: str) -> pd.DataFrame:
        """
        Run a SQL query and return results as a DataFrame.
        Parameters:
        query (str): SQL query to execute.
        """
        return pd.read_sql(query, self.engine)


# ----- Usage Example -----
if __name__ == '__main__':
    csv_files = {
        'calendar': 'calendar2024.csv',
        'listings': 'listings2024.csv',
        'reviews': 'reviews2024.csv'
    }

    # Update with your PostgreSQL credentials/host/database information.
    db_uri = 'postgresql://user:password@localhost/database'
    manager = DataManager(csv_files, db_uri)
    manager.load_csvs()
    manager.to_db('calendar_table', 'calendar')

    # Now you can mix SQL and Pandas easily:
    result = manager.query_db('SELECT FROM calendar_table LIMIT 10')
    print(result)