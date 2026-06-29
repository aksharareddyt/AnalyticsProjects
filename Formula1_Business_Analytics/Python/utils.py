import pandas as pd


def clean_dataframe(df, table_name):
    """
    Cleans a dataframe before loading into MySQL.
    """

    # Replace \N with NULL
    df = df.replace(r"\N", pd.NA)

    # Replace NaN with None
    df = df.where(pd.notnull(df), None)

    # Rename reserved SQL keywords
    if table_name == "results":
        if "rank" in df.columns:
            df.rename(
                columns={"rank": "fastestLapRank"},
                inplace=True
            )

    return df