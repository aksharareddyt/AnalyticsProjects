import pandas as pd
from pathlib import Path

from config import get_engine
from utils import clean_dataframe


engine = get_engine()

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR / "Dataset"

tables = [
    "seasons",
    "circuits",
    "constructors",
    "drivers",
    "status",
    "races",
    "results",
    "driver_standings",
    "constructor_standings",
    "constructor_results",
    "qualifying",
    "lap_times",
    "pit_stops",
    "sprint_results"
]

for table in tables:

    print("=" * 50)
    print(f"Importing {table}...")

    file = DATA_DIR / f"{table}.csv"

    df = pd.read_csv(
        file,
        na_values=r"\N"
    )

    df = clean_dataframe(df, table)

    df.to_sql(
        table,
        con=engine,
        if_exists="append",
        index=False
    )

    print(f"✅ {table} imported ({len(df)} rows)")

print("\n ALL TABLES IMPORTED SUCCESSFULLY!")