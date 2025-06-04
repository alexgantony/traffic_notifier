from pathlib import Path

from sqlmodel import create_engine

BASE_DIR = Path(__file__).resolve().parent  # backend/database
sqlite_file_name = BASE_DIR / "database.db"

# TODO: Remove echo=True
# sql_file_name = "database.db"
engine = create_engine(f"sqlite:///{sqlite_file_name}", echo=True)
# echo - to log sql statements being executes (useful for debugging)
