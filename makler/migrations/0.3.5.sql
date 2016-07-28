BEGIN TRANSACTION;

-- Create table suppliers
CREATE TABLE suppliers (
        id INTEGER NOT NULL,
        name VARCHAR(50),
        PRIMARY KEY (id)
);

INSERT INTO suppliers (id, name) values (1, 'Makler');

CREATE TEMPORARY TABLE contracts_backup (id, institution_id, name, announced, created, valid_until, description, value);
INSERT INTO contracts_backup (id, institution_id, name, announced, created, valid_until, description, value)
SELECT id, institution_id, name, announced, created, valid_until, description, value FROM contracts;

DROP TABLE contracts;

CREATE TABLE contracts (
        id INTEGER NOT NULL,
        institution_id INTEGER NOT NULL,
        name VARCHAR(50),
        announced DATETIME,
        created DATETIME,
        valid_until DATETIME,
        description VARCHAR(50),
        value INTEGER,
        supplier_id INTEGER,
        PRIMARY KEY (id),
        FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
);

INSERT INTO contracts (id, institution_id, name, announced, created, valid_until, description, value)
SELECT id, institution_id, name, announced, created, valid_until, description, value FROM contracts_backup;

COMMIT;
