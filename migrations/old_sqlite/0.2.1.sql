BEGIN TRANSACTION;

-- Create categories table
CREATE TABLE instrument_type_categories (
       id INTEGER NOT NULL,
       name VARCHAR(50),

       PRIMARY KEY (id),
       CONSTRAINT instrument_type_category_true_pk UNIQUE (name)
);

-- Populate instrument categories
INSERT INTO instrument_type_categories (id, name) VALUES (1, 'Gasni');
INSERT INTO instrument_type_categories (id, name) VALUES (2, 'Urinski');
INSERT INTO instrument_type_categories (id, name) VALUES (3, 'Biohemijski');
INSERT INTO instrument_type_categories (id, name) VALUES (4, 'Imunohemijski');
INSERT INTO instrument_type_categories (id, name) VALUES (5, 'Hematološki');
INSERT INTO instrument_type_categories (id, name) VALUES (6, 'Hemostatički');
INSERT INTO instrument_type_categories (id, name) VALUES (7, 'Koagulacija');

-- Alter instrument types table
CREATE TEMPORARY TABLE instrument_types_backup (name, category_id, type, manufacturer);
INSERT INTO instrument_types_backup (name, type, manufacturer) SELECT name,type,manufacturer FROM instrument_types;

-- Migrate data
UPDATE instrument_types_backup SET category_id = 1 WHERE type = 'gasni';
UPDATE instrument_types_backup SET category_id = 2 WHERE type = 'urinski';
UPDATE instrument_types_backup SET category_id = 3 WHERE type = 'biohemijski';
UPDATE instrument_types_backup SET category_id = 4 WHERE type = 'imunohemijski';
UPDATE instrument_types_backup SET category_id = 5 WHERE type = 'hematoloski' OR type = 'hematoloki' OR type = 'hematološki';
UPDATE instrument_types_backup SET category_id = 7 WHERE type = 'koagulacija';

-- Drop table and create new schema
DROP TABLE instrument_types;
CREATE TABLE instrument_types (
       id INTEGER NOT NULL,
       category_id INTEGER,
       manufacturer VARCHAR(50),
       name VARCHAR(50),

       PRIMARY KEY (id),
       CONSTRAINT instrument_type_true_pk UNIQUE (name, manufacturer),
       FOREIGN KEY (category_id) REFERENCES instrument_type_categories (id)
);

-- Populate with data
INSERT INTO instrument_types (name, category_id, manufacturer) SELECT name,category_id,manufacturer FROM instrument_types_backup;
-- Drop temp table
DROP TABLE instrument_types_backup;

COMMIT;
