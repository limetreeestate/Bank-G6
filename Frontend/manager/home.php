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
    <title>Koffee Bank: Customer Home</title>
    <link rel="shortcut icon" href="../../include/icon.ico" />
    <link rel="stylesheet" href="../../include/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../../include/js/materialize.js"></script>
    <script>
        $(document).ready(function(){
            $('.parallax').parallax();
        });
    </script>
</head>
<body>
    <div class="parallax-container">
        <div class="parallax"><img src="../../include/parallax-1.jpg"></div>
    </div>
    <div class="section white">
        <div class="row container">
            <h2 class="header teal-text text-lighten-1">Welcome to Your Home Page</h2>
            <h6 class="grey-text text-darken-3 lighten-3">One-Stop hub for all your managing needs</h6>
        </div>
        <div class="row container">
            <div class="col s12 m4">
                <div class="card medium">
                    <div class="card-image">
                        <img src="../../include/employees.jpg">
                        <span class="card-title">New Employee</span>
                    </div>
                    <div class="card-content">
                        <p>Quickly add the details of the new employees to the database through here.</p>
                    </div>
                    <div class="card-action">
                        <a href="addEmployee.php">Add New Employee</a>
                    </div>
                </div>
            </div>
            <div class="col s12 m4">
                <div class="card medium">
                    <div class="card-image">
                        <img src="../../include/loan.jpg">
                        <span class="card-title">Loan Requests</span>
                    </div>
                    <div class="card-content">
                        <p>You can check and accept all the loan requests pending your approval from here. </re></p>
                    </div>
                    <div class="card-action">
                        <a href="loanRequests.php">Accept Loan Requests</a>
                    </div>
                </div>
            </div>
            <div class="col s12 m4">
                <div class="card medium">
                    <div class="card-image">
                        <img src="../../include/customers.jpg">
                        <span class="card-title">New Customer</span>
                    </div>
                    <div class="card-content">
                        <p>Quickly add the details of the new customers to the database through here.</p>
                    </div>
                    <div class="card-action">
                        <a href="addEmployee.php">Add New Customer</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row container">
            <div class="col s12 m4">
                <div class="card medium">
                    <div class="card-image">
                        <img src="../../include/your-account.jpg">
                        <span class="card-title">Transaction Summary</span>
                    </div>
                    <div class="card-content">
                        <p>Here is a summary of all the transactions happened through your branch for the
                        past month</p>
                    </div>
                    <div class="card-action">
                        <a href="transactionSummary.php">View Summary</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="parallax-container">
        <div class="parallax"><img src="../../include/parallax-1.jpg"></div>
    </div>
</body>
</html>

<?php
include_once 'footer.html'
?>