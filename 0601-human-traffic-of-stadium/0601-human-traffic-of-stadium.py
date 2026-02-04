import pandas as pd

def human_traffic(stadium: pd.DataFrame) -> pd.DataFrame:
    df = stadium[stadium["people"] >= 100].copy()

    # Identify breaks in consecutive ids
    df["grp"] = (df["id"].diff() != 1).cumsum()

    # Keep only groups with length >= 3
    df = df.groupby("grp").filter(lambda x: len(x) >= 3)

    return df[["id", "visit_date", "people"]].sort_values("visit_date")

