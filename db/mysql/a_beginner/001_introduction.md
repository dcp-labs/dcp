### **What is a Database?**

A **database** is an organized collection of data that can be easily accessed, managed, and updated.

* Example: A library system where books, authors, and members are stored.
* Think of it like a **digital filing cabinet** where data is stored in a structured way.

<br><br><br>

### **What is a Database Management System (DBMS)?**

A **DBMS** is software that helps you store, manage, and retrieve data from a database.

* It provides tools to **insert, update, delete, and query data**.
* Example: MySQL, Oracle, SQL Server.

So:

* **Database** → The actual data.
* **DBMS** → The software to manage that data.

<br><br><br>

### **Relational Database (RDBMS)**

A **Relational Database** stores data in **tables** (rows and columns).

* Each table is like a spreadsheet.
* Relationships are created between tables using **keys** (Primary Key, Foreign Key).

Example:

* `Students` table and `Courses` table can be linked by `Student_ID`.

Popular RDBMS: **MySQL, Oracle, PostgreSQL, SQL Server**.

<br><br><br>

### **Popular Databases**

* **MySQL** – Open-source, very popular for web apps (used by WordPress, Facebook).
* **Oracle Database** – Powerful, enterprise-level, often used by big corporations.
* **MongoDB** – A **NoSQL database**, stores data as JSON-like documents (not tables).
* **PostgreSQL** – Open-source, advanced RDBMS with strong community support.
* **Microsoft SQL Server** – Developed by Microsoft, widely used in corporate environments.
* **Apache Cassandra** – A **NoSQL database** designed for big data and high availability.

<br><br><br>

### **What is SQL?**

**SQL (Structured Query Language)** is a programming language used to communicate with relational databases.

* It is used to **create tables, insert data, query data, update data, and delete data**.
* Example:

  ```sql
  SELECT name, age FROM Students WHERE age > 18;
  ```

<br><br><br>

### **SQL is a Domain-Specific Language**

* A **domain-specific language** is designed for a specific purpose.
* SQL is **not a general-purpose programming language** (like Python or Java).
* Its domain = **managing and querying relational databases**.


<br><br><br>

---

<br><br><br>

### **Types of SQL Commands**

SQL commands are grouped into categories based on their purpose.

<br><br>

### **1. Data Definition Language (DDL)**

* Used to **define or change the structure** of database objects (tables, schemas, etc.).
* **Auto committed** → once executed, changes are permanent.

**Commands:**

* **CREATE** → Creates new objects.

  ```sql
  CREATE TABLE Students (id INT, name VARCHAR(50));
  ```
* **ALTER** → Modifies existing objects.

  ```sql
  ALTER TABLE Students ADD age INT;
  ```
* **DROP** → Deletes objects permanently.

  ```sql
  DROP TABLE Students;
  ```
* **TRUNCATE** → Removes all data from a table but keeps the structure.

  ```sql
  TRUNCATE TABLE Students;
  ```
<br><br>

### **2. Data Manipulation Language (DML)**

* Used to **manipulate data** (insert, update, delete, retrieve).
* **Not auto committed** → you can roll back if needed.

**Commands:**

* **SELECT** (technically part of **DQL – Data Query Language**)
  Retrieves data.

  ```sql
  SELECT * FROM Students;
  ```
* **INSERT** → Adds new records.

  ```sql
  INSERT INTO Students (id, name, age) VALUES (1, 'Alex', 20);
  ```
* **UPDATE** → Modifies existing records.

  ```sql
  UPDATE Students SET age = 21 WHERE id = 1;
  ```
* **DELETE** → Removes records.

  ```sql
  DELETE FROM Students WHERE id = 1;
  ```
<br><br>

### **3. Data Control Language (DCL)**

* Used to **control access and permissions** in the database.

**Commands:**

* **GRANT** → Gives user permissions.

  ```sql
  GRANT SELECT ON Students TO user1;
  ```
* **REVOKE** → Removes permissions.

  ```sql
  REVOKE SELECT ON Students FROM user1;
  ```
<br><br>

### **4. Transaction Control Language (TCL)**

* Used to manage **transactions** (a group of SQL statements treated as one unit).

**Commands:**

* **COMMIT** → Saves all changes permanently.

  ```sql
  COMMIT;
  ```
* **ROLLBACK** → Undo changes (before commit).

  ```sql
  ROLLBACK;
  ```
<br><br>

