-- Tạo bảng host
USE sql2;
CREATE TABLE `host` (
    id INT PRIMARY KEY NOT NULL,
    `name` VARCHAR(45),
    address VARCHAR(45)
);

-- Tạo bảng contractor
CREATE TABLE contractor (
    id INT PRIMARY KEY,
    `name` VARCHAR(255),
    address VARCHAR(255),
    contractor VARCHAR(45)
);

-- Tạo bảng building và thiết lập khóa ngoại
CREATE TABLE building (
    id INT PRIMARY KEY,
    `name` VARCHAR(45),
    address VARCHAR(45),
    city VARCHAR(45),
    cost FLOAT,
    `start` DATE,
    host_id INT,
    contractor_id INT,
    FOREIGN KEY (host_id) REFERENCES host(id),
    FOREIGN KEY (contractor_id) REFERENCES contractor(id)
);

-- Tạo bảng architect
CREATE TABLE architect (
    id INT PRIMARY KEY,
    `name` VARCHAR(255),
    sex TINYINT(1),
    birthday DATE,
    place VARCHAR(255),
    address VARCHAR(255)
);

-- Tạo bảng design và thiết lập khóa ngoại
CREATE TABLE design (
    building_id INT,
    architect_id INT,
    benefit VARCHAR(45),
    PRIMARY KEY (building_id, architect_id),
    FOREIGN KEY (building_id) REFERENCES building(id),
    FOREIGN KEY (architect_id) REFERENCES architect(id)
);

-- Tạo bảng worker
CREATE TABLE worker (
    id INT PRIMARY KEY,
    `name` VARCHAR(45),
    birthday DATE,
    `year` VARCHAR(45),
    skill VARCHAR(45)
);

-- Tạo bảng work và thiết lập khóa ngoại
CREATE TABLE work (
    building_id INT,
    worker_id INT,
    `date` DATE,
    total VARCHAR(45),
    PRIMARY KEY (building_id, worker_id, date),
    FOREIGN KEY (building_id) REFERENCES building(id),
    FOREIGN KEY (worker_id) REFERENCES worker(id)
);
