-- Customers and Orders tables
CREATE TABLE Customers (
    customerId INT PRIMARY KEY,
    customerName VARCHAR(100)
);

CREATE TABLE Orders (
    orderId INT PRIMARY KEY,
    customerId INT,
    orderDate DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
);

-- Insert data into Customers
INSERT INTO Customers (customerId, customerName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eve');

-- Insert data into Orders 
INSERT INTO Orders (orderId, customerId, orderDate, amount) VALUES
(101, 1, '2025-06-10', 300.00),
(102, 1, '2025-05-20', 250.00),
(103, 2, '2025-04-01', 400.00),
(104, 2, '2025-02-25', 150.00),
(105, 3, '2025-03-10', 500.00),
(106, 3, '2024-12-15', 200.00),
(107, 4, '2025-05-01', 700.00),
(108, 5, '2025-01-01', 100.00),
(109, 4, '2025-06-15', 150.00);


insert into Customers (customerId,customerName) values
(6,'alice')

select customerName,Row_number() over(Partition by customername Order by customerNAme asc) from customers

with CustomerSpendingInPastMonths as(

select c.customerId,c.customerName ,sum(o.amount) as amount from Customers c
join Orders o on o.customerId=c.customerId
where o.orderDate>= DateAdd(MONTH,-6,getdate())
group by c.customerId,c.customerName
),
rankedData as(
select *,dense_rank() over(Order by amount desc) as rank from CustomerSpendingInPastMonths
)

select * from rankedData where rank<=3



--Show total sales per month and the percentage growth compared to the previous month.

with MonthlySales as(
select month(Orderdate) as month ,sum(amount) as TotalAmount from orders
group by month(orderDate)
)
select w1.TotalAmount as PreviousMonthsale ,w2.TotalAmount as cuurentmonthsale,(((w2.TotalAmount-w1.TotalAmount)/w1.TotalAmount)*100) as growthInPercentage ,rank() over(order by (((w2.TotalAmount-w1.TotalAmount)/w1.TotalAmount)*100) desc) from MonthlySales w1
 left join  MonthlySales w2  on w2.month-w1.month=1
 where w2.month is not null