✅ **Summary Table** : `Types of SQL Commands`

| Type    | Purpose                   | Auto-Commit?  | Examples                       |
| ------- | ------------------------- | ------------- | ------------------------------ |
| **DDL** | Define database structure | Yes           | CREATE, ALTER, DROP, TRUNCATE  |
| **DML** | Manipulate data           | No            | SELECT, INSERT, UPDATE, DELETE |
| **DCL** | Control access            | Depends on DB | GRANT, REVOKE                  |
| **TCL** | Manage transactions       | No            | COMMIT, ROLLBACK               |


<br><br><br>

---

<br><br><br>



### 📘 SQL Data Types with Size & Examples

<br><br>

### 🧮 What is a Byte?

* **1 byte = 8 bits** (a bit is `0` or `1`).
* Storage = **data size + overhead** (depending on the datatype).
* Example:

  * A `CHAR(5)` always takes **5 bytes**, even if you store `"Hi"` (it pads with spaces).
  * A `VARCHAR(5)` uses **length of text + 2 bytes overhead**. So `"Hi"` = `2 (data)` + `2 (overhead)` = `4 bytes`.

<br><br>

### 🔢 1. Exact Numeric Types

| Data Type        | Size (Bytes)                          | Range (Approx)                  | Example                   |
| ---------------- | ------------------------------------- | ------------------------------- | ------------------------- |
| **INT**          | 4 bytes                               | -2,147,483,648 to 2,147,483,647 | `12345`                   |
| **SMALLINT**     | 2 bytes                               | -32,768 to 32,767               | `150`                     |
| **BIT**          | 1 bit (but stored in 1 byte)          | 0 or 1                          | `1`                       |
| **DECIMAL(p,s)** | `~p/2+1` bytes (depends on precision) | User-defined                    | `DECIMAL(5,2)` → `123.45` |

<br><br>

### 🌊 2. Approximate Numeric Types

| Data Type    | Size (Bytes)                        | Range       | Example   |
| ------------ | ----------------------------------- | ----------- | --------- |
| **FLOAT(n)** | 4 or 8 bytes depending on precision | \~1.79E+308 | `3.14159` |
| **REAL**     | 4 bytes                             | \~3.40E+38  | `3.14`    |

<br><br>

### ⏰ 3. Date and Time Types

| Data Type                | Size (Bytes)                     | Range                        | Example               |
| ------------------------ | -------------------------------- | ---------------------------- | --------------------- |
| **DATE**                 | 3 bytes                          | 0001-01-01 to 9999-12-31     | `2025-08-25`          |
| **TIME**                 | 3–5 bytes (depends on precision) | 00:00:00 to 23:59:59.9999999 | `14:30:00`            |
| **TIMESTAMP / DATETIME** | 8 bytes                          | 1753-01-01 to 9999-12-31     | `2025-08-25 14:30:00` |

<br><br>

### 🔤 4. String (Character) Types

| Data Type      | Size            | Max Length                   | Example                   |
| -------------- | --------------- | ---------------------------- | ------------------------- |
| **CHAR(n)**    | Fixed `n` bytes | 8,000                        | `CHAR(5)` → `'Hi   '`     |
| **VARCHAR(n)** | `n + 2` bytes   | 8,000 (`VARCHAR(MAX)` = 2GB) | `VARCHAR(50)` → `'Hello'` |
| **TEXT**       | Variable (2GB)  | 2,147,483,647 chars          | Blog content              |

<br><br>

### 📂 5. Binary Types

| Data Type        | Size                  | Max Length                     | Example                |
| ---------------- | --------------------- | ------------------------------ | ---------------------- |
| **BINARY(n)**    | Fixed `n` bytes       | 8,000                          | `BINARY(4)` → `0x1234` |
| **VARBINARY(n)** | `n + 2` bytes         | 8,000 (`VARBINARY(MAX)` = 2GB) | File bytes             |
| **IMAGE**        | Variable (deprecated) | 2GB                            | Picture file           |

<br><br>

### 📊 SQL Data Type Storage Examples

