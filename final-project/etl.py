import pandas as pd
import sqlalchemy

# database connection
engine = sqlalchemy.create_engine("sqlite:///database.db")

# reading the query
with open("etl_project.sql") as open_file:
    query = open_file.read()

dates = [
    '2025-01-01',
    '2025-02-01',
    '2025-03-01',
    '2025-04-01',
    '2025-05-01',
    '2025-06-01',
    '2025-07-01'
]

for i in dates:
    # execute query and bring data to python
    df = pd.read_sql(query.format(date=i), engine)

    # send the python data to the database and insert into the feature_store_cliente table
    df.to_sql("feature_store_cliente", engine, index=False, if_exists="append")