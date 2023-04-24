CREATE DATABASE retailer;
USE retailer;

CREATE TABLE vendor_details (
vendor_number INT NOT NULL PRIMARY KEY,
vendor_name varchar(50) NOT NULL,
vendor_email varchar(100),
vendor_phone_number varchar(50),
vendor_country varchar(50) NULL,
lead_time_in_days INT NULL);

INSERT INTO vendor_details (vendor_number,vendor_name,vendor_email,vendor_phone_number,vendor_country,lead_time_in_days)
VALUES 
(222,'LEGO','info@lego.com','07882032345','UK',7),
(333,'HASBRO','info@hasbro.com','07891746328','UK',7),
(444,'STEIFF','steiff@steiff.de','0045908654321','GE',14),
(555,'JELLYCAT','danny@jellycat.co.uk','08761284363','UK',5);

SELECT * FROM vendor_details;


CREATE TABLE vendors_offer_range (
vendor_product_id INT NOT NULL PRIMARY KEY,
vendor_product_description VARCHAR(100) NOT NULL,
vendor_number INT NOT NULL,
vendor_brand varchar(70),
unit_cost_price decimal(6,2) NULL DEFAULT 0,
CONSTRAINT
fk_vendor_number
FOREIGN KEY (vendor_number)
	REFERENCES vendor_details(vendor_number)
    );

INSERT INTO vendors_offer_range (vendor_product_id,vendor_product_description,vendor_number,vendor_brand,unit_cost_price)
VALUES
(10975,'Wild Animals of the World',222,'DUPLO',99.99),
(10963,'Spider-Man & Friends: Funfair Adventure',222,'DUPLO',38.5),
(10930,'Bulldozer',222,'DUPLO',5),
(45025,'Coding Express',222,'DUPLO',156),
(10929,'Modular Playhouse',222,'DUPLO',45),
(42125,'Ferrari 488 GTE - AF Corse #51 TECHNIC',222,'TECHNIC',143),
(42136,'John Deere 9620R 4WD Tractor',222,'TECHNIC',19),
(60308,'Seaside Police and Fire Mission CITY',222,'CITY',29),
(60312,'Police car CITY',222,'CITY',4.99),
(10969,'Fire Engine CITY',222,'CITY',18),
(5123,'Peppa Pig Peppa’s Adventures Miss Rabbit’s Train',333,'Peppa Pig',14),
(5534,'Peppa Pig on Skateboard',333,'Peppa Pig',2.99),
(5536,'Peppa Pig Danny on Skateboard',333,'Peppa Pig',2.99),
(5345,'Peppa Pig Campervan',333,'Peppa Pig',11),
(5611,'Nerf Star Wars Amban Phase-pulse Blaster, The Mandalorian',333,'Nerf',75),
(5623,'Nerf Ultra Pharaoh Blaster, Gold Accents',333,'Nerf',35),
(5643,'Nerf Ultra Three Blaster',333,'Nerf',17),
(5655,'Nerf Soaker Piranha',333,'Nerf',5),
(5677,'Nerf Rival Fate Blaster',333,'Nerf',9.5),
(987654,'Steiff Bear Key Chain',444,'Steiff',5),
(987743,'Steiff Baby Giraffe 1.5m',444,'Steiff',281),
(989965,'Steiff Plush Pencil Case',444,'Steiff',15),
(2001,'JellyCat Storm Octopus Large',555,'Jellycat',28),
(2002,'Jellycat Storm Octopus Small',555,'Jellycat',15),
(2003,'Jellycat Storm Octopus Tiny',555,'Jellycat',9.10),
(2222,'Jellycat Bashful bunny',555,'Jellycat',14.7),
(2567,'JellyCat Montgomery Panda',555,'Jellycat',13);

SELECT * FROM vendors_offer_range;

CREATE TABLE product_range (
	product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	vendor_product_id INT NOT NULL,
    product_status varchar(50),
    vendor_number INT NOT NULL,
    ranged_online BOOLEAN,
    retail_price DECIMAL(6,2),
    CONSTRAINT
    fk_vendor_product_id
    FOREIGN KEY (vendor_product_id)
		REFERENCES vendors_offer_range(vendor_product_id)
    );
    
    ALTER TABLE product_range
    ADD CONSTRAINT 
    fk_vendor_number_pr
    FOREIGN KEY (vendor_number)
		REFERENCES vendor_details(vendor_number);
    
INSERT INTO product_range (vendor_product_id,product_status,vendor_number, ranged_online, retail_price)
VALUES
(10975,'CONT',222,true,114.99), -- Wild Animals of the World 
(10963,'CONT',222,true,44.99),-- Spider-Man & Friends: Funfair Adventure
(10930,'NEW',222,false,8.99),-- Bulldozer
(42125,'NEW',222,true,159.99),-- Ferrari 488 GTE - AF Corse #51 TECHNIC
(42136,'CONT',222,true,29.99), -- John Deere 9620R 4WD Tractor
(60308,'CONT',222,true,34.99),-- Seaside Police and Fire Mission CITY
(60312,'CONT',222,false,8.99),-- Police car CITY
(10969,'NEW',222,false,24.99),-- Fire Engine CITY

