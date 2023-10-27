# Practical Web DataBase Design Book, [Springer Edition](https://link.springer.com/book/10.1007/978-1-4302-5377-8)
### This `README` file contains my hand-work from database concepts discussed in the book. Also, I Implemented the applications described in the book as an illustrative example.
## Index:
- [An Intro to the content of the book](#book-content)
- [Book Example Design and Impl in MySql & PostgresSql](#book-e-commerce-example)
- [Ecommerce Application Design](#my-hands-on-e-commerce-app-design)
  * [Normalized Design](#normalized-design)
  * [Denormalized Design](#denormalized-design)
- [Some Queries like : top-selling products And Daily or Monthly Reports](#important-queries)

### Book Content
Practical web database design is a great text book that had written by experienced professional engineers.
They made an insightful database work consists of Nine chapters and Appendix.
On Their first words, They gave us a good introduction about database definition, 
a short history about how we start thinking for `files` alternative, what is the DBMS and its models, 
and is there a database on the web? if so, how about using it in web application.  
After that, The author discussed core database concepts, e.g., Data model, Relational Model and 
how it consists of `Tables`, `Rows`, `Columns`, The Domains and data types.
They explained data model constrains and how to use primary keys and foreign keys in a wise DB Model Design.<br>

At the End of Ch.2, He talked about `Normalization`, `Indexs`, `Data Integrity`.
The book explained five normalization forms with good examples, Physical data access methods, e.g.,
sequential access, direct access, indexed access, and data integrity rules.<br>

After that we are seeing the author talking about `Sql` history, and it's categories.
What is Data Definition Language(DDL), DML, Querying using `Select`, `WHERE`, `HAVING`, and `JOIN` clauses.
The Book has a good E-commerce example for these concepts started from ch.3 till ch.7.<br>

when The Author intended to talk about Database Design Fundamentals, 
He gave us, At first, a solid academic definitions about data modeling, Model `Entities`,
its `attributes`, `Relationships`.
we found a well-described project to explain where to use OneToMany or ManyToMany, its recursive version,
and OneToOne Relationships.<br>

The End of ch.4 is a brilliant explanation about `DeNormalization` for Performance purposes.<br>

I found chapter five in this book is a legend for every software engineer and business owner. 
These insightful papers gave us the guide from A~Z in System design process.
How to start the process with the owner and customer, what are the questions to ask them about,
so you can get your goal obvious.<br>
After **Gathering Information**, we can step into Identifying System Entities, Attributes, Relationships. 
Ending By preparing your conceptual data model.<br>

In the end, the author addresses advanced database features
- Sub-Queries
- Stored Procedures and Triggers
- Database Tuning
- Types of Index
- Managing Concurrency: Locking and Transactions. <br>

Also, Book Authors address two main chapters about Database Security and Maintenance. 
These topics are more towards System Administration work, 
but it is good for us to know how to perform good security rules. 

### Book E-commerce Example
As I mentioned earlier, the author discussed in `Chapter.5` 
What is the SOLID steps to follow, so you can result a well-designed project.<br> 

TODO: continue book ecommerce section with ERD and spring impl code




 <p align="center">
    <img src="img/DB_schema_book_e_commerce.png">
</p>
<p style="text-align: center">E-Commerce ERD Diagram</p>

### My Hands-On E-Commerce App Design
The app is e-commerce that has `Order`, `Product`, `Category`, and `Customer` Entities.<br>
* Customer can purchase many orders so it will be a `OneToMany` Relationship. 
As a One **Customer** linked to Many **Orders**.
* Products can be in many orders, also orders can have many products. 
So I linked them with `ManyToMany` Relationship: 
Here we have an associative Entity (**OrderDetails**)  
* Category always had many products. 
So it will be a one category linked to many products as `OneToMany` Relation
>You can Access a``SQL`` file for creating the database schema: [DB Schema.](sql/create_DB_Schema.sql) <br> 
Also, if you need to test the database design and queries listed below, you can use these [Fake Data.](sql/mock%20data%20genrator)
### Normalized Design
Normalized Form of the app like the design below.<br>
 <p align="center">
    <img src="img/task_ERD_Normalized_01.jpg">
</p>
<p style="text-align: center">Normalized ERD Design</p>

### DeNormalized Design
when the customer creat an order, 
I need his/her email and full-name to notify him/her with an email containing the order details and shipping information.<br>
we need to **Denormalize** this design, so it would be easy for the Query to get customer info.
I added user-name and email to `Order` Entity
> Here is Redundant info, but **Better Performance**.
 <p align="center">
    <img src="img/task_Denormalized_ERD_01.png">
</p>
<p style="text-align: center">DeNormalized ERD Design</p>

### Important Queries
* Daily Report
Business Owner wants a daily report of the total revenue for a specific date.
we can get the total revenue by get the summation of the `orderTotalAmount` for A specific `Order` where the date is `orderDate`
```mysql
SELECT SUM(ordertotalamount)
  FROM "Order" WHERE
  DATE(orderdate)='2023-09-09';          -- write specific date you want 
```
* Monthly Report 
Business Owner wants a monthly report Of the top-selling products in a given month.
```mysql
SELECT DATE_FORMAT(orderdate,'%y-%m') AS Months, productId
  FROM orderdetails od JOIN 'Order' o ON o.orderId=od.OrderId
  (SELECT ProductName FROM product p where p.productId = od.productId, SUM(quantity)) As totalQuantity
  WHERE DATE_FORMAT(orderdate,'%y-%m') = '2023-10'
  GROUP BY DATE_FORMAT(orderdate,'%y-%m'), productid
  ORDER BY totalQuantity DESC
  ;
```
* List customers whom orders in a month more than an amount of money
Business Owner wants list Of customers who have placed orders totaling more than $500 in the past month.
```mysql
SELECT c. customerid, c. firstname, c. lastname
  FROM customer c JOIN "Order" o ON c.customerid = o.customerid
  WHERE o.orderdate DATE_TRUNC( 'month' , CURRENT_DATE -INTERVAL '1 month')
  AND o.order_date < DATE_TRUNC( 'month' , CURRENT_DATE)
  GROUP BY c. customerid, c. firstname, c. lastname
  HAVING SUM(o.totalamount > 500)       -- put the amount you want
;
```
