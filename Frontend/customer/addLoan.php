<?php
include_once "../../include/database-customer-connect.php";
$acc_no = $_POST['acc_no'];
$FD_id = $_POST['FD_id'];
$loan_amount = intval($_POST['loan_amount']);
$settlement_period = $_POST['settlement_period'];
$income = $_POST['income'];
$req_id = "R001";
$profession = $_POST['profession'];
$address = $_POST['address'];
$l_ID = "L001";
$I_rate = 12.3;
$install = 1000;
print_r($_POST);

$stmt = $pdo->prepare("CALL online_loan_transaction(?,?,?,?,?,?,?,?,?,?,?)");
$stmt->bindParam(1, $req_id, PDO::PARAM_STR);
$stmt->bindParam(2, $acc_no, PDO::PARAM_STR);
$stmt->bindParam(3, $loan_amount, PDO::PARAM_INT);
$stmt->bindParam(4, $settlement_period, PDO::PARAM_INT);
$stmt->bindParam(5, $income, PDO::PARAM_INT);
$stmt->bindParam(6, $profession, PDO::PARAM_STR);
$stmt->bindParam(7, $address, PDO::PARAM_STR);
$stmt->bindParam(8, $l_ID, PDO::PARAM_STR);
$stmt->bindParam(9, $I_rate, PDO::PARAM_INT);
$stmt->bindParam(10, $install, PDO::PARAM_INT);
$stmt->bindParam(11, $FD_id, PDO::PARAM_INT);

$stmt->execute();
print_r($stmt);