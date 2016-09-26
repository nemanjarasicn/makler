BEGIN TRANSACTION;

-- Create table lis
CREATE TABLE lis (
       id INTEGER NOT NULL,
       name VARCHAR(50),

       PRIMARY KEY (id)
);

INSERT INTO lis (id, name) values (1, 'LIS');
INSERT INTO lis (id, name) values (2, 'Bit Impeks');
INSERT INTO lis (id, name) values (3, 'sLis');

CREATE TEMPORARY TABLE institutions_backup (id, name, city, address, phone, type, pib, account);
INSERT INTO institutions_backup (id, name, city, address, phone, type, pib, account)
SELECT id, name, city, address, phone, type, pib, account FROM institutions;

DROP TABLE institutions;

CREATE TABLE institutions (
        id INTEGER NOT NULL,
        name VARCHAR(50),
        city VARCHAR(50),
        address VARCHAR(50),
        phone VARCHAR(15),
        type VARCHAR(50),
        pib INTEGER,
        account VARCHAR(50),
        lis_id INTEGER,
        PRIMARY KEY (id),
        CONSTRAINT institution_true_pk UNIQUE (name, city),
        FOREIGN KEY (lis_id) REFERENCES lis (id)
);

INSERT INTO institutions (id, name, city, address, phone, type, pib, account)
SELECT id, name, city, address, phone, type, pib, account FROM institutions_backup;

COMMIT;
