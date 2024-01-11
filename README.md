# WelcomeHome

After getting the app setup (`bin/setup`), run `bin/rake welcome_home:load_data`

In the Rails console, run these commands to get rent roll reports:

```
puts RentRoll.new.report

+--------+------------+---------------+-----------------+------------+----------+
| number | floor_plan | resident_name | resident_status |   move_in  | move_out |
+--------+------------+---------------+-----------------+------------+----------+
|      1 | studio     | John Smith    | current         | 2021-01-01 |          |
|      2 | suite      | Sarah         | current         | 2021-03-01 |          |
|      3 | suite      |               |                 |            |          |
|      4 | suite      |               |                 |            |          |
|      5 | suite      | Teddy         |                 |            |          |
|     10 | studio     |               |                 |            |          |
|     11 | studio     |               |                 |            |          |
|     12 | studio     |               |                 |            |          |
+--------+------------+---------------+-----------------+------------+----------+

puts RentRoll.new("2020-01-01").report

+--------+------------+---------------+-----------------+------------+------------+
| number | floor_plan | resident_name | resident_status |   move_in  |  move_out  |
+--------+------------+---------------+-----------------+------------+------------+
|      1 | studio     | Sally Carol   | current         | 2019-06-01 | 2020-12-15 |
|      2 | suite      | Sarah         | future          | 2021-03-01 |            |
|      3 | suite      |               | current         |            |            |
|      4 | suite      |               | current         |            |            |
|      5 | suite      | Teddy         | current         |            |            |
|     10 | studio     |               | current         |            |            |
|     11 | studio     |               | current         |            |            |
|     12 | studio     |               | current         |            |            |
+--------+------------+---------------+-----------------+------------+------------+
```
