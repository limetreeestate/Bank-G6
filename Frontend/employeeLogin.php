<?php
/**
 * Created by IntelliJ IDEA.
 * User: Suchitha
 * Date: 11/29/2018
 * Time: 12:18 AM
 */

require_once '../include/database-public-connect.php';
if (isset($_POST['submit']))
{
    $statement= $pdo -> prepare("SELECT * FROM Login WHERE username = ? AND password = ?");
    $statement -> execute(array($_POST['username'], $_POST['password']));

    foreach ($statement -> fetch(PDO::FETCH_ASSOC) as $row)
    {
        $_SESSION['employee_ID'];
        header('employee/home.php');
    }
    
}


?>

<div id="Login" class="hidden" style="display: block;">
        <div class="inner">
            <form method="post" action = "<?= $_SERVER['PHP_SELF'] ?>">&gt;
			  <fieldset class="form-group" >
				<label for="nic" >Username</label>
				<input type="text" name="username" class="form-control" maxlength="10" required="">
			  </fieldset>
			  <fieldset class="form-group">
				<label for="password">Password</label>
				<input type="password" name="password" class="form-control" required="">
			  </fieldset>
			  <p class="error"></p>
			  <fieldset class="form-group">
				<input type="submit" class="btn btn-primary" name="submit">
			  </fieldset>
			  
			</form>
    </div>
</div>
