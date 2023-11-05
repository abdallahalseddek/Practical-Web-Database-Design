-- Insert in category table 100k
DELIMITER $$
CREATE PROCEDURE InsertCategory(IN cat_count INT)
BEGIN
    DECLARE x INT DEFAULT 1;
    WHILE x <= cat_count DO
            INSERT INTO category(category_id, category_name)
            VALUES(
                      x,
                      CONCAT('category',x)
                  );
            SET x = x + 1;
        END WHILE;
END $$

DELIMITER ;
call InsertCategory(100000);

-- Insert in Product table 10k
DELIMITER $$
CREATE PROCEDURE InsertProduct(IN product_count INT)
BEGIN
    DECLARE x INT DEFAULT 1;

    WHILE x <= product_count DO

            INSERT INTO product(product_id,name, description, price, stock_quantity,category_id)
            values (
                    x,
                   CONCAT('product',x),
                   CONCAT('desc',x),
                   (133.565+x),
                   (22*x),
                    x
                   );
            SET x = x + 1;
        END WHILE;
END $$

DELIMITER ;

call InsertProduct(10000);


-- Insert in customer table 100k
DELIMITER $$
CREATE PROCEDURE InsertCustomers(IN customer_count INT)
BEGIN
    DECLARE x INT DEFAULT 1;
    WHILE x <= customer_count DO
            INSERT INTO customer(customer_id, first_name, last_name, email, hashed_password)
            VALUES (x,
                    CONCAT('john'),
                    CONCAT('smith',x),
                    CONCAT('johnSmith',x,'@mail.com'),
                    '123456'
                    );
            SET x = x + 1;
        END WHILE;
END $$

DELIMITER ;
call InsertCustomers(100000);

-- Write database functions to insert data in order,
-- order details tables around row based on the inserted data in customers and products

DELIMITER $$
CREATE PROCEDURE InsertOrder(IN order_count INT)
BEGIN
    DECLARE x INT DEFAULT 1;
    WHILE x <= order_count DO
        INSERT INTO orders(order_id, order_date, total_amount,customer_id)
        VALUES(x,
            FROM_UNIXTIME(UNIX_TIMESTAMP('2020-01-01 01:00:00') + FLOOR(RAND() * 31536000)),
            ROUND(RAND()*100,2),
              (select customer.customer_id from customer
                  join store.orders o on customer.customer_id = o.customer_id
                    where customer.customer_id = o.customer_id)
              );
        INSERT INTO order_details(order_details_id, quantity,unit_price, order_id,product_id)
        VALUES (x,
                (22*x),
                (133.565+x),
                (select orders.order_id from orders
                    join order_details on orders.order_id = order_details.order_id
                    where orders.order_id= order_details.order_id),
               (SELECT product.product_id FROM product
                   join store.order_details od on product.product_id = od.product_id)
               );
        SET x = x + 1;
    END WHILE;
END $$

DELIMITER ;
call InsertOrder(100000);