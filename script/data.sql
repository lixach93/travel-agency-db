SET search_path TO travel_agency;

INSERT INTO partners (name, country, website) VALUES
                                                  ('GlobeTours', 'Spain', 'https://globetours.example'),
                                                  ('LocalGuideCo', 'Poland', 'https://localguide.example');

INSERT INTO guides (full_name, language, partner_id) VALUES
                                                         ('Maria Garcia', 'Spanish', 1),
                                                         ('Jan Kowalski', 'Polish', 2);

INSERT INTO customers (full_name, email, country)
VALUES
    ('Alice Novak', 'alice@example.com', 'Czechia'),
    ('Bob Kowalski', 'bob@example.com', 'Poland');

INSERT INTO tours (title, description, base_price, start_date, end_date, partner_id)
VALUES
    ('Barcelona Highlights', '7-day Barcelona tour', 800.00, '2024-12-01', '2024-12-07', 1),
    ('Poland Explorer', 'Historic tour of Poland', 1200.00, '2025-03-10', '2025-03-17', 2);

INSERT INTO hotels (name, city, rating)
VALUES
    ('Sunny Hotel', 'Barcelona', 4.5),
    ('Central Inn', 'Warsaw', 4.0);

INSERT INTO tour_hotels (tour_id, hotel_id, nights)
VALUES
    (1, 1, 5),
    (2, 2, 6);

INSERT INTO excursions (name, price, duration_hours, description)
VALUES
    ('Sagrada Familia Visit', 50.00, 2.0, 'Guided visit in Barcelona'),
    ('Wawel Castle Tour', 30.00, 1.5, 'Historic Krakow landmark');

INSERT INTO bookings (customer_id, tour_id, travelers_count, total_price)
VALUES
    (1, 1, 2, 1600.00),
    (2, 2, 3, 3600.00);

INSERT INTO booking_excursions (booking_id, excursion_id)
VALUES
    (1, 1),
    (2, 2);
