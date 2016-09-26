CREATE TABLE institutions(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    city VARCHAR(50),
    name VARCHAR(50),
    address VARCHAR(50),
    contact_person VARCHAR(50),
    telephone VARCHAR(50)
);

CREATE TABLE instrument_types(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer VARCHAR(50),
    name VARCHAR(50)
);

CREATE TABLE instruments(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    instrument_type_id INTEGER,
    institution_id INTEGER,
    name VARCHAR(100),
    description TEXT,
    FOREIGN KEY(instrument_type_id) REFERENCES instrument_types(id)
    FOREIGN KEY(institution_id) REFERENCES institutions(id)
);
