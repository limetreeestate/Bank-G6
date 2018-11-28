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
    <title>Koffee Bank: Loan Requests</title>
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
            <th class="teal-text text-lighten-1">Customer Name</th>
            <th class="teal-text text-lighten-1">Loan Amount</th>
            <th class="teal-text text-lighten-1">Settlement Period</th>
            <th class="teal-text text-lighten-1">Annual Income</th>
            <th class="teal-text text-lighten-1">Applicant Occupation</th>
            <th class="teal-text text-lighten-1">Work Address</th>
            <th></th>
        </tr>
        </thead>

        <tbody>
            <tr>
                <td>Tyrion Lannister</td>
                <td>300,000</td>
                <td>12 Months</td>
                <td>500,000</td>
                <td>Hand of the Queen</td>
                <td>Dragonstone</td>
                <td><a class="waves-effect waves-light btn green accent-3">Accept</a></td>
            </tr>
            <tr>
                <td>Jon Snow</td>
                <td>150,000</td>
                <td>3 Months</td>
                <td>450,000</td>
                <td>King in the North</td>
                <td>Winterfell</td>
                <td><a class="waves-effect waves-light btn green accent-3">Accept</a></td>
            </tr>
        </tbody>
    </table>
</div>
</body>
</html>

<?php
include_once 'footer.html'
?>