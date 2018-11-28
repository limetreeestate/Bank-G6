<?php
include_once 'header.html'
?>

<!DOCTYPE html>
<html>
<head>
    <title>Koffee Bank: Add New Customer</title>
    <link rel="shortcut icon" href="../../include/icon.ico" />
    <link rel="stylesheet" href="../../include/css/materialize.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../../include/js/materialize.js"></script>
    <script>
        $(document).ready(function(){
            $('.datepicker').datepicker();
        });
    </script>
</head>
<body>

<!-- INCLUDE HEADER -->

<div class="container">
    <h4 class="teal-text text-lighten-1">ADD NEW CUSTOMER</h4>
    <form action="" class="col s12">
        <div class="row">
            <div class="input-field col s6">
                <input id="first_name" type="text" class="validate" required>
                <label for="first_name">First Name</label>
            </div>
            <div class="input-field col s6">
                <input id="last_name" type="text" class="validate" required>
                <label for="last_name">Last Name</label>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s12">
                <label for="address">Address</label>
                <input id="address" type="text" class="validate" required>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s6">
                <label for="nic">NIC</label>
                <input type="text" id="nic" type="text" class="validate" required>
            </div>
            <div class="input-field col s6">
                <label for="dob">Date of Birth</label>
                <input type="text" id="dob" class="validate datepicker" required>
            </div>
        </div>
        <div id="telephone" class="row">
            <div class="input-field col s6">
                <label for="phone_mobile">Phone(Mobile)</label>
                <input type="text" id="phone_mobile" type="text" class="validate" required>
            </div>
            <div class="input-field col s6">
                <label for="phone_home">Phone(Home)</label>
                <input type="text" id="phone_home" type="text" class="validate" required>
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