| Value                   | Data Type         | How Storage is Calculated               | Actual Size Used |
| ----------------------- | ----------------- | --------------------------------------- | ---------------- |
| `12345`                 | **INT**           | Always **4 bytes** (fixed)              | **4 bytes**      |
| `150`                   | **SMALLINT**      | Always **2 bytes** (fixed)              | **2 bytes**      |
| `1`                     | **BIT**           | 1 bit (stored in 1 byte)                | **1 byte**       |
| `3.14`                  | **FLOAT**         | Default = 8 bytes (approximate)         | **8 bytes**      |
| `'Hi'`                  | **CHAR(5)**       | Fixed size → 5 bytes (pads with spaces) | **5 bytes**      |
| `'Hi'`                  | **VARCHAR(5)**    | Length (2) + 2 bytes overhead           | **4 bytes**      |
| `'Hello'`               | **VARCHAR(50)**   | Length (5) + 2 bytes overhead           | **7 bytes**      |
| `'Hello World'`         | **VARCHAR(50)**   | Length (11) + 2 bytes overhead          | **13 bytes**     |
| `'2025-08-25'`          | **DATE**          | Always 3 bytes                          | **3 bytes**      |
| `'14:30:00'`            | **TIME(0)**       | 3 bytes (no fractional sec)             | **3 bytes**      |
| `'2025-08-25 14:30:00'` | **DATETIME**      | Fixed 8 bytes                           | **8 bytes**      |
| `0x1234`                | **BINARY(4)**     | Fixed → 4 bytes                         | **4 bytes**      |
| `0x1234`                | **VARBINARY(10)** | Length (2 bytes) + 2 overhead           | **4 bytes**      |





<br><br><br>

---

<br><br><br>



### ⚡ SQL Operators

SQL operators are special symbols/keywords used in **queries and conditions** to perform calculations, comparisons, and logical operations.

<br><br>

### ➕ 1. Arithmetic Operators

Used for **mathematical calculations**.

| Operator | Description         | Example  | Result |
| -------- | ------------------- | -------- | ------ |
| `+`      | Addition            | `10 + 5` | `15`   |
| `-`      | Subtraction         | `10 - 5` | `5`    |
| `*`      | Multiplication      | `10 * 5` | `50`   |
| `/`      | Division            | `10 / 5` | `2`    |
| `%`      | Modulus (remainder) | `10 % 3` | `1`    |

🔹 **Usage in SQL**

```sql
SELECT 100 + 50 AS Total,
       100 - 50 AS Difference,
       10 * 5 AS Product,
       20 / 4 AS Division,
       10 % 3 AS Remainder;
```

<br><br>

### 🧩 2. Logical Operators

Used to combine multiple conditions.

| Operator  | Description                                       | Example                                                                                  |
| --------- | ------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `ALL`     | Returns TRUE if **all conditions** are true       | `SELECT * FROM Students WHERE Marks > ALL (SELECT Marks FROM Students WHERE Class='A');` |
| `AND`     | Returns TRUE if **both conditions** are true      | `WHERE Age > 18 AND City = 'Delhi'`                                                      |
| `ANY`     | Returns TRUE if **any condition** is true         | `WHERE Salary > ANY (SELECT Salary FROM Employees WHERE Dept='HR')`                      |
| `BETWEEN` | Checks if value is within a **range** (inclusive) | `WHERE Age BETWEEN 18 AND 30`                                                            |
| `EXISTS`  | Returns TRUE if a subquery returns results        | `WHERE EXISTS (SELECT * FROM Orders WHERE Orders.CustomerID = Customers.ID)`             |

<br><br>

### ⚖️ 3. Comparison Operators

Used to compare two values.

| Operator     | Description                     | Example           | Result                      |
| ------------ | ------------------------------- | ----------------- | --------------------------- |
| `=`          | Equal to                        | `Age = 25`        | TRUE if Age is 25           |
| `!=` or `<>` | Not equal to                    | `Age != 25`       | TRUE if Age is not 25       |
| `>`          | Greater than                    | `Salary > 50000`  | TRUE if Salary is above 50k |
| `<`          | Less than                       | `Salary < 50000`  | TRUE if Salary is below 50k |
| `>=`         | Greater than or equal           | `Marks >= 40`     | TRUE if Marks ≥ 40          |
| `<=`         | Less than or equal              | `Marks <= 40`     | TRUE if Marks ≤ 40          |
| `!>`         | Not greater than (same as `<=`) | `Salary !> 50000` | TRUE if Salary ≤ 50k        |
| `!<`         | Not less than (same as `>=`)    | `Salary !< 50000` | TRUE if Salary ≥ 50k        |

🔹 **Usage in SQL**

```sql
SELECT * FROM Employees
WHERE Salary >= 50000
  AND Age BETWEEN 25 AND 40
  AND Department <> 'Intern';
```


