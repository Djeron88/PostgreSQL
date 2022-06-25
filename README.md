# HW_Postgresql_DZ1
>1.	Создать новую базу данных с именем forum. В базе создать таблицы users, city, topic. 
Структура таблицы users: id, username,  first_name, last_name, last_activity, password
Структура таблицы city: id, city, country
Структура таблицы topic: id, name_topic, description,  last_activity, last_user
>>2.	Наполнить базу данных forum по 10 строк на каждую таблицу, заполнить все кроме last_activity, 
last_user. Базу данных forum приложить к заданию.
>>>3.	Выбрать из таблицы users: username, first_name, last_name между id 3 и 7

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
