CREATE DATABASE Minitest_week_2;
USE Minitest_week_2;

CREATE TABLE materials
(
    matlID        INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL UNIQUE,
    unit          VARCHAR(3) check ( unit = UPPER(unit) ),
    price         DOUBLE
);

CREATE TABLE inventory
(
    invID         INT AUTO_INCREMENT PRIMARY KEY,
    matlID        INT,
    FOREIGN KEY (matlID) REFERENCES materials (matlID),
    opening_stock INT NOT NULL DEFAULT 0,
    total_in      INT DEFAULT 0,
    total_out     INT DEFAULT 0
);

CREATE TABLE suppliers
(
    supID      INT AUTO_INCREMENT PRIMARY KEY,
    supCode    VARCHAR(50) UNIQUE,
    supName    VARCHAR(255),
    supAddress TEXT,
    supContact VARCHAR(20)
);

CREATE TABLE purchase_orders
(
    poID   INT AUTO_INCREMENT PRIMARY KEY,
    poCode VARCHAR(50) UNIQUE,
    oDate  DATE NOT NULL DEFAULT '2023-05-13',
    supID  INT,
    FOREIGN KEY (supID) REFERENCES suppliers (supId)
);

CREATE TABLE received_notes
(
    recID   INT AUTO_INCREMENT PRIMARY KEY,
    recCode VARCHAR(50) UNIQUE,
    recDate DATE NOT NULL DEFAULT '2023-05-13',
    poID    INT,
    FOREIGN KEY (poID) REFERENCES purchase_orders (poID)
);

CREATE TABLE delivery_notes
(
    delID   INT AUTO_INCREMENT PRIMARY KEY,
    delCode VARCHAR(50) UNIQUE,
    delDate DATE NOT NULL DEFAULT '2023-05-13',
    cusName VARCHAR(255)
);

CREATE TABLE order_detail
(
    odID     INT AUTO_INCREMENT PRIMARY KEY,
    poID     INT,
    matlID   INT,
    quantity INT NOT NULL,
    FOREIGN KEY (poID) REFERENCES purchase_orders (poID),
    FOREIGN KEY (matlID) REFERENCES materials (matlID)
);

CREATE TABLE rec_detail
(
    rdID        INT AUTO_INCREMENT PRIMARY KEY,
    recID       INT,
    matlID      INT,
    quantity_in INT    NOT NULL,
    price_in    DOUBLE NOT NULL,
    note        TEXT,
    FOREIGN KEY (recID) REFERENCES received_notes (recID),
    FOREIGN KEY (matlID) REFERENCES materials (matlID)
);

CREATE TABLE del_detail
(
    ddID         INT AUTO_INCREMENT PRIMARY KEY,
    delID        INT,
    matlID       INT,
    quantity_out INT    NOT NULL,
    price_out    DOUBLE NOT NULL,
    note         TEXT,
    FOREIGN KEY (delID) REFERENCES delivery_notes (delID),
    FOREIGN KEY (matlID) REFERENCES materials (matlID)
);



