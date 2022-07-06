# HW_Postgresql_DZ1
>1.	Создать новую базу данных с именем forum. В базе создать таблицы users, city, topic. 
Структура таблицы users: id, username,  first_name, last_name, last_activity, password
Структура таблицы city: id, city, country
Структура таблицы topic: id, name_topic, description,  last_activity, last_user
>>2.	Выбрать из таблицы users: username, first_name, last_name между id 3 и 7
```python
create database forum;
create table users (
    id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    first_name    VARCHAR(100),
    last_name     VARCHAR(100),
    last_activity VARCHAR(100),
    password      VARCHAR(300)
);
create table city ( 
    id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    city          VARCHAR(100),
    country       VARCHAR(100)  
);
create table topic (
    id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    name_topic    VARCHAR(100),
    description   VARCHAR(200),
    last_activity VARCHAR(100),
    last_user     VARCHAR(100)
);    
SELECT username, first_name, last_name FROM users
ORDER BY users
limit 5 offset 2; --OFFSET позволяет указать, с какой строки надо начинать выборку
```
# HW_Postgresql_DZ2
# Тема: Декомпозиция таблиц, создание таблиц, наполнение таблиц

Задание:

>1. Создать базу данных Lessons_5 и внутри создать таблицу workers со следующими полями id, table uuid, first_name, last_name, second_name, day_of_birth, position, description_position, salary, project, project_description, type_of_penalty, penalty_points, director, position_director.
>>2. Декомпозировать таблицу workers до 3 нормальной формы
>>>3. Наполнить таблицы после декомпозиции таблицы
```sql
create database lessons_5;
create sequence workers_id;
create table workers 
(
id int not null default nextval('workers_id') primary key,
"table" uuid,
first_name varchar,
last_name varchar,
second_name varchar,
day_of_birth date,
"position" varchar,
description_position text,
salary real,
project varchar,
project_description text,
type_of_penalty varchar,
penalty_points int,
director varchar,
position_director varchar
);

create sequence position_id;
create table "position"
(
id int not null default nextval('position_id') primary key,
"position" varchar,
description_position text
);
alter table workers drop column "position", drop column description_position;
alter table workers add column position_id int;

create sequence project_id;
create table project 
(
id int not null default nextval('project_id') primary key,
project varchar,
project_description text
);
alter table workers drop column project, drop column project_description;
alter table workers add column project_id int;

create sequence penalty_id;
create table penalty
(
id int not null default nextval('penalty_id') primary key,
type_of_penalty varchar,
penalty_points int
);
alter table workers drop column type_of_penalty, drop column penalty_points;
alter table workers add column penalty_id int;

create sequence director_id;
create table director
(
id int not null default nextval('director_id') primary key,
director varchar,
position_director varchar
);
alter table workers drop column director, drop column position_director;
alter table workers add column director_id int;
 
insert into director (director, position_director) values 
('Petrov', 'President'),
('Medvedev', 'CEO');
insert into penalty (type_of_penalty, penalty_points) values 
('Опоздание', '500');
insert into project (project, project_description) values 
('Декомпозиция таблиц', 'Декомпозировать таблицу workers до 3 нормальной формы');
insert into "position" ("position", description_position) values 
('Тестировщlessons_5ик', 'Тестирование ПО');
```
# HW_Postgresql_DZ4
Задание: 
>1.	Дана таблица с товарами, поставщиками и заказчиками необходимо привести её к 3 нормальной форме в виде таблиц:
Наименование	Поставщик	Адрес поставщика	Кол - во	Цена	Тип оплаты	Заказчик	Адрес заказчика	Кол - во
Зубная паста	ООО Ромашка	г. Буржуев, ул Пушкина, д. 8	100	25р	Наложенный пдатеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	100
Зубная нить	ООО Ромашка	г. Буржуев, ул Пушкина, д. 8	34	300р	Безналичный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	34
Ручки шариковые	ООО Ромашка	г. Буржуев, ул Пушкина, д. 8	55	12р	Наличный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	55
Вода минеральная	ООО Березка	г. Грехов, ул. Ломоносова, д. 190	2	150р	Наличный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	2
Вода минеральная	ООО Березка	г. Павлодар, ул. Ленина, д. 1	350	500р	Безналичный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	300
>>2.	Перевести декомпозированную таблицу в код с данными и внешними ключами (код приложить в виде sql файла на GitHub или GitLab)
```sql
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
```

# PRACTICE_1.07.2022
**Тема: Создание таблиц, наполнение таблиц, установка внешних связей**

Задание: 
>1.	Все скрипты сохранить и опубликовать в GitHub или GitLab.
>>2.	Создать несколько таблиц client, product, basket, country. 

Таблица клиент должна иметь следующие колонки:
  uuid, first_name, last_name, phone, email, address, create_at. confirmed, country_id, balance. 

Таблица product должна иметь следующие колонки:
  id, name_product, description_product, amount, price, provider, address_provider, country_provider. 

Таблица basket должна иметь следующие колонки: 
  id, id_client, id_product. 

Таблица country должна иметь следующие колонки: id, name, short_code.
>>3.	Декомпозировать те таблица которые необходимо.
>>>4.	Наполнить таблицы данными по 10 строк в каждой таблице, применяя внешние связи (FK). 
>>>>5.	Вывести данные таблицы product используя JOIN и присоединить зависимые таблицы.

