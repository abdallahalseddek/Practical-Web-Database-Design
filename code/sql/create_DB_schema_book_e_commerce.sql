CREATE DATABASE IF NOT EXISTS ecommerce;

USE ecommerce;

CREATE TABLE Product (
  ProductId CHAR(10) PRIMARY KEY ,
  ProductName VARCHAR(100) NOT NULL,
  ProductDescription VARCHAR(500),
  ProductLongDescription VARCHAR(2000),
  ProductSize VARCHAR(10),
  ProductColour VARCHAR(10),
  ProductWeight SMALLINT,
  ProductPrice NUMERIC(7,2),
  ProductOnHand SMALLINT NOT NULL,
  ProductComments VARCHAR(1000),
  ProductImage VARCHAR(100),
  ProductDiscount NUMERIC(7,2) NOT NULL,
  ProductShipCost NUMERIC(7,2) NOT NULL
);

CREATE TABLE Category (
  CategoryID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryName VARCHAR(100) NOT NULL,
  CategoryDescription VARCHAR(1000),
  CategoryParentId INT NOT NULL,
  FOREIGN KEY (CategoryParentId) REFERENCES Category(CategoryID)
);



CREATE TABLE ProductCategory(
  ProductId CHAR(10) ,
  CategoryID INT NOT NULL,
  ProductCategoryDefault CHAR(1) NOT NULL,
  PRIMARY KEY (ProductId,CategoryID),
  FOREIGN KEY(ProductId) REFERENCES Product(ProductId),
  FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Customer (
  CustomerId INT AUTO_INCREMENT PRIMARY KEY,
  CustomerUserName VARCHAR(20) NOT NULL,
  CustomerPassword VARCHAR(20) NOT NULL,
  CustomerEmail VARCHAR(100) NOT NULL,
  CustomerFirstName VARCHAR(50),
  CustomerLastName VARCHAR(50),
  CustomerAddresse1 VARCHAR(100),
  CustomerAddresse2 VARCHAR(100),
  CustomerCity VARCHAR(100),
  CustomerProvience VARCHAR(100),
  CustomerCountry VARCHAR(50),
  CustomerPostal VARCHAR(10)
); 

CREATE TABLE Orders (
  OrderId INT AUTO_INCREMENT PRIMARY KEY,
  OrderTotal NUMERIC(7,2) NOT NULL,
  OrderDiscount NUMERIC(7,2) NOT NULL,
  OrderTax NUMERIC(7,2) NOT NULL,
  OrderShipping NUMERIC(7,2) NOT NULL,
  OrderDate Date NOT NULL,
  OrderShipDate Date ,
  OrderCustomerId INT NOT NULL,
  FOREIGN KEY (OrderCustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE OrderItem (
  OrderId INT NOT NULL,
  ProductId CHAR(10) NOT NULL,
  OrderItemQuantity SMALLINT NOT NULL,
  OrderItemPrice NUMERIC(7,2) NOT NULL,
  OrderItemDiscount NUMERIC(7,2) NOT NULL,
  OrderItemTax NUMERIC(7,2) NOT NULL,
  OrderItemShipping NUMERIC(7,2) NOT NULL,
  PRIMARY KEY (OrderId, ProductId),
  FOREIGN KEY (OrderId) REFERENCES Orders (OrderId),
  FOREIGN KEY (ProductId) REFERENCES Product (ProductId)
);

CREATE INDEX OrderItemProductIndex ON OrderItem(ProductId);