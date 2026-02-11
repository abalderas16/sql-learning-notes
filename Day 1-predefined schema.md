Question was: "Which of the following statements is true about relational databases?" -What does this mean?

👉 You must decide and define the structure of the data before storing or using it.

Breaking it down simply

A schema is a blueprint for data. It defines things like:

What columns/fields exist

The name of each field

The data type (text, number, date, boolean, etc.)

Rules (required, unique, length limits)

Predefined means this structure is set in advance, not on the fly.

Example (SQL/Relational database)

CREATE TABLE Users (
  user_id INT,
  name VARCHAR(100),
  email VARCHAR(255),
  created_date DATE
);

Real-world analogy 🧠:
Think of it like a spreadsheet template:
Columns are locked in ahead of time
Every row must follow that exact format
If the template says “Date” in column C, you can’t put text there