(5123,'NEW',333,true,20.99),-- Peppa Pig Peppa’s Adventures Miss Rabbit’s Train
(5534,'CONT',333,false,4.99),-- Peppa Pig on Skateboard
(5534,'CONT',333,false, 4.99), -- Peppa Pig Danny on Skateboard
(5345,'NEW',333,true,16.99),-- Peppa Pig Campervan
(5611,'NEW',333,true,125.99),-- Nerf Star Wars Amban Phase-pulse Blaster, The Mandalorian
(5623,'CONT',333,true,55.99),-- Nerf Ultra Pharaoh Blaster, Gold Accents
(5643,'CONT',333,true,27.99),-- Nerf Ultra Three Blaster
(5655,'CONT',333, false, 7.99), -- Nerf Soaker Piranha
(5677,'NEW',333,false, 14.99), -- Nerf Rival Fate Blaster

(987654,'CONT',444,false,9.99), -- Steiff Bear Key Chain
(987743,'CONT',444,true, 469), -- Steiff Baby Giraffe 1.5m
(989965,'CONT',444,false,23.99), -- Steiff Plush Pencil Case

(2001,'CONT',555,true,55), -- JellyCat Storm Octopus Large
(2002,'CONT',555,false,32), -- Jellycat Storm Octopus Small
(2003,'CONT',555,false,19), -- Jellycat Storm Octopus Tiny
(2222,'NEW',555,true, 29), -- Jellycat Bashful bunny
(2567,'NEW',555,true,28);--  JellyCat Montgomery Panda

SELECT * FROM product_range;
UPDATE product_range
SET vendor_product_id = 5536
WHERE product_id=11;

CREATE TABLE stock_levels_on_hand(
product_id INT NOT NULL,
stock_on_shop_floor_units INT NULL DEFAULT 0,
stock_in_warehouse_units INT NULL DEFAULT 0,
CONSTRAINT 
fk_product_id_stock_levels
FOREIGN KEY (product_id)
	REFERENCES product_range(product_id)
);

INSERT INTO stock_levels_on_hand (product_id,stock_on_shop_floor_units,stock_in_warehouse_units)
VALUES
(1,6,6),
(2,8,10),
(3,12,8),
(4,3,2),
(5,6,4),
(6,0,0),
(7,24,44),
(8,2,0),
(9,4,6),
(10,2,0),
(11,12,40),
(12,4,8),
(13,1,2),
(14,3,4),
(15,6,2),
(16,8,10),
(17,6,12),
(18,8,0),
(19,1,1),
(20,6,4),
(21,3,3),
(22,6,12),
(23,8,10),
(24,18,24),
(25,12,12);

SELECT * FROM stock_levels_on_hand;

CREATE TABLE open_orders (
order_number INT AUTO_INCREMENT PRIMARY KEY,
product_id INT NOT NULL,
ordered_qty_units INT NULL DEFAULT 0,
delivered_qty_units INT NULL DEFAULT 0,
outstanding_qty_units INT NULL DEFAULT 0,
CONSTRAINT
fk_product_id_open_orders
FOREIGN KEY (product_id)
	REFERENCES product_range(product_id)
);

ALTER TABLE open_orders AUTO_INCREMENT=2000;
SELECT * FROM open_orders;

INSERT INTO open_orders (product_id,ordered_qty_units,delivered_qty_units,outstanding_qty_units)
VALUES
(3,10,0,10),
(4,1,0,1),
(5,3,0,3),
(6,12,6,6),
(8,12,0,12),
(10,44,20,24),
(15,4,2,2),
(17,12,0,12),
(18,10,0,10),
(20,10,5,5),
(21,3,0,3),
(22,18,6,12),
(23,24,0,24),
(24,24,12,12);

SELECT * FROM open_orders;

