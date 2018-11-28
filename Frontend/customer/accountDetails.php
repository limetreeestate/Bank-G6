<?php
include_once 'header.html'
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Koffee Bank: Your Account</title>
    <link rel="shortcut icon" href="../../include/icon.ico" />
    <link rel="stylesheet" href="../../include/css/materialize.min.css">
    <script type="text/javascript" src="../../include/js/materialize.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
<div class="container">

<h4 class="teal-text text-lighten-1">Your Account</h4>

<div class="row"></div>

<div class="row">
    <div class="col s12 m4">
        <div class="card blue-grey darken-2">
            <div class="card-content white-text">
                <span class="card-title">122,345</span>
                <p>This is your current Balance</p>
            </div>
        </div>
    </div>

    <div class="col s12 m4">
        <div class="card teal lighten-1">
            <div class="card-content white-text">
                <span class="card-title">117,345</span>
                <p>This is your withdrawable Balance</p>
            </div>
        </div>
    </div>
</div>
    <div class="row"></div>

    <h5>Recent Transactions</h5>

    <div class="row"></div>
    <table class="highlight">
        <thead>
        <tr>
            <th>Timestamp</th>
            <th>Type</th>
            <th>Amount</th>
            <th>Balance</th>
        </tr>
        </thead>

        <tbody>
        <tr>
            <td>-time-</td>
            <td>Withdrawal</td>
            <td>25000</td>
            <td>122,345</td>
        </tr>
        <tr>
            <td>-time-</td>
            <td>Deposit</td>
            <td>50,000</td>
            <td>147,345</td>
        </tr>
    </table>
    <div class="row"></div>
    <a class="waves-effect waves-light btn-large"><i class="material-icons left">print</i>
        Print e-Statement</a>
</div>
</body>
</html>

<?php
include_once 'footer.html'
?>