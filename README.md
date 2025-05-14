# Create a README.md file with assignment summary and usage
readme_content = """
# 📘 Database Design and Normalization Assignment

## 🎯 Learning Objectives
- Understand principles of good database design and normalization.
- Apply normalization techniques to improve database structure and efficiency.
- Learn and apply First, Second, and Third Normal Forms (1NF, 2NF, 3NF) to eliminate redundancy and optimize data storage.

---

## 📂 Files Included
- `answers.sql`: Contains all SQL queries for transforming tables from unnormalized to 1NF, 2NF, and 3NF.
- `ER_Diagram.png`: Visual representation of the normalized schema in 3NF using an Entity-Relationship Diagram (ERD).

---

## ✅ Instructions

1. Open **MySQL Workbench** or your preferred SQL environment.
2. Execute queries step by step from `answers.sql` to:
   - Create initial tables.
   - Normalize to 1NF, 2NF, and 3NF.
3. Refer to the `ER_Diagram.png` to visualize the final database structure.
4. Use inline comments in `answers.sql` for explanations and understanding each transformation.

---

## 🗂️ Final Normalized Tables

- `Customers(OrderID, CustomerName)`
- `Suppliers(SupplierName, SupplierContact)`
- `OrderProductDetails(OrderID, Product, Quantity, SupplierName)`

---

## 🖼️ ER Diagram Preview

![ER Diagram](ER_Diagram.png)

---

## 👨‍💻 Author
Javan Solomon 

---

## 📝 License
This project is part of academic coursework and is intended for educational purposes only.
"""

# Save the README content
readme_path = "/mnt/data/README.md"
with open(readme_path, "w") as f:
    f.write(readme_content)

readme_path
