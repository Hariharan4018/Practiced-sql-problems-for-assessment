
create database Practice_1

use Practice_1

-- 1. Customer
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerPhone VARCHAR(15)
);

-- 2. Restaurant
CREATE TABLE Restaurant (
    RestaurantID INT PRIMARY KEY,
    RestaurantName VARCHAR(100),
    Phone VARCHAR(15)
);

-- 3. FoodItem
CREATE TABLE FoodItem (
    FoodItemID INT PRIMARY KEY,
    FoodName VARCHAR(100),
    RestaurantID INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

-- 4. Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 5. OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    FoodItemID INT,
    Quantity INT,
    SubPrice decimal(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (FoodItemID) REFERENCES FoodItem(FoodItemID)
);

-- 6. DeliveryAgent
CREATE TABLE DeliveryAgent (
    AgentID INT PRIMARY KEY,
    AgentName VARCHAR(100),
    Phone VARCHAR(15)
);

-- 7. Delivery
CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY,
    OrderItemID INT,
    AgentID INT,
    DeliveryStatus VARCHAR(50),
    DeliveryStartTime DATETIME,
    DeliveryEndTime DATETIME,
    FOREIGN KEY (OrderItemID) REFERENCES OrderItems(OrderItemID),
    FOREIGN KEY (AgentID) REFERENCES DeliveryAgent(AgentID)
);

-- 8. Payment
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATETIME,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- 9. Feedback
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(255),
    FeedbackDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),
    CONSTRAINT UQ_Feedback_Customer_Restaurant UNIQUE (CustomerID, RestaurantID)
);
-- Customers
INSERT INTO Customer VALUES
(1, 'Arjun Mehta', '9876543210'), (2, 'Priya Sharma', '9123456780'), (3, 'Ravi Kumar', '9012345678'),
(4, 'Sneha Das', '9988776655'), (5, 'Amit Jain', '9001122334'), (6, 'Kavya Nair', '8899776655'),
(7, 'Rohan Singh', '8787878787'), (8, 'Nisha Verma', '9090909090'), (9, 'Manish Tiwari', '9191919191'),
(10, 'Divya Reddy', '8888999900');

-- Restaurants
INSERT INTO Restaurant VALUES
(1, 'Spicy Treats', '0801234567'), (2, 'Veggie Delight', '0802345678'), (3, 'Punjabi Tadka', '0803456789'),
(4, 'South Flavors', '0804567890'), (5, 'The Foodie Hub', '0805678901'), (6, 'Tandoori Nights', '0806789012'),
(7, 'Masala Kingdom', '0807890123'), (8, 'Ghar Ka Khana', '0808901234'), (9, 'Schezwan Express', '0809012345'),
(10, 'Biryani Palace', '0810123456');

-- Food Items
INSERT INTO FoodItem VALUES
(1, 'Paneer Butter Masala', 3, 180), (2, 'Veg Biryani', 10, 160), (3, 'Masala Dosa', 4, 90),
(4, 'Chole Bhature', 3, 120), (5, 'Spring Roll', 9, 110), (6, 'Tandoori Roti', 6, 25),
(7, 'Dal Makhani', 1, 150), (8, 'Pav Bhaji', 5, 100), (9, 'Manchurian', 9, 130), (10, 'Butter Naan', 6, 35);

-- Orders
INSERT INTO Orders VALUES
(101, 1, '2025-06-01 12:00'), (102, 2, '2025-06-01 13:30'), (103, 3, '2025-06-01 14:00'),
(104, 4, '2025-06-02 11:00'), (105, 5, '2025-06-02 18:30'), (106, 6, '2025-06-02 19:00'),
(107, 7, '2025-06-03 12:00'), (108, 8, '2025-06-03 13:00'), (109, 9, '2025-06-03 14:00'),
(110, 10, '2025-06-04 12:00');

create sequence orderItemSequence
start with 1010
increment by 1

-- Order Items
INSERT INTO OrderItems (OrderItemID, OrderID, FoodItemID, Quantity, SubPrice) VALUES
(1001, 101, 1, 2, 360),   
(1002, 101, 2, 1, 200),   
(1003, 102, 4, 3, 750),   
(1004, 103, 6, 4, 480),   
(1005, 104, 5, 2, 300),   
(1006, 105, 1, 1, 180),   
(1007, 106, 8, 2, 440),   
(1008, 107, 3, 3, 240),   
(1009, 108, 9, 1, 20),    
(1010, 109, 7, 2, 200);   

-- Delivery Agents
INSERT INTO DeliveryAgent VALUES
(201, 'Suresh', '9991112222'), (202, 'Ganesh', '9992223333'), (203, 'Ravi', '9993334444'),
(204, 'Manoj', '9994445555'), (205, 'Hari', '9995556666'), (206, 'Rakesh', '9996667777'),
(207, 'Vijay', '9997778888'), (208, 'Pawan', '9998889999'), (209, 'Kumar', '9999990000'),
(210, 'Raj', '8881110000');

