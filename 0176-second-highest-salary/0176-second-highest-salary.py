import pandas as pd

def second_highest_salary(Employee):
    salaries = Employee["salary"].drop_duplicates().sort_values(ascending=False)
    
    if len(salaries) < 2:
        result = None
    else:
        result = salaries.iloc[1]
    return pd.DataFrame({"SecondHighestSalary": [result]})


