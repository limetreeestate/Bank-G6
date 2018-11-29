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
            <h2 class="header teal-text text-lighten-1">Welcome to Koffee Bank</h2>
            <h6 class="grey-text text-darken-3 lighten-3">One-Stop site for all your banking needs</h6>
        </div>
        <div class="row container">
            <div class="col s12 m4">
                <div class="card medium">
                    <div class="card-image">
                        <img src="../../include/your-account.jpg">
                        <span class="card-title">Your Account</span>
                    </div>
                    <div class="card-content">
                        <p>Quickly check your Account Balance and recent transactions. You can also print an
                        e-Statement</p>
                    </div>
                    <div class="card-action">
                        <a href="accountDetails.php">Go to your Account</a>
                    </div>
                </div>
            </div>
            <div class="col s12 m4">
                <div class="card medium">
                    <div class="card-image">
                        <img src="../../include/loan.jpg">
                        <span class="card-title">Online Loans</span>
                    </div>
                    <div class="card-content">
                        <p>The quickest way to secure a personal loan! Your dream is just one click away</p>
                    </div>
                    <div class="card-action">
                        <a href="applyLoan.php">Get an online Loan NOW!</a>
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