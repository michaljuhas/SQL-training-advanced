# S06-L07 Practice

## Assignment

There are stats about user logins saved in `sample_staff`.`user_stat`. Create a query using row number to identify top 3 user that login most per day per hour. The output table should have the following attributes:

* `date`
* `hour`
* `user_id`
* `login_count`

For each combination date-hour return max 3 users.

## Guidelines

First, order dataset by `date ASC`, `hour ASC` and `login_count DESC`. Then use analytical function row number (or its equivalent in MySQL - see `S06-L02`) to rank rows. The rows with highest `login_count` should have row numbers 1, 2, 3.

Then limit the number of rows returned by applying a condition `WHERE row_number <= 3`.