```sql
create database baza;

create extension if not exists "uuid-ossp";
create table client
(
uuid               uuid primary key,
first_name          Varchar,
last_name           Varchar,      
phone              Varchar,    
email              Varchar,        
address            Varchar,
create_a           date,     -- дата создания
confirmed          boolean,  -- подвержден   
country_id         int,          
balance            real 
);


insert into client (uuid, first_name, last_name, phone, email, address, create_a, confirmed, balance, country_id) values
(uuid_generate_v4(), 'Петр', 'Петров', '123', '123@mail.ru', 'Ряженка 1 кв 15', '2022.01.07', 't', '1000', '1'),
(uuid_generate_v4(), 'Иван', 'Иванов', '911', 'hdfk@mail.ru', 'Ленина 4 кв 15', '2022.01.07', 'f', '10000', '2'),
(uuid_generate_v4(), 'Семен', 'Семеныч', '111', 'jdsl@mail.ru', 'Калинина 1 кв 11', '2022.01.07', 't', '999', '2'),
(uuid_generate_v4(), 'Игорь', 'Петров', '42', 'jhj@mail.ru', 'Тепличная 2 кв 1', '2022.01.07', 't', '560', '4'),
(uuid_generate_v4(), 'Лариса', 'Барс', '222', 'lio@mail.ru', 'Ряженка 1 кв 15', '2022.01.07', 'f', '50000', '6'),
(uuid_generate_v4(), 'Ванга', 'Цветкова', '4567', 'hg@mail.ru', 'Ряженка 1 кв 15', '2022.01.07', 't', '30000', '8'),
(uuid_generate_v4(), 'Леся', 'Калашникова', '45645', 'oi@mail.ru', 'Ряженка 1 кв 15', '2022.01.07', 'f', '100', '1'),
(uuid_generate_v4(), 'Вика', 'Трапезникова', '345', 'bvc@mail.ru', 'Ряженка 1 кв 15', '2022.01.07', 't', '46', '3'),
(uuid_generate_v4(), 'Володя', 'Пушкарных', '1212', 'pe@mail.ru', 'Ряженка 1 кв 15', '2022.01.07', 'f', '5766', '1'),
(uuid_generate_v4(), 'Влад', 'Дубин', '8765', 'zas@mail.ru', 'Ряженка 1 кв 15', '2022.01.07', 'f', '357', '5');


alter table client  add column  country int references country(id);



create sequence product_id;
create table product
(
id int not null default nextval('product_id') primary key,
name_product        Varchar,        --название продукта
description_produc  Varchar,        --описание
amount              int,            --кол
price               real,
provider            Varchar,
address_provider    Varchar,
country_provider    Varchar
);


create sequence provider_id;
create table provider           
(
id int not null default nextval('provider_id') primary key,
provider            Varchar,
address_provider    Varchar,
country_provider    Varchar
);
alter table product drop column provider, drop column address_provider, drop column country_provider;
alter table product add column provider_id int references provider(id);

insert into provider (provider, address_provider, country_provider) values
('ooo ро', 'Кирова 2', 'Россия'),
('ooo ср', 'Мира 3', 'Австралия'),
('ooo цу', 'Ленина 3', 'Албания'),
('ooo ыц', 'Марченко 24', 'Алжир'),
('ooo но', 'Кирова 5', 'Аргентина'),
('ooo шл', 'Пушкина 8', 'Белиз'),
('ooo шщд', 'Улица 1', 'Испания'),
('ooo зж', 'Улица 2', 'Испания'),
('ooo ло', 'Кирова 9', 'Испания'),
('ooo ти', 'Кирова 12', 'Испания');



insert into product (name_product, description_produc, amount, price, provider_id) values
('Зубная паста', 'паста', '25', '25', '1'),
('Зубная нить',  'нить', '30', '30',  '1'),
('Ручки шариковые', 'ручка', '12', '12', '3'),
('Телефон', 'сони', '100', '100', '1'),
('Стул', 'дерево', '25', '25', '5'),
('Макароны', 'твердый сорт', '15', '25', '6'),
('Карандаши', 'цветные', '20', '100', '7'),
('Маркеры', 'цветные', '25', '25', '1'),
('Стол', 'металл', '300', '400', '10'),
('Компьютер', 'мак', '13', '3', '1');

--ЗАДАНИЕ 5 ВЫВОДИМ ТАБЛИЦУ PRODUCT ИСПОЛЬЗУЯ JOIN И ПРИСОЕДИНЯЕМ ЗАВИСИМЫЕ ТАБЛИЦЫ
select product.name_product, product.description_produc, product.amount, product.price, product.provider_id, provider.address_provider 
from  product inner join provider on product.provider_id  = provider.id;


create sequence if not exists basket_id;   --СОЗДАЕМ ПОСЛЕДОВАТЕЛЬНОСТЬ ЕСЛИ ОНА НЕ СУЩЕСТВУЕТ!!!
create table basket
(
id int not null default nextval('basket_id') primary key,
client_id uuid references client(uuid),
product_id             int
);


insert into basket (id, client_id, product_id ) values
(1,(select uuid from client where first_name = 'Петр'), (SELECT id FROM product WHERE name_product = 'Зубная паста')),
(2,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Зубная нить')),
(3,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Ручки шариковые')),
(4,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Телефон')),
(5,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Стул')),
(6,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Макароны')),
(7,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Карандаши')),
(8,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Маркеры')),
(9,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Стол')),
(10,(select uuid from client where first_name = 'Иван'), (SELECT id FROM product WHERE name_product = 'Компьютер'));


alter table basket  add column  product int references product(id);

create sequence country_id;
create table country
(
id int not null default nextval('country_id') primary key,
name              Varchar,
short_cod         int
);

insert into country (name, short_cod) values
('Россия', '21'),
('США', '10'),
('Бельгия', '32'),
('Австралия', '34'),
('Канада', '45'),
('Польша', '56'),
('Латвия', '67'),
('Германия', '78'),
('Греция', '89'),
('Турция', '90');
```
