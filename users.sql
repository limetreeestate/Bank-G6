CREATE USER 'customer'@'localhost' IDENTIFIED BY 'customer123';
GRANT SELECT ON * TO 'customer'@'localhost';

CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employee123';
GRANT SELECT ,DELETE , INSERT, UPDATE ON * TO 'employee'@'localhost';

CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager123';
GRANT ALL PRIVILEGES ON * TO 'manager'@'localhost';