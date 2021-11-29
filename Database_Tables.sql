CREATE DATABASE NewDatabase;
GO
--	CREATE DATABASE --

USE NewDatabase;
GO

--	ON THAT DATABASE --
CREATE TABLE Employee
(
	employee_code			VARCHAR(10)				PRIMARY KEY,		-- 1
	employee_first_name		VARCHAR(10),								-- 1
	employee_last_name		VARCHAR(30),							--2
	employee_phone			VARCHAR(10),								-- 1
	employee_gender			CHAR,								--3
	employee_address		VARCHAR(100)					--4
)
CREATE TABLE Manager
(
	manager_code			VARCHAR(10)				PRIMARY KEY,
	CONSTRAINT				manager_manager_code	FOREIGN KEY (manager_code)
							REFERENCES	Employee(employee_code)
							ON DELETE CASCADE
)

CREATE TABLE Partner_staff
(
	partner_staff_code		VARCHAR(10)				PRIMARY KEY,
	CONSTRAINT				partner_staff_partner_staff_code	FOREIGN KEY (partner_staff_code)
							REFERENCES	Employee(employee_code)
							ON DELETE CASCADE
)
CREATE TABLE Office_staff
(
	office_staff_code		VARCHAR(10)				PRIMARY KEY,
	CONSTRAINT				office_staff_office_staff_code	FOREIGN KEY (office_staff_code)
							REFERENCES	Employee(employee_code)
							ON DELETE CASCADE
)
CREATE TABLE Operation_staff
(
	operation_staff_code	VARCHAR(10)				PRIMARY KEY,
	CONSTRAINT				operation_staff_operation_staff_code	FOREIGN KEY (operation_staff_code)
							REFERENCES	Employee(employee_code)
							ON DELETE CASCADE
)
CREATE TABLE Customer
(
	customer_code			VARCHAR(10)				PRIMARY KEY,
	customer_first_name		VARCHAR(10),
	customer_last_name		VARCHAR(30),
	customer_address		VARCHAR(100),
	customer_arrearage		INT,												--5 
	staff_code				VARCHAR(10)				DEFAULT '2052708'			NOT NULL,
	CONSTRAINT				customer_staff_code		FOREIGN KEY (staff_code)
							REFERENCES	Office_staff(office_staff_code)
							ON DELETE SET DEFAULT
);
CREATE TABLE Customer_phone_number
(
	customer_code			VARCHAR(10)				NOT NULL,
	customer_phone_number	VARCHAR(10)				NOT NULL,
	PRIMARY KEY				(customer_code, customer_phone_number),
	CONSTRAINT				customer_phone_number_customer_code		FOREIGN KEY (customer_code)
							REFERENCES	Customer(customer_code)
							ON DELETE CASCADE
)
CREATE TABLE Partal_payment
(
	customer_code			VARCHAR(10)				NOT NULL,
	payment_date			DATE					DEFAULT GETDATE()		NOT NULL,
	amount					INT						NOT NULL,
	PRIMARY KEY				(customer_code, payment_date, amount),
	CONSTRAINT				partal_payment_customer_code		FOREIGN KEY (customer_code)
							REFERENCES	Customer(customer_code)
							ON DELETE CASCADE
);
CREATE TABLE Supplier
(
	supplier_code			VARCHAR(10)				PRIMARY KEY,
	supplier_name			VARCHAR(30),
	supplier_bank_account	VARCHAR(20),
	supplier_address		VARCHAR(50),
	supplier_tax_code		VARCHAR(10),
	partner_staff_code		VARCHAR(10)				DEFAULT '2052704'		NOT NULL,
	CONSTRAINT				supplier_partner_staff_code	FOREIGN KEY(partner_staff_code)
							REFERENCES	Partner_staff(partner_staff_code)
							ON DELETE SET DEFAULT
);
CREATE TABLE Supplier_phone_number
(
	supplier_code			VARCHAR(10)				NOT NULL,
	supplier_phone_number	VARCHAR(10)				NOT NULL,
	PRIMARY KEY				(supplier_code, supplier_phone_number),
	CONSTRAINT				supplier_phone_number_supplier_code	FOREIGN KEY(supplier_code)
							REFERENCES	Supplier(supplier_code)
							ON DELETE CASCADE
)
CREATE TABLE Category
(
	category_code			VARCHAR(10)				PRIMARY KEY,
	category_name			VARCHAR(30),
	color					VARCHAR(20),
	quantity				INT,
	supplier_code			VARCHAR(10)				DEFAULT '2052500'		NOT NULL,
	supply_quantity			INT						NOT NULL,
	supply_date				DATE					DEFAULT	GETDATE()		NOT NULL,
	supply_price			INT						NOT NULL,
	CONSTRAINT				category_supplier_code		FOREIGN KEY (supplier_code)
							REFERENCES	Supplier(supplier_code)
							ON DELETE SET DEFAULT
);
CREATE TABLE Current_price
(
	category_code			VARCHAR(10)				NOT NULL,
	price					INT						NOT NULL,
	update_date				DATE					DEFAULT	GETDATE()		NOT NULL,
	PRIMARY KEY				(category_code, price, update_date),
	CONSTRAINT				current_price_category_code		FOREIGN KEY (category_code)
							REFERENCES	Category(category_code)
							ON DELETE CASCADE
);
CREATE TABLE Customer_order
(
	order_code				VARCHAR(10)				PRIMARY KEY,
	order_price				INT,
	customer_code			VARCHAR(10)				NOT NULL,
	operation_staff_code	VARCHAR(10)				DEFAULT '2052703'		NOT NULL,
	process_date			DATE					DEFAULT GETDATE()		NOT NULL,
	process_time			TIME					DEFAULT '00:00:00'		NOT NULL,
	cancel_reason			VARCHAR(100),
	CONSTRAINT				customer_order_customer_code		FOREIGN KEY (customer_code)
							REFERENCES	Customer(customer_code)
							ON DELETE CASCADE,
	CONSTRAINT				customer_order_operation_staff_code		FOREIGN KEY (operation_staff_code)
							REFERENCES	Operation_staff(operation_staff_code)
							ON DELETE SET DEFAULT,						-- 2 --
);
CREATE TABLE Bolt
(
	category_code			VARCHAR(10)				DEFAULT '0001'		NOT NULL,
	bolt_code				VARCHAR(10)				NOT NULL,
	order_code				VARCHAR(10),
	bolt_length				INT,
	PRIMARY KEY				(category_code, bolt_code),
	CONSTRAINT				bolt_category_code		FOREIGN KEY (category_code)
							REFERENCES	Category(category_code)
							ON DELETE SET DEFAULT,
	CONSTRAINT				bolt_order_code		FOREIGN KEY (order_code)
							REFERENCES	Customer_order(order_code)
							ON DELETE SET NULL							-- 3 --
);
-- INSERT DATA --
-- EMPLOYEE --
INSERT dbo.Employee		VALUES	(	'2052700',	'TAN',		'TRUONG',	'0784518515', 'M', 'DISTRICT 12, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052701',	'QUAN',		'NGUYEN',	'0764851842', 'M', 'DISTRICT 5, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052702',	'HIEU',		'DO',		'0814518515', 'M', 'DISTRICT 2, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052703',	'THINH',	'LANG',		'0754568515', 'M', 'DISTRICT 1, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052704',	'DUY',		'TO',		'0784215215', 'M', 'DISTRICT 10, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052705',	'DUNG',		'PHAM',		'0716843215', 'M', 'DISTRICT 11, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052706',	'QUYEN',	'PHAN',		'0715616815', 'F', 'DISTRICT 13, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052707',	'KHANH',	'NGUYEN',	'0150356231', 'F', 'DISTRICT 8, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052708',	'TAI',		'DUC',		'0703546132', 'F', 'DISTRICT 7, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052709',	'AMY',		'NGUYEN',	'0784315613', 'F', 'DISTRICT 6, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052710',	'AN',		'LE',		'0784516155', 'F', 'DISTRICT 5, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052711',	'SANG',		'NGUYEN',	'0786841387', 'M', 'DISTRICT 4, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052712',	'SANG',		'LE',		'0798987541', 'M', 'DISTRICT 2, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052713',	'BANG',		'NGUYEN',	'0706121389', 'M', 'DISTRICT 3, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052714',	'HIEU',		'DO',		'0056684321', 'M', 'DISTRICT 1, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052715',	'HIEU',		'NGUYEN',	'0768413887', 'M', 'DISTRICT 10, HO CHI MINH CITY' )
INSERT dbo.Employee		VALUES	(	'2052716',	'CHIEN',	'DANG',		'0651320678', 'M', 'DISTRICT 10, HO CHI MINH CITY' )
-- MANAGER --
INSERT dbo.Manager		VALUES	(	'2052700')
INSERT dbo.Manager		VALUES	(	'2052701')
INSERT dbo.Manager		VALUES	(	'2052702')
INSERT dbo.Manager		VALUES	(	'2052703')
-- Partner_staff --
INSERT dbo.Partner_staff		VALUES	(	'2052704')
INSERT dbo.Partner_staff		VALUES	(	'2052705')
INSERT dbo.Partner_staff		VALUES	(	'2052706')
INSERT dbo.Partner_staff		VALUES	(	'2052707')
-- Office_staff --
INSERT dbo.Office_staff		VALUES	(	'2052708')
INSERT dbo.Office_staff		VALUES	(	'2052709')
INSERT dbo.Office_staff		VALUES	(	'2052710')
INSERT dbo.Office_staff		VALUES	(	'2052711')
-- Operation_staff --
INSERT dbo.Operation_staff		VALUES	(	'2052712')
INSERT dbo.Operation_staff		VALUES	(	'2052713')
INSERT dbo.Operation_staff		VALUES	(	'2052714')
INSERT dbo.Operation_staff		VALUES	(	'2052715')
INSERT dbo.Operation_staff		VALUES	(	'2052716')
-- Customer --
INSERT dbo.Customer		VALUES	(	'2052600', 'QUAN',		'PHAM',		'DISTRICT 12, HO CHI MINH CITY',	100,	'2052708')
INSERT dbo.Customer		VALUES	(	'2052601', 'GIANG',		'MINH',		'DISTRICT 10, HO CHI MINH CITY',	0,		'2052709')
INSERT dbo.Customer		VALUES	(	'2052602', 'KHOA',		'MINH',		'DISTRICT 11, HO CHI MINH CITY',	2550,	'2052710')
INSERT dbo.Customer		VALUES	(	'2052603', 'NHAN',		'PHAN',		'DISTRICT 8, HO CHI MINH CITY',		0,		'2052711')
-- Customer_phone_number --
INSERT dbo.Customer_phone_number VALUES	(	'2052600',	'0135489755')
INSERT dbo.Customer_phone_number VALUES	(	'2052600',	'0135554685')
INSERT dbo.Customer_phone_number VALUES	(	'2052600',	'0187559755')
INSERT dbo.Customer_phone_number VALUES	(	'2052601',	'0135889755')
-- Partal_payment --
INSERT dbo.Partal_payment	VALUES		(	'2052600',	GETDATE(), 12)
INSERT dbo.Partal_payment	VALUES		(	'2052600',	'2021-10-22', 11)
INSERT dbo.Partal_payment	VALUES		(	'2052602',	'2021-10-21', 1050)
INSERT dbo.Partal_payment	VALUES		(	'2052602',	'2021-10-20', 955)
-- Supplier --
INSERT dbo.Supplier		VALUES		(	'2052500',	'XUAN THU',		'102525261', 'D10', 'VAT1505', '2052704')
INSERT dbo.Supplier		VALUES		(	'2052501',	'NGUYEN NGA',	'102525261', 'D11', 'VAT1506', '2052705')
INSERT dbo.Supplier		VALUES		(	'2052502',	'FORREX',		'102525261', 'D15', 'VAT1507', '2052706')
INSERT dbo.Supplier		VALUES		(	'2052503',	'LIONSGROUP',	'102525261', 'D12', 'VAT1508', '2052707')
INSERT dbo.Supplier		VALUES		(	'2052504',	'SILK AGENCY',	'102525261', 'D12', 'VAT1509', '2052707')
-- Supplier_phone_number --
INSERT dbo.Supplier_phone_number		VALUES		('2052500', '0135889752')
INSERT dbo.Supplier_phone_number		VALUES		('2052501', '0135581252')
INSERT dbo.Supplier_phone_number		VALUES		('2052502', '0112389752')
INSERT dbo.Supplier_phone_number		VALUES		('2052503', '0135234552')
INSERT dbo.Supplier_phone_number		VALUES		('2052504', '0135123452')
-- Category --
INSERT dbo.Category		VALUES		(	'2052400', 'BLACKPINK',	'ROSE',			50,	'2052501',	150,	'2017-11-18',	100)
INSERT dbo.Category		VALUES		(	'2052401', 'REDSALMON',	'PINK',			89,	'2052500',	157,	'2019-11-18',	120)
INSERT dbo.Category		VALUES		(	'2052402', 'KHABANH',	'NAVY BLUE',	50,	'2052502',	156,	'2020-11-18',	150)
INSERT dbo.Category		VALUES		(	'2052403', 'NARUTO',	'SKY',			60,	'2052503',	123,	'2021-09-18',	190)
INSERT dbo.Category		VALUES		(	'2052404', 'SALON',		'SV GREEN',		70,	'2052504',	126,	'2021-09-18',	220)
INSERT dbo.Category		VALUES		(	'2052405', 'SANEST',	'SV WHITE',		80,	'2052504',	153,	GETDATE(),		250)
-- Current_price --
INSERT dbo.Current_price		VALUES		(	'2052400',	200,	'2019-11-18')
INSERT dbo.Current_price		VALUES		(	'2052401',	240,	'2020-11-18')
INSERT dbo.Current_price		VALUES		(	'2052402',	300,	'2021-09-18')
INSERT dbo.Current_price		VALUES		(	'2052403',	350,	'2021-10-13')
INSERT dbo.Current_price		VALUES		(	'2052404',	360,	GETDATE())
INSERT dbo.Current_price		VALUES		(	'2052405',	400,	GETDATE())
-- Customer_order --
INSERT dbo.Customer_order		VALUES		(	'2052300',	200,	'2052600',	'2052712',	GETDATE(),	'08:05:00', NULL)
INSERT dbo.Customer_order		VALUES		(	'2052301',	240,	'2052601',	'2052713',	GETDATE(),	'20:06:00', NULL)
INSERT dbo.Customer_order		VALUES		(	'2052302',	230,	'2052602',	'2052714',	GETDATE(),	'18:15:00', NULL)
INSERT dbo.Customer_order		VALUES		(	'2052303',	156,	'2052603',	'2052715',	GETDATE(),	'19:45:00', NULL)
INSERT dbo.Customer_order		VALUES		(	'2052304',	116,	'2052602',	'2052713',	GETDATE(),	'19:45:00', NULL)
INSERT dbo.Customer_order		VALUES		(	'2052305',	126,	'2052601',	'2052712',	GETDATE(),	'19:45:00', NULL)
-- Bolt --
INSERT dbo.Bolt					VALUES		(	'2052400',	'2052200',	'2052303',	50)
INSERT dbo.Bolt					VALUES		(	'2052401',	'2052201',	'2052303',	50)
INSERT dbo.Bolt					VALUES		(	'2052402',	'2052202',	'2052301',	50)
INSERT dbo.Bolt					VALUES		(	'2052403',	'2052203',	'2052302',	50)
INSERT dbo.Bolt					VALUES		(	'2052402',	'2052204',	'2052301',	50)
INSERT dbo.Bolt					VALUES		(	'2052405',	'2052205',	'2052302',	50)
INSERT dbo.Bolt					VALUES		(	'2052404',	'2052206',	'2052300',	50)
INSERT dbo.Bolt					VALUES		(	'2052404',	'2052207',	'2052304',	50)
INSERT dbo.Bolt					VALUES		(	'2052405',	'2052208',	'2052305',	50)
