import pandas as pd

# student_data = [[1,15],[2,11],[3,11],[4,20]]

# df = pd.DataFrame(student_data, columns=["student_id", "age"])

# print(df)

# import pandas as pd

def createDataframe(student_data):
    # Convert the 2D list to a DataFrame with proper column names
    return pd.DataFrame(student_data, columns=["student_id", "age"])


    