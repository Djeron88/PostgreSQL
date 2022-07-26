Тема: Нормализация таблиц

Задание: 
1.	Дана таблица с товарами, поставщиками и заказчиками необходимо привести её к 3 нормальной форме в виде таблиц:
2.	Перевести декомпозированную таблицу в код с данными и внешними ключами (код приложить в виде sql файла на GitHub или GitLab)

create database HW_DZ_4;

create sequence products_id;
create table products
(
id int not null default nextval('products_id') primary key,
"table"           uuid,
Name              Varchar,
Provider          Varchar,      -- поставщик
Supplier_address  Varchar,    -- адрес постащика
Amount_1            int,         -- кол-во
Price             real,
Payment_type      Varchar,     -- Тип оплаты
Customer          Varchar,     -- Заказчик
Customer_address  Varchar,     -- Адрес заказчика
Amount_2             int 
);



create sequence Provider_id;
create table Provider           -- ПОСТАВЩИК
(
id int not null default nextval('Provider_id') primary key,
Provider          Varchar,
Supplier_address  Varchar
);
alter table products drop column Provider, drop column Supplier_address;
alter table products add column Provider_id int references Provider(id);

insert into Provider (Provider, Supplier_address) values
('ООО Ромашка', 'г. Буржуев, ул Пушкина, д. 8'),
('ООО Березка', 'г. Грехов, ул. Ломоносова, д. 190'),
('ООО Березка', 'г. Павлодар, ул. Ленина, д. 1');

create sequence Customer_id;
create table Customer           -- ЗАКАЗЧИК
(
id int not null default nextval('Customer_id') primary key,
Customer          Varchar,     
Customer_address  Varchar,     
Amount_2             int 
);
alter table products  drop column Customer, drop column Customer_address, drop Amount_2;
alter table products  add column Customer_id int references Customer(id);

ALTER TABLE customer RENAME COLUMN Amount_2 TO Amount;   -- Заменяем атрибут в customer

insert into Customer (Customer, Customer_address, Amount) values
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '100'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '34'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '55'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '2'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '300');

ALTER TABLE products  RENAME COLUMN Amount_1 TO Amount;   -- Заменяем атрибут в products

create extension if not exists "uuid-ossp"; --создаем генератор id

insert into products ("table", Name, amount, price, payment_type, Provider_id, Customer_id)
values 
(uuid_generate_v4(), 'Зубная паста', '100', '25', 'Наложенный пдатеж', '1', '1'),
(uuid_generate_v4(), 'Зубная нить',  '34', '300', 'Безналичный платеж',  '1', '2'),
(uuid_generate_v4(), 'Ручки шариковые', '55', '12', 'Наличный платеж', '1', '3'),
(uuid_generate_v4(), 'Вода минеральная', '2', '150', 'Наличный платеж', '2', '4'),
(uuid_generate_v4(), 'Вода минеральная', '350', '500', 'Безналичный платеж', '2', '5');

