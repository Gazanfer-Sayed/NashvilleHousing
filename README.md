# Nashville Housing Data Cleaning in SQL


Description: This SQL based project delves into an important step of data analysis called **Data Cleaning**.

Data Cleaning: Data cleaning is the process of detecting and rectifying faults or inconsistencies in dataset by scrapping or modifying them to fit the definition of quality data for analysis. It is an essential activity in data preprocessing as it determines how the data will be used and processed in other modeling processes.

Here are the steps taken in this comprehensive data cleaning project to ensure data quality and consistensy:

1. Standardizing Date Formats: I used the `CONVERT` function to ensure consistent date formats across the dataset, improving data accuracy and analysis.

2. Handling Null Values: Leveraging self-joins, I populated missing values in the PropertyAddress field, enhancing data completeness.

3. Address Breakdown: I dissected the address field into separate components (Address, City, State) using functions like `PARSENAME`, `CHARINDEX`, and `SUBSTRING`. This allowed for better geospatial analysis.

4. Boolean Value Transformation: To enhance readability, I converted boolean values (1 and 0) to user-friendly labels (Yes and No).

5. Duplicate Removal: By utilizing the `ROW_NUMBER` function, I efficiently removed duplicate records, ensuring data integrity.

6. Column Pruning: I deleted unnecessary columns, streamlining the dataset for analysis. (Deleting data is not a common practice and hence be absolutely sure before deleting data)
