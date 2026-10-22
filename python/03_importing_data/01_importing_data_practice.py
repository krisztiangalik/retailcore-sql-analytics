######## Opening and reading file:
file = open("python/03_importing_data/data/stores.txt", "r")
content = file.read()
print(content)
file.close()

######## Opening and reading file by lines with "with":
with open("python/03_importing_data/data/stores.txt", "r") as file:
    for line in file:
        print(line.strip())

######## Get the stores and revenue in different variables:
with open("python/03_importing_data/data/stores.txt", "r") as file:
    for line in file:
        parts = line.strip().split(",")

        store = parts[0]
        revenue = parts[1]

        print(store, revenue)

######## Numpy loading file: (this is not working, because the next practice)
#import numpy as np

#data = np.loadtxt(
#    "python/03_importing_data/data/revenues.csv",
#    delimiter = ",",
#    dtype = int
#)
#print(data)

######## After adding header in the revenues.csv: (this is not working, because the next practice)
#import numpy as np

#data = np.loadtxt(
#    "python/03_importing_data/data/revenues.csv",
#    delimiter = ",",
#    dtype = int,
#    skiprows = 1
#)
#print(data)

######## After adding Store names to the revenues.csv:(for this pandas is better than numpy)
import numpy as np

data = np.genfromtxt(
    "python/03_importing_data/data/revenues.csv",
    delimiter = ",",
    names = True,
    dtype = None,
    encoding = "utf-8"
)
print(data)

######## same practice with pandas:
import pandas as pd

df = pd.read_csv("python/03_importing_data/data/revenues.csv")

print(df)
print(df.head())
print(df.dtypes)
print(df.shape)

######## use pandas to read csv, but only for specified columns:
import pandas as pd

df = pd.read_csv("python/03_importing_data/data/revenues.csv", usecols = ["store", "revenue"])

print(df)

######## loading excel:
import pandas as pd

excel_file = pd.ExcelFile(
    "python/03_importing_data/data/store_sales.xlsx",
)
sales_df = excel_file.parse("Sales")
print(excel_file.sheet_names)
print(sales_df)

all_sheets = pd.read_excel(
    "python/03_importing_data/data/store_sales.xlsx",
    sheet_name=None
)

print(all_sheets)
print(all_sheets.keys())

sales_df = all_sheets["Sales"]
stores_df = all_sheets["Stores"]

print(sales_df)
print(stores_df)

######## Pickle practice
sales_summary = {
    "Store_A": 1200,
    "Store_B": 950,
    "Store_C": 1430
}
import pickle

with open("python/03_importing_data/data/sales_summary.pkl", "wb") as file:
    pickle.dump(sales_summary, file)

with open("python/03_importing_data/data/sales_summary.pkl", "rb") as file:
    loaded_sales = pickle.load(file)

print(loaded_sales)

######## SAS, STATA, MATLAB and HDF5 files:
#import pandas as pd

#df_sas = pd.read_sas("data_file.sas7bdat")
#df_stata = pd.read_stata("data_file.dta")

#import h5py

#file = h5py.File("data_file.hdf5", "r")

#print(list(file.keys()))

#file.close()

#from scipy.io import loadmat

#data = loadmat("data_file.mat")

#print(data.keys())