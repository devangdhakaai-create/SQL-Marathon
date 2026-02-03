import pandas as pd
def find_customer_referee(customer):
    return customer.loc[
        (customer["referee_id"] != 2) | (customer["referee_id"].isna()),
        ["name"]
    ]