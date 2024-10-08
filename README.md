# CFG MySQL Final Project
This is a final prject of CFG Data&SQL Kickstarter course where we learnt about MySQL over period of 8 weeks, one evening session a week.
This project is a fictional database for a toy retailer. 

- it was created in August 2022 using MySQL
- all data are fictitious
- it has 5 tables:
  - product_range
  - vendors_offer_range
  - vendor_details
  - stock_levels_on_hand
  - open_order

<img width="603" alt="EER DIAGRAM - Retailer" src="https://github.com/user-attachments/assets/f010d227-3fbc-4d90-b185-0b041c3e9468">


Actions taken on above 5 tables:
  - created one consolidated `view` with all information about products in the range, including product_name, vendor_name, vendor_cost_price, retail_price, calucalted margin, stock levels with data populated from different tables
  - tables are linked via Foreign Keys
  - function `online_margin_check` which recommends whether the product should be ranged online based on their margin (products with low margin would be unprofitable to range online due to additional costs of packaging, shipping)
  - subquery which finds which products have very low stock
  - procedure that orders products in range by vendor and stock value
  - showing all brands that Lego (as vendor) has in its vendor range 
  - displaying number of products online and offline for vendor Lego
  - created a simple trigger that changes vendor name to capital letter
    

