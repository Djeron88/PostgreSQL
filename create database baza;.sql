Тема: Создание таблиц, наполнение таблиц, установка внешних связей

Задание: 
1.	Все скрипты сохранить и опубликовать в GitHub или GitLab.
2.	Создать несколько таблиц client, product, basket, country. 

Таблица клиент должна иметь следующие колонки. uuid, first_name, last_name, phone, email, address, create_at. confirmed, country_id, balance. 

Таблица product должна иметь следующие колонки: id, name_product, description_product, amount, price, provider, address_provider, country_provider. 

Таблица basket должна иметь следующие колонки: id, id_client, id_product. 

Таблица country должна иметь следующие колонки: id, name, short_code.
3.	Декомпозировать те таблица которые необходимо.
4.	Наполнить таблицы данными по 10 строк в каждой таблице, применяя внешние связи (FK). 
5.	Вывести данные таблицы product используя JOIN и присоединить зависимые таблицы.


create database baza;

create sequence client_id;
create table client
(
id int not null default nextval('client_id') primary key,
uuid               uuid,
first_nam          Varchar,
last_nam           Varchar,      
phone              Varchar,    
email              Varchar,        
address            Varchar,
create_a           date,     -- дата создания
confirmed          boolean,  -- подвержден   
country_id         int,            --country_id
balance            real 
);


create extension if not exists "uuid-ossp";
insert into client (uuid, first_nam, last_nam, phone, email, address, create_a, confirmed, balance, country_id) values
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
alter table client  add column  basket int references basket(id);


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

select product.name_product, product.description_produc, product.amount, product.price, product.provider_id, provider.address_provider 
from  product inner join provider on product.provider_id  = provider.id;


create sequence basket_id;
create table basket
(
id int not null default nextval('basket_id') primary key,
uuid                   uuid,
client_id              int,
product_id             int
);

create extension if not exists "uuid-ossp";
insert into basket (uuid, client_id, product_id) values
(uuid_generate_v4(), '1', '1'),
(uuid_generate_v4(), '2', '2'),
(uuid_generate_v4(), '3', '3'),
(uuid_generate_v4(), '4', '4'),
(uuid_generate_v4(), '5', '5'),
(uuid_generate_v4(), '6', '6'),
(uuid_generate_v4(), '7', '7'),
(uuid_generate_v4(), '8', '8'),
(uuid_generate_v4(), '9', '9'),
(uuid_generate_v4(), '10', '10');

alter table basket  add column  product int references product(id);

create sequence country_id;
create table country
(
id int not null default nextval('country_id') primary key,
name              Varchar,
short_cod         int
);

insert into country (name, short_cod) values
('Вася', '21'),
('Игорь', '10'),
('Семен', '32'),
('Ирина', '34'),
('Ангелина', '45'),
('Чарльз', '56'),
('Костя', '67'),
('Данил', '78'),
('Рома', '89'),
('Влад', '90');

