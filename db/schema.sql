CREATE DATABASE tripdb;

CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    email TEXT,
    password_digest TEXT
);

CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    name TEXT,
    description  TEXT,
    image_url  TEXT,
    city TEXT,
    rating INTEGER
    
);

CREATE TABLE user_location_ratings(
    user_id INTEGER,
    location_id INTEGER,
    rating INTEGER
)

sql = "select location_id, avg(rating) from user_location_ratings group by location_id"

INSERT INTO user_location_ratings(user_id,location_id,rating)
VALUES (1,1,4), (2,1,2)

INSERT INTO 
locations(name,description,image_url,city,rating) 
VALUES ('SeaLife Acquarium', 'Got a beautiful collection of sea creatures, educational events and lots of kids entertainment','https://www.wallpaperup.com/uploads/wallpapers/2016/03/29/918706/d56d9e2ab527998bc6b73ffd926e961e.jpg','Melbourne',10);

INSERT INTO 
locations(name,description,image_url,city,rating) 
VALUES ('Werribee Zoo', 'A beautiful open range zoo with a wide variety of african and australian wildlife. Safari ride is a must have experience in here','https://www.myjubilee.com.au/wp-content/uploads/2020/06/r0_211_4132_2534_w1200_h678_fmax.jpg','Melbourne',8);



INSERT INTO 
locations(name,description,image_url,city,rating) 
VALUES ('Taronga Zoo', 'Great experience with a wide variety of wild life, special experiences, baby animal feeding, special info sessions and many more kids events planned daily.','https://sharenews.grantdigital.com.au/images/Best_of_the_Web/lion-cubs-taronga-zoo.jpg','Sydney',10);

INSERT INTO 
locations(name,description,image_url,city,rating) 
VALUES ('Wirrawill Rainforest walk', 'Beautiful tracks and trails through the rainforest. Accessible to all and family and kids friendly as well.','https://upload.wikimedia.org/wikipedia/commons/b/ba/Wirrawilla_Rainforest_Walk.jpg','Sydney',10);



