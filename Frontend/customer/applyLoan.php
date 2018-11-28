<?php
include_once 'header.html'
?>
<!DOCTYPE html>
<html>
<head>
    <title>Koffee Bank: Loan Application</title>
    <link rel="shortcut icon" href="../../include/icon.ico" />
    <link rel="stylesheet" href="../../include/css/materialize.min.css">
    <script type="text/javascript" src="../../include/js/materialize.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>

<!-- INCLUDE HEADER -->

<div class="container">
    <h4 style="margin-bottom: 20px" class="teal-text text-lighten-2">LOAN APPLICATION</h4>
    <form action="addLoan.php" method="post" class="col s8" style="margin-bottom: 40px">
        <div class="row">
            <div class="input-field col s4">
                <label for="acc_no">Account Number</label>
                <input name="acc_no" id="acc_no" type="text" class="validate" required>
            </div>
            <div class="input-field col s4">
                <label for="FD_id">Fixed Deposit ID</label>
                <input id="FD_id" name="FD_id" type="text" class="validate" required>
            </div>
        <
            /div>
        <div class="row">
            <div class="input-field col s8">
                <label for="loan_amount">Loan Amount</label>
                <input name="loan_amount" id="loan_amount" type="text" class="validate" required>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s4">
                <label for="settlement_period">Settlement Period (Months)</label>
                <input name="settlement_period" id="settlement_period" type="text" class="validate" required>
            </div>
            <div class="input-field col s4">
                <label for="income">Applicant Income (LKR)</label>
                <input name="income" id="income" type="text" class="validate" required>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s8">
                <label for="profession">Applicant Profession</label>
                <input name="profession" id="profession" type="text" class="validate" required>
            </div>
        </div>
        <div class="row">
            <div  class="input-field col s8">
                <label for="address">Professional Address</label>
                <input name="address" id="address" type="text" class="validate" required>
            </div>
        </div>
        <button class="btn waves-effect waves-light" type="submit" name="action">Submit
            <i class="material-icons right">send</i>
        </button>
    </form>
</div>

<!-- INCLUDE FOOTER -->
</body>
</html>

<?php
include_once 'footer.html'
?>