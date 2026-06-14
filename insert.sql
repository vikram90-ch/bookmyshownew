INSERT INTO cities(name)
VALUES ('Bangalore');

INSERT INTO theatres(city_id,name,address)
VALUES (1,'PVR Phoenix Mall','Whitefield');

INSERT INTO screens(theatre_id,screen_name,total_seats)
VALUES (1,'Screen-1',100);

INSERT INTO seats(screen_id,seat_number,seat_type,base_price)
VALUES
(1,'A1','GOLD',250),
(1,'A2','GOLD',250),
(1,'A3','GOLD',250),
(1,'B1','SILVER',200);

INSERT INTO movies(
title,
genre,
language,
duration_minutes
)
VALUES
(
'Interstellar',
'Sci-Fi',
'English',
169
);

INSERT INTO shows(
movie_id,
screen_id,
show_date,
start_time,
end_time
)
VALUES
(
1,
1,
CURRENT_DATE,
'2026-06-15 10:00:00',
'2026-06-15 12:49:00'
);


SELECT DISTINCT m.*
FROM movies m
JOIN shows s ON s.movie_id = m.id
JOIN screens sc ON sc.id = s.screen_id
JOIN theatres t ON t.id = sc.theatre_id
JOIN cities c ON c.id = t.city_id
WHERE c.name = 'Bangalore';