-- Deliveries
INSERT INTO Delivery VALUES
(301, 1001, 201, 'Delivered', '2025-06-01 12:10', '2025-06-01 12:40'),
(302, 1002, 201, 'Delivered', '2025-06-01 12:20', '2025-06-01 12:50'),
(303, 1003, 202, 'Delivered', '2025-06-01 13:35', '2025-06-01 14:05'),
(304, 1004, 203, 'Delivered', '2025-06-01 14:10', '2025-06-01 14:45'),
(305, 1005, 204, 'Delivered', '2025-06-02 11:10', '2025-06-02 11:35'),
(306, 1006, 205, 'Delivered', '2025-06-02 18:35', '2025-06-02 19:10'),
(307, 1007, 206, 'Delivered', '2025-06-02 19:05', '2025-06-02 19:45'),
(308, 1008, 207, 'Delivered', '2025-06-03 12:10', '2025-06-03 12:40'),
(309, 1009, 208, 'Delivered', '2025-06-03 13:10', '2025-06-03 13:50'),
(310, 1010, 209, 'Delivered', '2025-06-03 14:10', '2025-06-03 14:35');

-- Payments
INSERT INTO Payment VALUES
(401, 101, 520, '2025-06-01 12:50', 'Paid'), (402, 102, 360, '2025-06-01 14:10', 'Paid'),
(403, 103, 100, '2025-06-01 14:50', 'Pending'), (404, 104, 220, '2025-06-02 11:50', 'Paid'),
(405, 105, 180, '2025-06-02 19:15', 'Paid'), (406, 106, 200, '2025-06-02 19:50', 'Paid'),
(407, 107, 270, '2025-06-03 12:50', 'Paid'), (408, 108, 130, '2025-06-03 13:55', 'Paid'),
(409, 109, 300, '2025-06-03 14:45', 'Paid'), (410, 110, 0, '2025-06-04 12:45', 'Failed');

-- Feedbacks
INSERT INTO Feedback VALUES
(501, 1, 3, 5, 'Amazing Paneer Butter Masala', '2025-06-01'),
(502, 2, 3, 4, 'Good taste but spicy', '2025-06-01'),
(503, 4, 4, 5, 'Authentic South Indian', '2025-06-02'),
(504, 5, 1, 4, 'Nice dal and roti', '2025-06-02'),
(505, 6, 5, 3, 'Average pav bhaji', '2025-06-02'),
(506, 7, 4, 5, 'Loved the dosa', '2025-06-03'),
(507, 8, 9, 4, 'Crispy rolls', '2025-06-03'),
(508, 9, 1, 5, 'Superb service', '2025-06-03'),
(509, 10, 6, 3, 'Good bread', '2025-06-04'),
(510, 3, 6, 2, 'Late delivery', '2025-06-01');


--Write a query to display: CustomerName, RestaurantName, FoodName, Quantity, SubPrice for all orders.

select c.CustomerName,r.RestaurantName,f.FoodName,ot.Quantity,ot.SubPrice from Orders o
join Customer c on c.CustomerID=o.CustomerID
join OrderItems ot on ot.OrderId=o.OrderID
join FoodItem f on f.FoodItemID=ot.FoodItemID
join Restaurant r on r.RestaurantID=f.RestaurantID


--Display names of customers who have ordered "Paneer Butter Masala
select c.CustomerName from Orders o
join Customer c on c.CustomerID=o.CustomerID
join OrderItems ot on ot.OrderId=o.OrderID
join FoodItem f on f.FoodItemID=ot.FoodItemID
where f.FoodName='Paneer Butter Masala'

--Show delivery agents who handled more than 3 deliveries.
select da.AgentName from Delivery d
join DeliveryAgent da on da.AgentID=d.AgentID
group by da.AgentID,da.AgentName
having count(*)>1

--List orders where the total amount is greater than ₹500.
select o.orderId from orders o 
join OrderItems ot on ot.OrderID=o.OrderID
group by o.OrderID
having sum(ot.subprice)>500


--Display orders placed from more than one restaurant
select  o.orderid from orders o
join OrderItems ot on o.OrderID=ot.OrderID
join FoodItem f on f.FoodItemID=ot.FoodItemID
group by o.OrderID
having count(distinct f.RestaurantID) >1

--Show total number of items ordered per customer.
select c.customerName,count(*) as NoOfItemsOrdered
from orders o
join Customer c on c.CustomerID=o.CustomerID
join OrderItems ot on o.OrderID=ot.OrderID
group by c.CustomerID,c.CustomerName

--Show total revenue generated per restaurant.

select r.RestaurantName,sum(ot.SubPrice) from OrderItems ot
join FoodItem f on f.FoodItemID=ot.FoodItemID
join Restaurant r on r.RestaurantID=f.RestaurantID
group by r.RestaurantID,r.RestaurantName

--Show average delivery time per delivery agent.
select da.AgentName,avg(datediff(MINUTE,d.DeliveryStartTime,d.DeliveryEndTime)) from delivery d
join DeliveryAgent da on d.AgentID=da.AgentID
group by da.AgentID,da.AgentName

