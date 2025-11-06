
-- Drop for rerun
drop schema if exists travel_agency cascade ;
create schema travel_agency;

SET search_path TO travel_agency;
-- Drop for rerun
drop table if exists booking_excursions cascade;
drop table if exists bookings cascade;
drop table if exists guides cascade;
drop table if exists excursions cascade;
drop table if exists hotels cascade;
drop table if exists tours cascade;
drop table if exists customers cascade;


-- Create tables

CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           full_name VARCHAR(100) NOT NULL,
                           email VARCHAR(100) UNIQUE NOT NULL,
                           phone VARCHAR(20),
                           country VARCHAR(50)
);

-- Partners: travel partners in different countries
CREATE TABLE partners (
                          partner_id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          country VARCHAR(50),
                          website VARCHAR(100)
);

-- Guides: belong to partners;
CREATE TABLE guides (
                        guide_id   SERIAL PRIMARY KEY,
                        full_name  VARCHAR(100) NOT NULL,
                        language   VARCHAR(50),
                        partner_id INT,
                        CONSTRAINT fk_guides_partner FOREIGN KEY (partner_id)
                            REFERENCES partners (partner_id)
                            ON DELETE SET NULL
);

-- Tours: organized trips
CREATE TABLE tours (
                       tour_id      SERIAL PRIMARY KEY,
                       title        VARCHAR(100) NOT NULL,
                       description  TEXT,
                       base_price   NUMERIC(10,2) NOT NULL CHECK (base_price >= 0),
                       start_date   DATE NOT NULL,
                       end_date     DATE NOT NULL,
                       partner_id   INT,
                       CONSTRAINT fk_tours_partner FOREIGN KEY (partner_id)
                           REFERENCES partners (partner_id)
                           ON DELETE SET NULL,
                       CONSTRAINT chk_tour_dates CHECK (end_date >= start_date)
);

-- Hotels
CREATE TABLE hotels (
                        hotel_id SERIAL PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        city VARCHAR(50),
                        rating NUMERIC(2,1) CHECK (rating BETWEEN 0 AND 5)
);

-- M:N relation — which hotels are part of each tour
CREATE TABLE tour_hotels (
                             tour_id  INT NOT NULL,
                             hotel_id INT NOT NULL,
                             nights   INT CHECK (nights > 0),
                             CONSTRAINT pk_tour_hotels PRIMARY KEY (tour_id, hotel_id),
                             CONSTRAINT fk_tour_hotels_tour FOREIGN KEY (tour_id)
                                 REFERENCES tours (tour_id)
                                 ON DELETE CASCADE,
                             CONSTRAINT fk_tour_hotels_hotel FOREIGN KEY (hotel_id)
                                 REFERENCES hotels (hotel_id)
                                 ON DELETE CASCADE
);

-- Excursions
CREATE TABLE excursions (
                            excursion_id   SERIAL PRIMARY KEY,
                            name           VARCHAR(100) NOT NULL,
                            price          NUMERIC(10,2) NOT NULL DEFAULT 0.00 CHECK (price >= 0),
                            duration_hours NUMERIC(4,2) CHECK (duration_hours > 0),
                            description    TEXT
);

-- Bookings: customers booking tours
CREATE TABLE bookings (
                          booking_id      SERIAL PRIMARY KEY,
                          customer_id     INT NOT NULL,
                          tour_id         INT NOT NULL,
                          booking_date    TIMESTAMP DEFAULT now(),
                          travelers_count INT NOT NULL CHECK (travelers_count > 0),
                          total_price     NUMERIC(10,2) NOT NULL CHECK (total_price >= 0),
                          status          VARCHAR(20) DEFAULT 'booked'
                              CHECK (status IN ('booked', 'cancelled', 'completed')),
                          CONSTRAINT fk_bookings_customer FOREIGN KEY (customer_id)
                              REFERENCES customers (customer_id)
                              ON DELETE CASCADE,
                          CONSTRAINT fk_bookings_tour FOREIGN KEY (tour_id)
                              REFERENCES tours (tour_id)
                              ON DELETE RESTRICT
);

-- M:N — excursions included in a booking
CREATE TABLE booking_excursions (
                                    booking_id   INT NOT NULL,
                                    excursion_id INT NOT NULL,
                                    CONSTRAINT pk_booking_excursions PRIMARY KEY (booking_id, excursion_id),
                                    CONSTRAINT fk_booking_excursions_booking FOREIGN KEY (booking_id)
                                        REFERENCES bookings (booking_id)
                                        ON DELETE CASCADE,
                                    CONSTRAINT fk_booking_excursions_excursion FOREIGN KEY (excursion_id)
                                        REFERENCES excursions (excursion_id)
                                        ON DELETE RESTRICT
);


--index
CREATE INDEX idx_bookings_customer_id ON bookings (customer_id);
CREATE INDEX idx_tour_hotels_hotel_id ON tour_hotels (hotel_id);
CREATE INDEX idx_guides_partner_id ON guides (partner_id);
CREATE INDEX idx_tours_partner_id ON tours (partner_id);