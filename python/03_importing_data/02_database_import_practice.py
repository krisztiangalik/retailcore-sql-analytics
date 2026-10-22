import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text


load_dotenv()

user = os.getenv("POSTGRES_USER")
password = os.getenv("POSTGRES_PASSWORD")
host = os.getenv("POSTGRES_HOST")
port = os.getenv("POSTGRES_PORT")
database = os.getenv("POSTGRES_DB")

engine = create_engine(
    f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}"
)

with engine.connect() as connection:
    result = connection.execute(text("SELECT 1"))
    print(result.fetchone())