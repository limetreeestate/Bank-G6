USE bank_demo;
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Test Data insertion
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

SET AUTOCOMMIT = 1;
INSERT INTO branch (branch_ID, branch_name, city)
VALUES  ('B001', 'branch1', 'city1'),
        ('B002', 'branch2', 'city2'),
        ('B003', 'branch3', 'city3'),
        ('B004', 'branch4', 'city4'),
        ('B005', 'branch5', 'city5'),
        ('B006', 'branch6', 'city6'),
        ('B007', 'branch7', 'city7'),
        ('B008', 'branch8', 'city8'),
        ('B009', 'branch9', 'city9'),
        ('B010', 'branch10', 'city10');

INSERT INTO customer (customer_ID, customer_type)
VALUES ('C00001', 'Individual'),
       ('C00002', 'Organization');

INSERT INTO individual (NIC, customer_ID, first_name, last_name, address, DOB)
VALUES ('123456781V', 'C00001', 'John', 'Doe', 'address1', '1996-11-06'),
       ('123456782V', 'C00002', 'Jim', 'Halpert', 'address2', '1996-12-06'),
       ('123456783V', 'C00003', 'Pam', 'Beesly', 'address3', '1997-11-06'),
       ('123456784V', 'C00004', 'Meredith', 'Palmer', 'address4', '1998-11-26'),
       ('123456785V', 'C00005', 'Kelly', 'Kapoor', 'address5', '1994-09-20'),
       ('123456786V', 'C00006', 'Andy', 'Bernard', 'address6', '1993-11-12'),
       ('123456787V', 'C00007', 'Michael', 'Scott', 'address7', '1996-08-20'),
       ('123456788V', 'C00008', 'Creed', 'Bratton', 'address8', '1996-10-08'),
       ('123456789V', 'C00009', 'Ryan', 'Howard', 'address9', '1996-01-07'),
       ('123456710V', 'C00010', 'Dwight', 'Schrute', 'address10', '1992-02-27');

INSERT INTO employee (employee_ID, branch, NIC, first_name, last_name, address, telephone, salary)
VALUES ('E01001', 'B001', '987654321V', 'Arya', 'Stark', 'address21', '0718591422', 25000),
       ('E01002', 'B001', '987654322V', 'Jon', 'Snow', 'address22', '0718591423', 25000),
       ('E02001', 'B002', '987654323V', 'Danny', 'Targ', 'address23', '0718591424', 26000),
       ('E02002', 'B002', '987654324V', 'Sansa', 'Stark', 'address24', '0718591425', 28000),
       ('E03001', 'B003', '987654325V', 'Ned', 'Stark', 'address25', '0718591426', 23000),
       ('E03002', 'B003', '987654326V', 'Lyanna', 'Stark', 'address26', '0718591427', 25000),
       ('E04001', 'B004', '987654327V', 'Cersei', 'Lannister', 'address27', '0718591428', 25000),
       ('E04002', 'B004', '987654328V', 'Jaime', 'Lannister', 'address28', '0718591429', 24000),
       ('E05001', 'B005', '987654329V', 'Tyrion', 'Lannister', 'address29', '0718591410', 24000),
       ('E05002', 'B005', '987654310V', 'Oberyn', 'Martell', 'address30', '0718591411', 25000),
       ('E06001', 'B006', '987654311V', 'Margerie', 'Tyrell', 'address31', '0718591412', 26000),
       ('E06002', 'B006', '987654312V', 'Olenna', 'Tyrell', 'address32', '0718591413', 26000),
       ('E07011', 'B007', '987654313V', 'Laurus', 'Tyrell', 'address33', '0718591414', 28000),
       ('E07012', 'B007', '987654314V', 'Stannis', 'Baratheon', 'address34', '0718591415', 28000),
       ('E08001', 'B008', '987654315V', 'Robert', 'Baratheon', 'address35', '0718591416', 29000),
       ('E08002', 'B008', '987654316V', 'Robb', 'Stark', 'address36', '0718591417', 25000),
       ('E09001', 'B009', '987654317V', 'Rickon', 'Stark', 'address37', '0718591418', 25000),
       ('E09002', 'B009', '987654318V', 'Catelyn', 'Stark', 'address38', '0718591419', 30000),
       ('E10001', 'B010', '987654319V', 'Ramsay', 'Bolton', 'address39', '0718591420', 27000),
       ('E10002', 'B010', '987654320V', 'Roose', 'Bolton', 'address40', '0718591421', 23000);

INSERT INTO manager (employee_ID)
VALUES ('E01001'),
       ('E02001'),
       ('E03001'),
       ('E04001'),
       ('E05001'),
       ('E06001'),
       ('E07001'),
       ('E08001'),
       ('E09001'),
       ('E10001');

UPDATE Branch SET employee_ID = 'E01001' WHERE branch_ID = 'B001';
UPDATE Branch SET employee_ID = 'E02001' WHERE branch_ID = 'B002';
UPDATE Branch SET employee_ID = 'E03001' WHERE branch_ID = 'B003';
UPDATE Branch SET employee_ID = 'E04001' WHERE branch_ID = 'B004';
UPDATE Branch SET employee_ID = 'E05001' WHERE branch_ID = 'B005';
UPDATE Branch SET employee_ID = 'E06001' WHERE branch_ID = 'B006';
UPDATE Branch SET employee_ID = 'E07001' WHERE branch_ID = 'B007';
UPDATE Branch SET employee_ID = 'E08001' WHERE branch_ID = 'B008';
UPDATE Branch SET employee_ID = 'E09001' WHERE branch_ID = 'B009';
UPDATE Branch SET employee_ID = 'E10001' WHERE branch_ID = 'B010';

INSERT INTO account (account_no, customer_ID, branch_ID, balance)
VALUES ('0000000001', 'C00001', 'B001', '100000'),
       ('0000000002', 'C00002', 'B002', '750000'),
       ('0000000003', 'C00003', 'B003', '50000'),
       ('0000000004', 'C00003', 'B004', '125000'),
       ('0000000005', 'C00004', 'B005', '150000'),
       ('0000000006', 'C00005', 'B005', '80000'),
       ('0000000007', 'C00005', 'B006', '90000'),
       ('0000000008', 'C00006', 'B007', '25000'),
       ('0000000009', 'C00006', 'B008', '1000'),
       ('0000000010', 'C00007', 'B009', '10000');

INSERT INTO savings_account_type (account_type, type, interest_rate, minimum)
VALUES ('01', 'Child', '12', '0.00');

INSERT INTO savings_account (account_no, account_type)
VALUES ('1', '01');

INSERT INTO account (account_no, customer_ID, branch_ID, balance)
VALUES ('0000000002', 'C00001', 'B001', '25000');

INSERT INTO current_account (account_no, OD_amount) VALUES ('2', '10000.00');

INSERT INTO fd_type (FD_type, type, interest_rate)
VALUES ('01', '6 month', '13.00'),
  ('02', '12 month', '14.00'),
  ('03', '3 month', '15.00');

INSERT INTO fixed_deposit (FD_ID, savings_acc, FD_type)
VALUES ('1', '1', '01');

