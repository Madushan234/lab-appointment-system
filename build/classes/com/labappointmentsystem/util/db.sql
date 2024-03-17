DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS password_reset_tokens;
DROP TABLE IF EXISTS medical_tests;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS medical_test_records;

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    display_name VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

INSERT INTO `roles` (`id`, `display_name`, `name`) VALUES
(1, 'Patient', 'patient'),
(2, 'Technician', 'technician'),
(3, 'Admin', 'admin');

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    tel_number VARCHAR(255),
    nic VARCHAR(255) NOT NULL,
    dob VARCHAR(255) NOT NULL,
    remember_token VARCHAR(255),
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE password_reset_tokens (
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE medical_tests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description LONGTEXT NOT NULL,
    normal_record_data LONGTEXT NOT NULL,
    amount DOUBLE(15,2) NOT NULL,
    processing_time DOUBLE(15,2) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    appointment_status VARCHAR(255) NOT NULL,
    amount DOUBLE(15,2),
    recommended_doctor VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

ALTER TABLE appointments
ADD COLUMN select_date DATE AFTER recommended_doctor,
ADD COLUMN select_time TIME AFTER select_date;


CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    description LONGTEXT NOT NULL,
    other VARCHAR(255),
    amount DOUBLE(15,2) NOT NULL,
    invoice MEDIUMBLOB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

CREATE TABLE status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE medical_test_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    medical_test_id INT,
    technician_id INT,
    status_id INT,
    report MEDIUMBLOB NULL,
    result LONGTEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id),
    FOREIGN KEY (medical_test_id) REFERENCES medical_tests(id),
    FOREIGN KEY (technician_id) REFERENCES users(id),
    FOREIGN KEY (status_id) REFERENCES status(id)
);