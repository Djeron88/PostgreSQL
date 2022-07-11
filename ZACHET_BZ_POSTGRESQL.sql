ЗАЧЕТ
  
Курс: «Теория база данных»

Задание: 
1.	Все скрипты сохранить и опубликовать в GitHub или GitLab (если заполняете данные на кириллице, то необходимо изменить кодировку интерфейса на UTF-8).
2.	Спроектировать базу данных для простого сайта с фильмами, на сайте присутствует личный кабинет, система подписок , фильмы, комментарии, новости. Декомпозировать таблицы если это необходимо.
3.	Наполнить таблицу по 5 строк в каждой таблице, используя подзапросы.
4.	Вывести данные используя JOIN. 

create database "OFFSET_DB_QA116";

-- ЛИЧНЫЙ КАБИНЕТ 
create sequence Personal_Area_id;  
create table Personal_Area
(
id int not null default nextval('Personal_Area_id') primary key,
First_name          VARCHAR,
Last_name           VARCHAR,      
Phone               VARCHAR,    
Email               VARCHAR,        
Address             VARCHAR,
age                 NUMERIC,
Balance             REAL
);

-- СИСТЕМА ПОДПИСОК
create sequence if not exists Subscribe_id;    
create table Subscribe
(
id int not null default nextval('Subscribe_id') primary key,
First_name_id   int references Personal_Area(id),
Balance_id   int references Personal_Area(id),
Monthly      VARCHAR,            -- ежемесячное 
Annual       VARCHAR            -- годовое
);

create sequence if not exists Comments_id;   
create table Comments
(
id int not null default nextval('Comments_id') primary key,
Commentss     text,
"Data"        DATE
);

 -- ФИЛЬМЫ
create sequence  if not exists Movies_id;  
create table Movies
(
id int not null default nextval('Movies_id') primary key,
Movie_title        VARCHAR,
Movie_description  VARCHAR,
Comments_id           int references comments(id),
Fantasy            VARCHAR,
Action_movie       VARCHAR,
News_id            int
);


-- НОВОСТИ
create sequence if not exists News_id;
create table News
(
id int not null default nextval('News_id') primary key,
News       TEXT 
);

alter table movies  add column  News int references news(id);

-- ЛИЧНЫЙ КАБИНЕТ
insert into Personal_Area (First_name, Last_name, Phone, Email, Address, Balance) values
    ('Иван', 'Иванов', '1234', 'ivan@main.ru', 'Кирова 3', '2000'),
    ('Ирина', 'Миллер', '832978', 'ira78@main.ru', 'Ленина 12', '3000'),
    ('Андрей', 'Козловский', '3890', 'KA@main.ru', 'Мамина 17', '4000'),
    ('Игорь', 'Лукинских', '8493', 'yui@main.ru', 'Пушкина 1', '5000'),
    ('Виктор', 'Викторов', '8351283', 'Victor@main.ru', 'Победа 129', '6000');

-- СИСТЕМА ПОДПИСОК
insert into Subscribe (First_name_id, Balance_id, Monthly, Annual) values
    ('1', '1', 'Январь', 'Годовое'),
    ('2', '2', 'Февраль', 'Годовое'),
    ('3', '3', 'Март', 'Годовое'),
    ('4', '4', 'Апрель', 'Годовое'),
    ('5', '5', 'Май', 'Годовое');

   -- КОМЕНТАРИИ
insert into Comments (Commentss, "Data") values
    ('крутой фильм', '2022.01.03'),
    ('не понравился', '2022.01.07'),
    ('лайк', '2021.04.13'),
    ('не страшно', '2022.05.12'),
    ('лайк', '2022.01.07');
   
   -- НОВОСТИ
insert into News (News) values
    ('Джефф Бриджес возвращается в кино после борьбы с раком и коронавирусом'),
    ('Джейсон Момоа может сыграть главную роль в киноадаптации «Майнкрафт');
   

-- ФИЛЬМЫ
insert into Movies (Movie_title, Movie_description, Comments_id, News_id) values
    ('Война Миров', 'фантастический триллер про вторжение инопланетян', (SELECT id FROM Comments WHERE id = '1'), '1'),
    ('Звездный путь', 'про приключения героев из культовой вселенной Звёздного пути', (SELECT id FROM Comments WHERE id = '2'), '2'),
    ('Бивень', 'омедийный фильм ужасов от режиссёра Кевина Смита', (SELECT id FROM Comments WHERE id = '3'), '1'),
    ('Синяя бездна', 'фильм ужасов 2019 года, погружающий зрителя в пучину страха', (SELECT id FROM Comments WHERE id = '4'), '1'),
    ('Виновный', 'драматический триллер о звонке в службу спасения', (SELECT id FROM Comments WHERE id = '5'), '2');
   
   alter table movies  add column  News int references news(id);

  
  --ВЫВОДИМ ТАБЛИЦУ Movies ИСПОЛЬЗУЯ JOIN И ПРИСОЕДИНЯЕМ ЗАВИСИМЫЕ ТАБЛИЦЫ
select Movies.Movie_title, Movies.Movie_description, News.News
from  Movies inner join News on Movies.News_id  = News_id;
















