BEGIN TRANSACTION;

-- Create table contracts
CREATE TABLE contracts (
        id INTEGER NOT NULL,
        institution_id INTEGER NOT NULL,
        name VARCHAR(50),
        time_created DATETIME,
        time_updated DATETIME,
        description VARCHAR(50),
        value VARCHAR(50),
        PRIMARY KEY (id),
        FOREIGN KEY(institution_id) REFERENCES institutions (id)
);

-- Create table documents
CREATE TABLE documents (
        id INTEGER NOT NULL,
        contract_id INTEGER NOT NULL,
        original_name VARCHAR(50),
        code_name VARCHAR(50),
        upload_date DATETIME,
        PRIMARY KEY (id),
        FOREIGN KEY(contract_id) REFERENCES contracts (id)
);

COMMIT;

