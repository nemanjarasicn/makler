BEGIN TRANSACTION;

CREATE TEMPORARY TABLE contracts_backup (id, institution_id, name, time_created, time_updated, description, value, valid_until);
INSERT INTO contracts_backup (id, institution_id, name, time_created, time_updated, description, value, valid_until)
SELECT id, institution_id, name, time_created, time_updated, description, value, valid_until FROM contracts;

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
        PRIMARY KEY (id),
        FOREIGN KEY (institution_id) REFERENCES institutions (id)
);

INSERT INTO contracts (id, institution_id, name, announced, created, valid_until, description, value)
SELECT id, institution_id, name, time_created, time_updated, valid_until, description, value FROM contracts_backup;

COMMIT;
