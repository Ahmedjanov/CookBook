
--create database CookBook;

use CookBook;

create table dishes_type (
code_dishes_type int IDENTITY(1,1) primary key,
name_dishes_type varchar(20) not null
);

create table dishes (
code_dishes int IDENTITY(1,1) primary key,
name_dishes varchar(20) not null,
code_dishes_type int not null,
price_dishes real not null,
foreign key(code_dishes_type) references dishes_type(code_dishes_type)
);

create table units (
code_unit int IDENTITY(1,1) primary key,
name_unit varchar(20) not null
);

create table product (
code_product int IDENTITY(1,1) primary key,
name_product varchar(35) not null,
price_product real not null,
code_unit int not null,
foreign key (code_unit) references units(code_unit)
);

create table dishes_formula (
code_formula int IDENTITY(1,1) primary key,
code_dishes int not null,
code_ingredient int not null,
count_ingredient float not null,
unit_ingredient int not null,
foreign key (unit_ingredient) references units(code_unit),
foreign key(code_dishes) references dishes(code_dishes),
foreign key(code_ingredient) references product(code_product)
);

create table orders (
code_order int IDENTITY(1,1) primary key,
code_dishes int not null,
number_order int not null,
count_order int not null,
price_order real not null,
date_order date not null,
foreign key (code_dishes) references dishes(code_dishes),
);


create table descriptions(
code_description int IDENTITY(1,1) primary key,
code_dishes int not null,
descriptions text not null
foreign key (code_dishes) references dishes(code_dishes)
);

/*
-- units
insert into units(name_unit) values('����������'),
	('����'),
	('�����'),
	('����'),
	('�����'),
	('�������'),
	('������'),
	('��������'),
	('������'),
	('��. �����'),
	('�� �����');

-- type of dishes
insert into dishes_type(name_dishes_type) values('������'),
	('������'),
	('��������'),
	('�������'),
	('������');

-- dishes 2
insert into dishes(name_dishes,code_dishes_type,price_dishes) values('����',2,200),
	('������',2,230),
	('�����',2,190),
	('�������',2,190),
	('�������',2,190),
	('��������',2,85),
	('�������� ������',2,85),
	('������ � ����',2,80),
	('���� �� ����������',2,90);

-- dishes 1
insert into dishes(name_dishes,code_dishes_type,price_dishes) values('������ �������',1,70),
	('����',1,110),
	('��� ����������',1,100),
	('��� � �������������',1,90),
	('��� � ������',1,110),
	('���������� ���',1,85);


-- dishes 3
insert into dishes(name_dishes,code_dishes_type,price_dishes) values('�������',3,170),
	('��-��',3,130),
	('��� � ����',3,90),
	('������� ������',3,145),
	('���������',3,80),
	('����� ���',3,70);

-- dishes 4
insert into dishes(name_dishes,code_dishes_type,price_dishes) values('����� �����',4,300),
	('�����',4,250),
	('���� ��������',4,250),
	('���� � ���������',4,450),
	('����� ����� ������',4,250),
	('������� ������',4,480);

-- dishes 5
insert into dishes(name_dishes,code_dishes_type,price_dishes) values('�����',5,120);

-- product
insert into product (name_product,price_product,code_unit) values('���������',248,1),
	('������� �����������',39,1),
	('�����',28,1),
	('�������',388,1),
	('��������',195,1),
	('������� ���������',68,1),
	('������� �������',89,1),
	('������� ������',65,1),
	('������� ��������������',55,1),
	('�������� ������� �������',88,1),
	('������ ��������� ����',148,1),
	('�������� �����',330,1),
	('����� ��������',140,1),
	('������ �������',500,1),
	('������',180,1),
	('������ �������',70,1),
	('����� �������, ����������',225,1),
	('������',35,1),
	('�������',110,5),
	('������� �����',38,1),
	('������� �������',25,1),
	('������� ������',65,1),
	('������� ������� ��������',20,1),
	('������',30,1),
	('��� ��������',15,1),
	('��� �������� ��������',17,1),
	('��� �������',50,1),
	('�������� ��',28,4),
	('������',52,2),
	('��� ����� ������ ����',136,1),
	('��� ����������� ���������',35,1),
	('��� �����',40,1),
	('��� ��������',40,1),
	('��������',78,1),
	('���������',25,1),
	('�������',78,1),
	('����� ������������',180,2),
	('����',25,2),
	('����',35,1),
	('����� ������� (�����������)',170,1),
	('����� ������� �������',89,1),
	('����� ������� �������',89,4),
	('�����',180,1),
	('�������',121,6),
	('������� ��� �����',165,1);


-- formula of dishes
insert into dishes_formula(code_dishes,code_ingredient,unit_ingredient,count_ingredient) values(15,34,9,1),
	(15,35,4,3),
	(15,25,1,1),
	(15,37,10,3),
	(15,38,2,2.5),
	(15,39,11,0),
	(15,42,11,0),
	(15,43,11,0),
	(15,44,11,0),
	(15,45,11,0);

-- descriptions for dishes
insert into descriptions(code_dishes,descriptions) values
	(15,'���� ��� �� �������� ������������� ����� ������� � ����� �������� � ���� �������� ������ ������� � ������. ��! ��� �� �����, ����� ��� �� �������� ���������� ����� �������.');

-- example order
insert into orders(code_dishes,number_order,count_order,price_order,date_order) values
	(15,1,1,(select price_dishes from dishes where code_dishes = 15),(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), DAY(GETDATE()))));
*/

