# travel-agency-db
Task for Relational DB

## Objectives
The database allows a travel agency to:
- Manage information about **customers**, **partners**, **guides**, **tours**, **hotels**, and **excursions**.
- Record **bookings** made by customers for specific tours.
- Associate hotels and excursions with tours and bookings.
- Maintain referential integrity, constraints, and normalization up to **Third Normal Form (3NF)**.

## Database Structure
The schema contains **8 main tables**:

| Table | Description |
|--------|--------------|
| `customers` | Stores basic customer information. |
| `partners` | Represents travel partners in different countries. |
| `guides` | Guides working for partners, with associated languages. |
| `tours` | Organized trips including dates, prices, and partner association. |
| `hotels` | Hotel details with city and rating. |
| `tour_hotels` | Many-to-many link between tours and hotels. |
| `excursions` | Optional excursions customers can attend. |
| `bookings` | Customer bookings for specific tours. |
| `booking_excursions` | Many-to-many relation linking bookings and excursions. |

### Relationships
- **1:N** between `partners` and `tours`
- **1:N** between `partners` and `guides`
- **1:N** between `customers` and `bookings`
- **M:N** between `tours` and `hotels` (via `tour_hotels`)
- **M:N** between `bookings` and `excursions` (via `booking_excursions`)

### Normalization
The schema follows **3NF**:
- Each table has a **primary key**.
- Redundant and transitive dependencies are eliminated.
- Foreign key relationships ensure referential integrity.

### Constraints Used
- **Primary keys**: all tables.
- **Foreign keys**: enforce relational links with `ON DELETE` actions.
- **UNIQUE**: ensures distinct email and partner/hotel names.
- **NOT NULL**: required fields.
- **CHECK**: validates logical business rules (e.g., `rating BETWEEN 0 AND 5`, `end_date >= start_date`).
- **DEFAULT**: automatic values for timestamps and statuses.