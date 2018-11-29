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
    <title>Koffee Bank: Transaction Summary</title>
    <link rel="shortcut icon" href="../../include/icon.ico" />
    <link rel="stylesheet" href="../../include/css/materialize.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../../include/js/materialize.js"></script>
</head>
<body>
<div class="container">
    <div class="row"></div>
    <h5 class="teal-text text-lighten-1">Loan Requests</h5>
    <div class="row"></div>
    <table class="highlight">
        <thead>
        <tr>
            <th class="teal-text text-lighten-1">Timestamp</th>
            <th class="teal-text text-lighten-1">Type</th>
            <th class="teal-text text-lighten-1">From</th>
            <th class="teal-text text-lighten-1">To</th>
            <th class="teal-text text-lighten-1">Amount</th>
        </tr>
        </thead>

        <tbody>
        <tr>
            <td>-time-</td>
            <td>Withdrawal</td>
            <td>1000100001</td>
            <td>N/A</td>
            <td>12,000</td>
        </tr>
        <tr>
            <td>-time-</td>
            <td>Deposit</td>
            <td>N/A</td>
            <td>1000100002</td>
            <td>34,000</td>
        </tr>
        <tr>
            <td>-time-</td>
            <td>Transfer</td>
            <td>1000100031</td>
            <td>1000200033</td>
            <td>43,000</td>
        </tr>
        </tbody>
    </table>
</div>
    <div class="row" style="margin-bottom: 40px"></div>
</body>
</html>

<?php
include_once 'footer.html'
?>