--Find customers who have never placed an order.

INSERT INTO Customer (CustomerID, CustomerName, CustomerPhone) VALUES
(11, 'Meera Krishnan', '9876543211'),
(12, 'Arjun Menon', '9988776655'),
(13, 'Sneha Iyer', '9123456780'),
(14, 'Ravi Teja', '9090909090'),
(15, 'Fatima Khan', '9012345678')

select CustomerName from customer c
left join Orders o on c.CustomerID=o.CustomerID
where o.OrderID is null

--Display the most ordered food item by quantity.

select top 1 f.FoodName,sum(quantity) from OrderItems o
join FoodItem f on f.FoodItemID=o.FoodItemID
group by f.FoodItemID,f.FoodName
Order by sum(Quantity) desc


--List customers who made the highest total payment.
select top 1 c.CustomerName,sum(ot.SubPrice)  from orders o
join OrderItems ot on ot.OrderID=o.OrderID
join Customer c on c.CustomerID=o.CustomerID
group by c.CustomerID,c.CustomerName
Order by sum(ot.SubPrice) desc


--Create a view vw_OrderSummary to show:OrderID, CustomerName, TotalAmount, OrderDate, PaymentStatus

create or alter view vw_OrderSummary
as
select c.CustomerName,o.OrderID,o.OrderDate,p.Amount,p.PaymentStatus from Orders o
join OrderItems ot on o.OrderID=ot.OrderID
join Customer c on c.CustomerID=o.CustomerID
join Payment p on p.OrderID=o.OrderID


select * from vw_OrderSummary

--Write a scalar function that takes @RestaurantID and returns total orders placed for that restaurant.

create or alter function fn_RestuaruntOrders
(@ResturentId int)
returns int
as
begin
declare @totalOrders int
select @totalOrders=count(distinct od.OrderID) from OrderItems od
join FoodItem f on f.FoodItemID=od.FoodItemID
where f.RestaurantID=@ResturentId
return @totalOrders
end

select dbo.fn_RestuaruntOrders(3)

select * from OrderItems
join FoodItem on FoodItem.FoodItemID=OrderItems.FoodItemID


--Create a stored procedure sp_AssignDeliveryAgent that takes @OrderItemsID, @AgentID and inserts a new delivery.

create or alter proc sp_assignDeliveryPerson
(@OrderItemId int,@AgentId int)
as
begin
declare @DeliveryId int
select top 1 @DeliveryId=deliveryId from Delivery order by deliveryid desc
insert into Delivery values(@DeliveryId+1,@OrderItemId,@AgentId,'Pending',getdate(),DATEADD(day,2,getdate()))
end

exec sp_assignDeliveryPerson @orderItemId=1001,@AgentId=201

select * from Delivery



--Write a stored procedure sp_NewOrder to insert a new order into Orders table

create or alter proc sp_NewOrder(
@OrderId int,
@CustomerId int
)
as
begin
insert into orders values(@OrderId,@CustomerId,getdate())
end

exec sp_NewOrder @OrderId=11,@customerId=1

select * from orders




create sequence OrderSequence
start with 110
increment by 1



create or alter procedure InsertNewOrder
(@CustomerId int,@OrderDate datetime,@Temptable sampledata readonly)
as
begin 
declare @TotalAMount decimal(10,2)

select @TotalAMount=sum(subprice) from @Temptable
if @TotalAMount<100
begin raiserror('OrderValue Must Be above 100',16,1)
return
end
declare @OrderID int
set @OrderID=next value for orderSequence
insert into orders values(@OrderId,@CustomerId,@OrderDate)

insert into OrderItems(OrderID,OrderItemID,FoodItemID,Quantity,SubPrice)
select @OrderID,orderItemId,FoodItemId,Quantity,SubPrice from @Temptable
end


 
create type SampleData as table(
OrderItemId int not null,
FoodItemId int not null,
Quantity int not null,
Subprice decimal(10,2) not null
)
declare @Temptable SampleData
 insert into @Temptable values(next value for orderItemSequence,1,4,1000),(next value for orderItemSequence,2,5,1000)
declare @OrderDate datetime
set @OrderDate=getdate()
exec InsertNewOrder @CustomerId=1,@OrderDate=@OrderDate,@Temptable=@Temptable

select * from Orders

select * from OrderItems

create or alter trigger tr_DeliverystatusUpdate
on delivery
for insert 
as
begin
declare @DeliveryId int
select @DeliveryId=DeliveryId from inserted
 Update delivery set deliverystatus='dispatched' where deliveryID=@DeliveryId
end

exec sp_assignDeliveryPerson @OrderItemID=1001,@AgentId=201
select * from Delivery

create type Phonetype from varchar(10) not null

alter table customer alter column customerPhone PhoneType


create nonclustered index ix_RestaturentName on Restaurant(Restaurantname)
include(Phone)



alter table feedback add Constraint U_Customer Unique( customerId)