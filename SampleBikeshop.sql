/*******************************************************************************
   SampleBikeshop Database - Version 1
   Script: SampleBikeshop.sql
   Description: Creates and populates the sample Bikeshop database.
   DB Server: SQL Server
   Author: Aghosh Kolathuparambil - 200240 (Aghosh.Kolathuparambil@ust.com)
   License: Public
********************************************************************************/

/********Creating Database**********/

CREATE DATABASE SampleBikeShop

/***********Drop tables if it exists*********/

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS stocks;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS brands;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS staffs;
DROP TABLE IF EXISTS stores;

/********Creating tables**********/

CREATE TABLE categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);



CREATE TABLE stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/**********Inserting data***********/

SET IDENTITY_INSERT brands ON; 
INSERT INTO brands(brand_id,brand_name) VALUES(1,'Electra')
INSERT INTO brands(brand_id,brand_name) VALUES(2,'Haro')
INSERT INTO brands(brand_id,brand_name) VALUES(3,'Heller')
INSERT INTO brands(brand_id,brand_name) VALUES(4,'Pure Cycles')
INSERT INTO brands(brand_id,brand_name) VALUES(5,'Ritchey')
INSERT INTO brands(brand_id,brand_name) VALUES(6,'Strider')
INSERT INTO brands(brand_id,brand_name) VALUES(7,'Sun Bicycles')
INSERT INTO brands(brand_id,brand_name) VALUES(8,'Surly')
INSERT INTO brands(brand_id,brand_name) VALUES(9,'Trek')
SET IDENTITY_INSERT brands OFF;

SET IDENTITY_INSERT categories ON; 
INSERT INTO categories(category_id,category_name) VALUES(1,'Children Bicycles')
INSERT INTO categories(category_id,category_name) VALUES(2,'Comfort Bicycles')
INSERT INTO categories(category_id,category_name) VALUES(3,'Cruisers Bicycles')
INSERT INTO categories(category_id,category_name) VALUES(4,'Cyclocross Bicycles')
INSERT INTO categories(category_id,category_name) VALUES(5,'Electric Bikes')
INSERT INTO categories(category_id,category_name) VALUES(6,'Mountain Bikes')
INSERT INTO categories(category_id,category_name) VALUES(7,'Road Bikes')
SET IDENTITY_INSERT categories OFF;

SET IDENTITY_INSERT products ON; 
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(1,'Trek 820 - 2016',9,6,2016,379.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(2,'Ritchey Timberwolf Frameset - 2016',5,6,2016,749.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(3,'Surly Wednesday Frameset - 2016',8,6,2016,999.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(4,'Trek Fuel EX 8 29 - 2016',9,6,2016,2899.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(5,'Heller Shagamaw Frame - 2016',3,6,2016,1320.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(6,'Surly Ice Cream Truck Frameset - 2016',8,6,2016,469.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(7,'Trek Slash 8 27.5 - 2016',9,6,2016,3999.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(8,'Trek Remedy 29 Carbon Frameset - 2016',9,6,2016,1799.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(9,'Trek Conduit+ - 2016',9,5,2016,2999.99)
INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(10,'Surly Straggler - 2016',8,4,2016,1549)

SET IDENTITY_INSERT products OFF;



INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Debra','Burks',NULL,'debra.burks@yahoo.com','9273 Thorne Ave. ','Orchard Park','NY',14127);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Kasha','Todd',NULL,'kasha.todd@yahoo.com','910 Vine Street ','Campbell','CA',95008);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Tameka','Fisher',NULL,'tameka.fisher@aol.com','769C Honey Creek St. ','Redondo Beach','CA',90278);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Daryl','Spence',NULL,'daryl.spence@aol.com','988 Pearl Lane ','Uniondale','NY',11553);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Charolette','Rice','(916) 381-6003','charolette.rice@msn.com','107 River Dr. ','Sacramento','CA',95820);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Lyndsey','Bean',NULL,'lyndsey.bean@hotmail.com','769 West Road ','Fairport','NY',14450);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Latasha','Hays','(716) 986-3359','latasha.hays@hotmail.com','7014 Manor Station Rd. ','Buffalo','NY',14215);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Jacquline','Duncan',NULL,'jacquline.duncan@yahoo.com','15 Brown St. ','Jackson Heights','NY',11372);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Genoveva','Baldwin',NULL,'genoveva.baldwin@msn.com','8550 Spruce Drive ','Port Washington','NY',11050);
INSERT INTO customers(first_name, last_name, phone, email, street, city, state, zip_code) VALUES('Pamelia','Newman',NULL,'pamelia.newman@gmail.com','476 Chestnut Ave. ','Monroe','NY',10950);



INSERT INTO stores(store_name, phone, email, street, city, state, zip_code)
VALUES('Santa Cruz Bikes','(831) 476-4321','santacruz@bikes.shop','3700 Portola Drive', 'Santa Cruz','CA',95060),
      ('Baldwin Bikes','(516) 379-8888','baldwin@bikes.shop','4200 Chestnut Lane', 'Baldwin','NY',11432),
      ('Rowlett Bikes','(972) 530-5555','rowlett@bikes.shop','8000 Fairway Avenue', 'Rowlett','TX',75088);



INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,1,27);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,2,5);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,3,6);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,4,23);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,5,22);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,6,0);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,7,8);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,8,0);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,9,11);
INSERT INTO stocks(store_id, product_id, quantity) VALUES(1,10,15);


SET IDENTITY_INSERT staffs ON; 

INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(1,'Fabiola','Jackson','fabiola.jackson@bikes.shop','(831) 555-5554',1,1,NULL);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(2,'Mireya','Copeland','mireya.copeland@bikes.shop','(831) 555-5555',1,1,1);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(3,'Genna','Serrano','genna.serrano@bikes.shop','(831) 555-5556',1,1,2);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(4,'Virgie','Wiggins','virgie.wiggins@bikes.shop','(831) 555-5557',1,1,2);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(5,'Jannette','David','jannette.david@bikes.shop','(516) 379-4444',1,2,1);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(6,'Marcelene','Boyer','marcelene.boyer@bikes.shop','(516) 379-4445',1,2,5);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(7,'Venita','Daniel','venita.daniel@bikes.shop','(516) 379-4446',1,2,5);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(8,'Kali','Vargas','kali.vargas@bikes.shop','(972) 530-5555',1,3,1);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(9,'Layla','Terrell','layla.terrell@bikes.shop','(972) 530-5556',1,3,7);
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(10,'Bernardine','Houston','bernardine.houston@bikes.shop','(972) 530-5557',1,3,7);

SET IDENTITY_INSERT staffs OFF;

 
SET IDENTITY_INSERT orders ON; 

INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(1,2,4,'20160101','20160103','20160103',1,2);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(4,5,4,'20160103','20160104','20160105',1,3);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(6,10,4,'20160104','20160107','20160105',2,6);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(7,1,4,'20160104','20160107','20160105',2,6);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(9,6,4,'20160105','20160108','20160108',1,2);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(12,8,4,'20160106','20160108','20160109',1,2);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(14,4,4,'20160109','20160111','20160112',1,3);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(27,3,4,'20160119','20160121','20160120',2,7);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(28,7,4,'20160119','20160120','20160121',2,6);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(33,9,4,'20160121','20160122','20160122',2,6);
INSERT INTO orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(34,1,4,'20160122','20160125','20160123',2,6);

SET IDENTITY_INSERT orders OFF; 
