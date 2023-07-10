# Fetch Rewards Coding Excercise
1. First: Review Existing Unstructured Data and Diagram a New Structured Relational Data Model
    Receipts table:
      Primary Key: receipts_id (uuid for the receipt, and I changed it to receipts_id for more distinct.
      Foreign Key: userId (references the User table's _id field)
    Users table:
      Primary Key: user_id (user ID)
    Brand table:
      Primary Key: brand_id (brand UUID)
      Foreign Key: barcode
    RewardsReceiptItemList table:
      Primary Key: barcode
      Foreign Key: receipts_id (references the Receipts table's _id field)
    cpg table:
      Primary Key: cpg_id
   According to the relational and jonnable keys, ER diagram was created by draw.io shown in ERD.drawio.png.
    
2. Second: Write a query that directly answers a predetermined question from a business stakeholder
   Shown in queries.sql. For this part, I mergeed the 6 questions into 3 for efficiency.
   
3. Third: Evaluate Data Quality Issues in the Data Provided
   Shown in receipts_quality.html
   
5. Fourth: Communicate with Stakeholders
   Shown in Email.pdf
