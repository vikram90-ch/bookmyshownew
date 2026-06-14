CREATE TABLE cities (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

select * from cities;

CREATE TABLE theatres (
    id BIGSERIAL PRIMARY KEY,
    city_id BIGINT NOT NULL,
    name VARCHAR(200) NOT NULL,
    address TEXT,

    CONSTRAINT fk_theatre_city
        FOREIGN KEY (city_id)
        REFERENCES cities(id)
);

select * from theatres;

CREATE TABLE screens (
    id BIGSERIAL PRIMARY KEY,
    theatre_id BIGINT NOT NULL,
    screen_name VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL,

    CONSTRAINT fk_screen_theatre
        FOREIGN KEY (theatre_id)
        REFERENCES theatres(id)
);

select * from screens; 

CREATE TABLE seats (
    id BIGSERIAL PRIMARY KEY,
    screen_id BIGINT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_type VARCHAR(20) NOT NULL,
    base_price NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_seat_screen
        FOREIGN KEY (screen_id)
        REFERENCES screens(id),

    CONSTRAINT uk_screen_seat
        UNIQUE(screen_id, seat_number)
);

CREATE TABLE movies (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    genre VARCHAR(100),
    language VARCHAR(50),
    duration_minutes INT,
    release_date DATE,
    description TEXT
);


CREATE TABLE shows (
    id BIGSERIAL PRIMARY KEY,
    movie_id BIGINT NOT NULL,
    screen_id BIGINT NOT NULL,
    show_date DATE NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,

    CONSTRAINT fk_show_movie
        FOREIGN KEY(movie_id)
        REFERENCES movies(id),

    CONSTRAINT fk_show_screen
        FOREIGN KEY(screen_id)
        REFERENCES screens(id)
);


CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE show_seats (
    id BIGSERIAL PRIMARY KEY,
    show_id BIGINT NOT NULL,
    seat_id BIGINT NOT NULL,
    price NUMERIC(10,2),
    status VARCHAR(20) DEFAULT 'AVAILABLE',

    CONSTRAINT fk_showseat_show
        FOREIGN KEY(show_id)
        REFERENCES shows(id),

    CONSTRAINT fk_showseat_seat
        FOREIGN KEY(seat_id)
        REFERENCES seats(id),

    CONSTRAINT uk_show_seat
        UNIQUE(show_id, seat_id)
);


CREATE TABLE bookings (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    show_id BIGINT NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10,2),
    status VARCHAR(20),

    CONSTRAINT fk_booking_user
        FOREIGN KEY(user_id)
        REFERENCES users(id),

    CONSTRAINT fk_booking_show
        FOREIGN KEY(show_id)
        REFERENCES shows(id)
);

	CREATE TABLE booking_seats (
	    booking_id BIGINT NOT NULL,
	    show_seat_id BIGINT NOT NULL,
	
	    PRIMARY KEY(booking_id, show_seat_id),
	
	    CONSTRAINT fk_bs_booking
	        FOREIGN KEY(booking_id)
	        REFERENCES bookings(id),
	
	    CONSTRAINT fk_bs_showseat
	        FOREIGN KEY(show_seat_id)
	        REFERENCES show_seats(id)
	);

CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    booking_id BIGINT UNIQUE NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(50),
    transaction_id VARCHAR(100),
    status VARCHAR(20),
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_booking
        FOREIGN KEY(booking_id)
        REFERENCES bookings(id)
);