CREATE OR REPLACE VIEW vw_product_range AS
	SELECT 
    product_range.product_id, 
    vendors_offer_range.vendor_product_description as product_description, 
    vendor_details.vendor_name as vendor,
    product_range.product_status,
    product_range.ranged_online,
    vendors_offer_range.unit_cost_price as cost_price,
    product_range.retail_price as retail_price,
    CONCAT(FORMAT(((product_range.retail_price/1.2-vendors_offer_range.unit_cost_price)/(product_range.retail_price/1.2))*100,2),'%') as margin,
    stock_levels_on_hand.stock_on_shop_floor_units as stock_in_store,
    stock_levels_on_hand.stock_in_warehouse_units as stock_in_warehouse,
    IFNULL(open_orders.ordered_qty_units,0) as ordered_qty
    FROM product_range
    LEFT JOIN vendors_offer_range ON vendors_offer_range.vendor_product_id = product_range.vendor_product_id
    LEFT JOIN stock_levels_on_hand ON stock_levels_on_hand.product_id = product_range.product_id
    LEFT JOIN vendor_details ON vendor_details.vendor_number = product_range.vendor_number
    LEFT JOIN open_orders ON open_orders.product_id = product_range.product_id;
    
    SELECT * FROM vw_product_range;
    
    -- FUNCTION
    -- Check what products have low/negative margin and are ranged online, any such products should be removed from online.
    
    DELIMITER //
    CREATE FUNCTION online_margin_check(retail_price DECIMAL(6,2),unit_cost_price DECIMAL(6,2),ranged_online BOOLEAN)
    RETURNS VARCHAR(50)
    DETERMINISTIC
    BEGIN
		DECLARE check_for_low_negative_margin varchar(50);
        IF ((retail_price/1.2-unit_cost_price)/(retail_price/1.2)) < 0.10 AND ranged_online = true
        THEN SET check_for_low_negative_margin = 'Remove from online';
        ELSEIF ((retail_price/1.2-unit_cost_price)/(retail_price/1.2)) > 0.10 AND ((retail_price/1.2-unit_cost_price)/(retail_price/1.2)) < 0.20 AND ranged_online = true
        THEN SET check_for_low_negative_margin = 'Check as low margin';
        ELSEIF ((retail_price/1.2-unit_cost_price)/(retail_price/1.2)) > 0.20 OR ranged_online=false
        THEN SET check_for_low_negative_margin = 'No action';
        END IF;
		RETURN (check_for_low_negative_margin);
	END//
	DELIMITER ;

SELECT 
	product_description,
	cost_price,
    retail_price,
    margin,
    ranged_online,
	online_margin_check(retail_price,cost_price,ranged_online) 
FROM 
	vw_product_range;

    -- SUBQUERY-------------------------------------------------------
    -- Find what products have very low stock on hand (shop floor & warehouse) less than 3 units. 

SELECT product_range.product_id, vendors_offer_range.vendor_product_description,(stock_on_shop_floor_units + stock_in_warehouse_units) as stock_on_hand
FROM vendors_offer_range
JOIN product_range ON vendors_offer_range.vendor_product_id = product_range.vendor_product_id
JOIN stock_levels_on_hand ON product_range.product_id = stock_levels_on_hand.product_id
WHERE vendors_offer_range.vendor_product_description IN(
SELECT vendors_offer_range.vendor_product_description as product_description
FROM vendors_offer_range
WHERE vendor_product_id IN (   
									SELECT vendor_product_id
									FROM product_range
									WHERE product_id IN (
																	SELECT product_id
																	FROM stock_levels_on_hand
																	WHERE (stock_on_shop_floor_units + stock_in_warehouse_units) <= 3)));
    
    
    -- STORE PROCEDURE - order by vendor and by biggest stock value
    
    DELIMITER //
    CREATE PROCEDURE ordered_by_vendor_by_stock_value()
    BEGIN
		SELECT 
			product_id,
            product_description,
            vendor,
            (stock_in_store * cost_price + stock_in_warehouse * cost_price) as stock_on_hand_value
		FROM
			vw_product_range
		ORDER BY vendor, stock_on_hand_value DESC;
    END //
    DELIMITER ;
    
    call ordered_by_vendor_by_stock_value();
    
 
    DROP table LWsales;
    CREATE TABLE LWsales (
    product_id INT NOT NULL,
    LWsales_qty int null default 0);
    Insert into LWsales (product_id,LWsales_qty)
    values 
    (1,5),
    (2,8),
    (3,0),
    (4,8),
    (5,5),
    (6,10),
    (7,21),
    (8,14),
    (9,0),
    (10,17),
    (11,13);
   
select * from LWsales;
ALTER table lwsales add constraint foreign key fk_product_if_lwsales (product_id) references product_range(product_id);
 
  select*from vendors_offer_range;  
  
  -- GROUP BY  -- Find what brand(s) Lego offering us.
  SELECT vendor_details.vendor_name,vendors_offer_range.vendor_brand
  FROM vendors_offer_range JOIN vendor_details on vendors_offer_range.vendor_number=vendor_details.vendor_number
  group by vendor_brand
  having vendor_name = 'LEGO';
    
    select * from vw_product_range;
    
    -- GROUP BY - Find how many LEGO products are online and how many offline, split into CONT and NEW. 
    SELECT  
		vendor,
		product_status,
        ranged_online,
        count(product_status) as num_of_products
        FROM vw_product_range
        GROUP BY product_status,ranged_online, vendor
        HAVING vendor='LEGO'
        ORDER BY ranged_online;
        
        
-- TRIGGER
DELIMITER //
CREATE TRIGGER vendor_details_Before_Insert
BEFORE INSERT ON vendor_details
FOR EACH ROW
BEGIN
	SET NEW.vendor_name=UPPER(NEW.vendor_name);
END //
DELIMITER ;

INSERT INTO vendor_details (vendor_number,vendor_name,vendor_email,vendor_phone_number,vendor_country,lead_time_in_days)
VALUES 
(666,'high resolution','info@hrsl.com','07882032444','UK',7);
DROP TRIGGER vendor_details_Before_Insert;

SELECT * from vendor_details;
    
    
    
    
    
    
    
    
    




    
    
    
    
    
    
    

