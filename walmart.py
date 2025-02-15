# import kagglehub
import pandas as pd
import psycopg2
from sqlalchemy import create_engine
# Download latest version
# path = kagglehub.dataset_download("najir0123/walmart-10k-sales-datasets")
# 
# print("Path to dataset files:", path)
# df = pd.read_csv("Walmart.csv")
# print(df)
# If I want to find any duplicated values in my dataset.
# duplicates = df[df.duplicated()]
# print(duplicates)

# If I want to delete the duplicated values in my dataset
# df.drop_duplicates(inplace = True)
# print(df)

#  I want to find the all null values
# null_values = df.isnull()
# print(null_values)

# To delete the null values
# df.dropna(inplace=True)
# print(df)

# print(df.shape)

# print(df.dtypes)
# df['unit_price'] = df['price'].str.replace('$','').astype(float)
# print(df)
# print(df.dtypes)

# df['total'] = df['unit_price'] * df['quantity']
# print(df['quantity'])
# print(df['unit_price'])
# print(df['total'])

# print(df.shape)



db_params = {
    "user": "postgres",
    "password": "12345678",
    "host": "localhost",
    "port": "5432",
    "dbname": "walmart_details"
}

# import os
# print(os.getcwd()) 

df = pd.read_csv(r"C:\Users\HP\Desktop\project walmart\walmart\Walmart.csv")
df.columns = df.columns.str.lower()
df.dropna(inplace = True)
df.drop_duplicates(inplace = True)
df['unit_price'].str.replace('$','').astype(float)
# print(c)
print(df.columns)

# print(df.head())
# import os
# print("Current Directory:", os.getcwd())  # Prints the working directory

# df = pd.read_csv("Walmart.csv")  # If file is not found, it's in a different directory
 
# df = pd.read_csv(r"C:\Users\HP\Downloads\walmart dataset\Walmart.csv")

engine_psql = create_engine(f"postgresql+psycopg2://{db_params['user']}:{db_params['password']}@{db_params['host']}:{db_params['port']}/{db_params['dbname']}")

try:
    engine_psql
    print("Connected to postgresql")
except:
    print("Connection failed")

df.to_sql('walmart', engine_psql, if_exists='append', index=False)
print("Data inserted successfully")

