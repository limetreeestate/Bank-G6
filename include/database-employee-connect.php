<?php
$pdo = new PDO("mysql:host=localhost;port=3306;dbname=bank_demo", "employee", "employee123");
$pdo -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
?>