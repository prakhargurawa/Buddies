<%@ page session="false" %>
<!DOCTYPE html>

<html lang="en">
	

<head>
	
		<meta charset="utf-8">
	
		<title>Buddies</title>

	
		<!-- Google Fonts -->
	
		<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700|Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

	
		<link rel="stylesheet" href="css/animate.css">
			<!-- Custom Stylesheet -->
	
		<link rel="stylesheet" href="css/style.css">

			<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

</head>


	<body>
	
		<div class="container">
		
			<div class="top">

				<h1 id="title" class="hidden"><span id="logo">Buddies <span></span></span></h1>
				</div>
		
			<div class="login-box animated fadeInUp">
				<div class="box-header">

				<h2>Sign Up</h2>

			</div>
	
	<form action="signup.jsp" method="post" id="signupform">
		<table>
			<tr>
				<td><input type="text" name="name" placeholder="Enter Name"></td>
			</tr>
			<tr>
				<td><input type="email" name="email" placeholder="Enter Email ID"></td>
			</tr>
			<tr>
				<td><input type="email" name="retypeemail" placeholder="Enter Email ID again"></td>
			</tr>
			<tr>
				<td><input type="password" name="password" placeholder="Enter password"></td>
			</tr>
			<tr>
				<td><input type="text" name="mobile" placeholder="Enter Mobile Number"></td>
			</tr>
			<tr>
				<td>Birthday:</td>
			</tr>
			<tr>
				<td><input type="date" name="dob"></td>
			</tr>
			<tr>
				<td><input type="radio" name="gender" value="male" />Male <input type="radio" name="gender" value="female" />Female </td>
			</tr>
			<tr>
				<td>By clicking Sign Up, you agree to our <a href="terms.jsp">Terms</a>.</td>
			</tr>
			<tr>
				<td><input type="submit" name="sub2" value="Sign Up" /></td>
			</tr>
		</table>
	</form>		
</div>
	
</div>

</body>


<script>
	$(document).ready(function () {
    	$('#logo').addClass('animated fadeInDown');
    	$("input:text:visible:first").focus();
	});
	$('#username').focus(function() {
		$('label[for="username"]').addClass('selected');
	});
	$('#username').blur(function() {
		$('label[for="username"]').removeClass('selected');
	});
	$('#password').focus(function() {
		$('label[for="password"]').addClass('selected');
	});
	$('#password').blur(function() {
		$('label[for="password"]').removeClass('selected');
	});
</script>



</html>
