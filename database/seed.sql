USE it_management;

-- =========================================
-- DEPARTMENTS
-- =========================================

INSERT INTO departments (name) VALUES
('Informatique'),
('Ressources humaines'),
('Finance'),
('Marketing');


-- =========================================
-- USERS
-- =========================================

INSERT INTO users
(first_name, last_name, email, password, role, department_id)
VALUES
('Alice', 'Martin', 'alice.martin@example.com', 'TEMP_PASSWORD', 'employee', 2),
('Lucas', 'Dupont', 'lucas.dupont@example.com', 'TEMP_PASSWORD', 'employee', 3),
('Emma', 'Bernard', 'emma.bernard@example.com', 'TEMP_PASSWORD', 'employee', 4),
('Thomas', 'Robert', 'thomas.robert@example.com', 'TEMP_PASSWORD', 'technician', 1),
('Sarah', 'Petit', 'sarah.petit@example.com', 'TEMP_PASSWORD', 'technician', 1),
('Admin', 'System', 'admin@example.com', 'TEMP_PASSWORD', 'admin', 1);


-- =========================================
-- EQUIPMENT TYPES
-- =========================================

INSERT INTO equipment_types (name) VALUES
('Laptop'),
('Desktop'),
('Monitor'),
('Printer'),
('Server'),
('Network');


-- =========================================
-- EQUIPMENT
-- =========================================

INSERT INTO equipment
(name, brand, model, serial_number, status, purchase_date, location, user_id, equipment_type_id)
VALUES
('Laptop-001', 'Dell', 'Latitude 5440', 'DL5440-001', 'active', '2026-01-15', 'Paris - Bureau 201', 1, 1),

('Laptop-002', 'Lenovo', 'ThinkPad T14', 'LT14-002', 'active', '2026-01-20', 'Paris - Bureau 202', 2, 1),

('Laptop-003', 'HP', 'EliteBook 840', 'HP840-003', 'maintenance', '2025-11-10', 'Paris - IT', NULL, 1),

('Desktop-001', 'Dell', 'OptiPlex 7010', 'OPT7010-001', 'active', '2025-09-05', 'Paris - Bureau 103', 3, 2),

('Monitor-001', 'Samsung', 'S24C450', 'SAM24-001', 'active', '2025-08-12', 'Paris - Bureau 201', 1, 3),

('Monitor-002', 'LG', '24MP400', 'LG24-002', 'active', '2025-08-15', 'Paris - Bureau 202', 2, 3),

('Printer-001', 'HP', 'LaserJet Pro', 'HP-LJ-001', 'active', '2025-06-20', 'Paris - Open Space', NULL, 4),

('Server-001', 'Dell', 'PowerEdge R550', 'PE550-001', 'active', '2025-04-10', 'Paris - Server Room', NULL, 5);


-- =========================================
-- SOFTWARE
-- =========================================

INSERT INTO software
(name, version, license_key)
VALUES
('Windows 11 Pro', '24H2', 'DEMO-WIN-001'),
('Microsoft 365', '2026', 'DEMO-M365-001'),
('Visual Studio Code', '1.105', NULL),
('Google Chrome', '141', NULL),
('Docker Desktop', '4.x', NULL),
('Microsoft Teams', '2026', NULL);


-- =========================================
-- EQUIPMENT <-> SOFTWARE
-- =========================================

INSERT INTO equipment_software (equipment_id, software_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),

(2, 1),
(2, 2),
(2, 4),

(3, 1),
(3, 5),

(4, 1),
(4, 2),
(4, 6);


-- =========================================
-- TICKETS
-- =========================================

INSERT INTO tickets
(title, description, priority, status, created_by, assigned_to, equipment_id)
VALUES

(
    'Mon ordinateur ne démarre plus',
    'Le bouton power fonctionne mais Windows ne démarre pas.',
    'high',
    'open',
    1,
    4,
    1
),

(
    'Connexion Internet instable',
    'La connexion Internet se coupe régulièrement.',
    'medium',
    'in_progress',
    2,
    5,
    2
),

(
    'Installation de Visual Studio Code',
    'Besoin de Visual Studio Code pour un projet informatique.',
    'low',
    'resolved',
    3,
    4,
    4
),

(
    'Écran noir',
    'Le deuxième écran ne détecte plus le signal.',
    'high',
    'open',
    1,
    5,
    5
),

(
    'Demande de nouveau logiciel',
    'Demande d installation de Docker Desktop.',
    'low',
    'closed',
    2,
    4,
    2
);


-- =========================================
-- INTERVENTIONS
-- =========================================

INSERT INTO interventions
(ticket_id, technician_id, description, time_spent)
VALUES

(
    2,
    5,
    'Vérification de la connexion réseau et du câble Ethernet.',
    30
),

(
    3,
    4,
    'Installation et configuration de Visual Studio Code.',
    20
),

(
    5,
    4,
    'Installation de Docker Desktop et vérification du démarrage.',
    35
);
