from urllib.parse import quote_plus
from sqlalchemy import create_engine
import getpass

DB_NAME = "Formula1Analytics"

def get_engine():
    password = getpass.getpass("Enter your MySQL password: ")

    engine = create_engine(
        f"mysql+pymysql://root:{quote_plus(password)}@localhost/{DB_NAME}"
    )

    return engine