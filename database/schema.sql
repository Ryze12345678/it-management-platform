CREATE DATABASE IF NOT EXISTS it_management;

USE it_management;

-- =========================================
-- DEPARTMENTS
-- =========================================

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- USERS
-- =========================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('employee', 'technician', 'admin') NOT NULL DEFAULT 'employee',
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE SET NULL
);

-- =========================================
-- EQUIPMENT TYPES
-- =========================================

CREATE TABLE equipment_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- EQUIPMENT
-- =========================================

CREATE TABLE equipment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    brand VARCHAR(100),
    model VARCHAR(100),
    serial_number VARCHAR(150) UNIQUE,
    status ENUM('active', 'inactive', 'maintenance', 'retired')
        NOT NULL DEFAULT 'active',
    purchase_date DATE,
    location VARCHAR(150),

    user_id INT,
    equipment_type_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_equipment_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_equipment_type
        FOREIGN KEY (equipment_type_id)
        REFERENCES equipment_types(id)
        ON DELETE RESTRICT
);

-- =========================================
-- SOFTWARE
-- =========================================

CREATE TABLE software (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    version VARCHAR(100),
    license_key VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- EQUIPMENT <-> SOFTWARE
-- =========================================

CREATE TABLE equipment_software (
    equipment_id INT NOT NULL,
    software_id INT NOT NULL,
    installed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (equipment_id, software_id),

    CONSTRAINT fk_equipment_software_equipment
        FOREIGN KEY (equipment_id)
        REFERENCES equipment(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_equipment_software_software
        FOREIGN KEY (software_id)
        REFERENCES software(id)
        ON DELETE CASCADE
);

-- =========================================
-- TICKETS
-- =========================================

CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,

    priority ENUM('low', 'medium', 'high', 'critical')
        NOT NULL DEFAULT 'medium',

    status ENUM('open', 'in_progress', 'resolved', 'closed')
        NOT NULL DEFAULT 'open',

    created_by INT NOT NULL,
    assigned_to INT,
    equipment_id INT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_ticket_creator
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_ticket_assignee
        FOREIGN KEY (assigned_to)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_ticket_equipment
        FOREIGN KEY (equipment_id)
        REFERENCES equipment(id)
        ON DELETE SET NULL
);

-- =========================================
-- INTERVENTIONS
-- =========================================

CREATE TABLE interventions (
    id INT AUTO_INCREMENT PRIMARY KEY,

    ticket_id INT NOT NULL,
    technician_id INT NOT NULL,

    description TEXT NOT NULL,
    time_spent INT DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_intervention_ticket
        FOREIGN KEY (ticket_id)
        REFERENCES tickets(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_intervention_technician
        FOREIGN KEY (technician_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
);


