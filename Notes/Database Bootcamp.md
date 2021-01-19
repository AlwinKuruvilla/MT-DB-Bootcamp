# Database Bootcamp Notes

## Built-in Functions
You can perform functions within the SELECT clause by typing in the desired equation after it.
Ex:
```SELECT Price + (Price * 0.07) AS 'Total Price'
```

## Order of Commands
When creating a select statemnent, you need to make sure that you write these commands in the proper order:
1. SELECT
2. FROM = This allows you to specify the table in which you want to pull date from.
    Note: the JOIN function is used in here.
3. WHERE = This allows you filter out rows based on a set criteria.
4. GROUP BY = This allows you to aggregate data based on a similar values in a column.
    Note: All other columns must be SELECTed with an aggregate function or be within a GROUP BY clause.
5. HAVING = This allows you filter out entire groups from the result.
	Note: Use NOT to exclude groups in the filter.
6. ORDER BY