<br><br><br>

---

<br><br><br>





### 📘 SQL Command Structure

The general structure of a SQL query is:

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
GROUP BY column1, column2
HAVING condition
ORDER BY column1, column2;
```

Each clause serves a specific purpose. Let’s break it down 👇

<br><br>

### 1️⃣ `SELECT` – Choose Columns

* Used to specify which columns you want to display.
* You can also use expressions, functions, or `*` (all columns).

**Example:**

```sql
SELECT FirstName, LastName, Salary
FROM Employees;
```

<br><br>

### 2️⃣ `FROM` – Specify Table

* Defines which table(s) to pull data from.
* Can include joins to fetch data from multiple tables.

**Example:**

```sql
SELECT *
FROM Orders;
```

<br><br>

### 3️⃣ `WHERE` – Filter Rows (Before Grouping)

* Filters rows based on a condition.
* Only rows matching the condition are returned.

**Example:**

```sql
SELECT FirstName, Salary
FROM Employees
WHERE Salary > 50000 AND Department = 'IT';
```

<br><br>

### 4️⃣ `GROUP BY` – Group Rows

* Groups rows with the same values into summary rows.
* Often used with aggregate functions (`COUNT`, `SUM`, `AVG`, `MAX`, `MIN`).

**Example:**

```sql
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;
```

<br><br>

### 5️⃣ `HAVING` – Filter Groups (After Grouping)

* Similar to `WHERE`, but applies **after grouping**.
* Used to filter aggregate results.

**Example:**

```sql
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 60000;
```

<br><br>

### 6️⃣ `ORDER BY` – Sort Results

* Used to sort rows by one or more columns.
* Default: ascending (`ASC`). Use `DESC` for descending.

**Example:**

```sql
SELECT FirstName, Salary
FROM Employees
ORDER BY Salary DESC;
```

<br><br>

### 🔑 Quick Notes - `SQL Command Structure`

* **Execution order (behind the scenes):**
  `FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`
* `WHERE` filters **rows before grouping**.
* `HAVING` filters **groups after grouping**.
* Always put `ORDER BY` last.


<br><br><br>

---

<br><br><br>




### Database & Table

* `create database sql_intro;` → Creates a new database named **sql\_intro**.
* `show databases;` → Lists all available databases in MySQL.
* `use sql_intro;` → Switches to use the **sql\_intro** database.
* `create table emp_details (...);` → Creates a table **emp\_details** with columns like name, age, city, etc.
* `describe emp_details;` → Shows table structure (columns, types, nullability, etc.).

<br><br>

### Data Insertion & Retrieval

* `insert into emp_details ... values (...);` → Inserts multiple employee records into the table.
* `select * from emp_details;` → Retrieves all rows and columns from the table.

<br><br>

### Filtering & Conditions

* `select distinct city from emp_details;` → Fetches unique city names (removes duplicates).
* `select count(name) as count_name from emp_details;` → Counts total employees (number of rows).
* `select sum(salary) from emp_details;` → Calculates the total of all salaries.
* `select avg(salary) from emp_details;` → Calculates the average salary.
* `select * from emp_details where age > 30;` → Gets employees older than 30.
* `select * from emp_details where gender = "Female";` → Fetches all female employees.
* `select * from emp_details where city in ("Mumbai", "Pune");` → Retrieves employees who live in Mumbai or Pune.
* `select * from emp_details where doj between '2020-01-01' and '2025-01-01';` → Finds employees who joined between 2020 and 2025.
* `select * from emp_details where age > 30 and gender = "Male";` → Fetches male employees older than 30.

<br><br>

### Grouping & Sorting

* `select gender, sum(salary) as total_salary from emp_details group by gender;` → Groups employees by gender and sums their salaries.
* `select * from emp_details order by salary desc;` → Lists employees sorted by salary (highest first).
* `select * from emp_details order by salary;` → Lists employees sorted by salary (lowest first).

<br><br>

### String & Date Functions

* `select length(name) from emp_details where city = "Bhopal";` → Returns the length of names for employees in Bhopal.
* `select lower(name) from emp_details;` → Converts all employee names to lowercase.
* `select upper(name) from emp_details;` → Converts all employee names to uppercase.
* `select curdate();` → Returns today’s date.
* `select day(curdate());` → Returns the current day of the month.
* `select now();` → Returns the current date and time.






<br><br><br>

---

<br><br><br>