-- select info about dishes given types
create or alter procedure DishesInfo
@dishes_type nvarchar(20) = '������'
as
Select dishes.name_dishes,dishes_type.name_dishes_type,dishes.price_dishes,descriptions.descriptions 
from dishes
inner join dishes_type on dishes.code_dishes_type = dishes_type.code_dishes_type
left join descriptions on dishes.code_dishes = descriptions.code_dishes
where dishes.code_dishes_type = (select dishes_type.code_dishes_type from dishes_type where dishes_type.name_dishes_type = @dishes_type)
order by dishes.name_dishes 
go

-- select cost price dishes
create or alter procedure priceDish
@codeDish int
as
	return (select sum(count_ingredient*price_product) 
	from dishes_formula
	inner join product
	on dishes_formula.code_ingredient = product.code_product
	where dishes_formula.code_dishes = @codeDish
	);

declare @p float
exec @p = priceDish 265
select @p
go
--select * from orders
--select * from dishes
-- procedure for countdown used products
create or alter procedure allPriceUsedProducts
@date1 date ,
@date2 date 
as
declare @sum float = 0;
declare @firstID int = (select min(code_order) from orders where date_order between @date1 and @date2);
declare @lastID int = (select max(code_order) from orders where date_order between @date1 and @date2);
while @firstID <= @lastId
begin
	if ((select code_order from orders where code_order = @firstID) = @firstID)
	begin
		declare @dishCode int = (select code_dishes from orders where code_order = @firstID);
		declare @priceDish float;
		exec @priceDish = priceDish @dishCode;
		declare @countDish int = (select count_order from orders where code_order = @firstID);
		set @sum = @sum + @priceDish*@countDish;
	end
	set @firstID = @firstID + 1;
end
Select @sum as Summ

exec allPriceUsedProducts '2022-05-22','2022-05-22'
go

--select * from orders
-- select used prodcuts
create or alter procedure usedProductInOrder
@numberOrder int
as
begin
select product.name_product,dishes_formula.count_ingredient*orders.count_order as _Count,product.price_product as _Price,(dishes_formula.count_ingredient*product.price_product*orders.count_order) as _Cost
from product
inner join dishes_formula
on dishes_formula.code_ingredient = product.code_product
inner join orders
on orders.code_dishes = dishes_formula.code_dishes
where orders.number_order = @numberOrder 
--group by product.name_product,dishes_formula.count_ingredient*orders.count_order,product.price_product,(dishes_formula.count_ingredient*product.price_product*orders.count_order)
order by product.name_product
end
go

exec usedProductInOrder 1
exec usedProductInOrder 2
go
--select * from orders

-- check exist order via number of order
create or alter procedure checkExist
@numberID int
as
if ((select count(number_order) from orders where number_order = @numberID) >= 1)
begin
	select 'True'
end
else
begin
	select 'False'
end

exec checkExist 1
go


--
--
--
--

-- triger for uniq data for dishes
create or alter trigger UniqData
on dishes
for insert 
as
BEGIN    
	Declare @name varchar(25);
	Set @name = (Select name_dishes from inserted);
	IF ((select count(name_dishes) from dishes where name_dishes = @name)>=2)
		BEGIN
			ROLLBACK TRAN
			select 'It is not allowed to insert unique data'
		END
END	
go

-- triger for uniq data for types of dishes
create or alter trigger UniqData1
on dishes_type
for insert 
as
BEGIN
	Declare @name varchar(25);
	Set @name = (Select name_dishes_type from inserted);
	IF ((select count(name_dishes_type) from dishes_type where name_dishes_type = @name)>=2)		
		BEGIN
				ROLLBACK TRAN
				select 'It is not allowed to insert unique data'
		END
END	
go

-- triger for uniq data for units
create or alter trigger UniqData2
on units
for insert 
as
BEGIN     
	Declare @name varchar(25);
	Set @name = (Select name_unit from inserted);
	IF ((select count(name_unit) from units where name_unit = @name)>=2)		
		BEGIN
			ROLLBACK TRAN
			select 'It is not allowed to insert unique data'
		END
END	
go

-- triger for uniq data for products
create or alter trigger UniqData3
on product
for insert 
as
BEGIN     
	Declare @name varchar(25);
	Set @name = (Select name_product from inserted);
	IF ((select count(name_product) from product where name_product = @name)>=2)		
		BEGIN
			ROLLBACK TRAN
			select 'It is not allowed to insert unique data'
		END
END	
go

-- triger for uniq data for descriptions
create or alter trigger UniqData4
on descriptions
instead of insert 
as
BEGIN     
	Declare @code int;
	Set @code = (Select code_dishes from inserted);
	IF exists(select code_dishes from descriptions where code_dishes = @code)		
		BEGIN
			update descriptions set descriptions = (select descriptions from inserted where code_dishes = @code) where code_dishes = @code;
			--select 'It is not allowed to insert unique data'
		END
	else
		begin
			insert into descriptions(code_dishes,descriptions)
			select code_dishes,descriptions from inserted
		end
END	
go

/*
/********************************************************/
Select name_unit from units where code_unit = (select code_unit from product where name_product = '����')  
use [CookBook]
select name_unit from units where code_unit = 1


/*********************************************************/

select code_unit from product where name_product = '���������'

select name_unit from units where code_unit = 1
*/


select * from dishes


