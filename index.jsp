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
	
<%
	Cookie cookies[] = request.getCookies();
	if(cookies!=null)
	{ 
		String email="", password="";
		for(int i = 0; i < cookies.length; ++i) 
		{
			if(cookies[i].getName().equals("email"))
				email = cookies[i].getValue();
			if(cookies[i].getName().equals("password"))
				password = cookies[i].getValue();
		}
		if(!"".equals(email) && !"".equals(password))
		{
%>
			<jsp:forward page="logincheck.jsp">
				<jsp:param name="email" value="<%=email%>"></jsp:param>
				<jsp:param name="password" value="<%=password%>"></jsp:param>
			</jsp:forward>
<%	
			return;
		}
	}
%>

		<div class="container">
		
			<div class="top">

				<h1 id="title" class="hidden"><span id="logo">Buddies <span></span></span></h1>
				</div>
		
			<div class="login-box animated fadeInUp">
				<div class="box-header">

				<h2>Log In</h2>

			</div>
			
	<form action="logincheck.jsp" method="post" id="loginform">
		<table>
			<tr>
				<td>email</td>
				<td><input type="mail" name="email" id="username"></td>
			</tr>
			<tr>
				<td>password</td>
				<td><input type="password" name="password" id="password"></td>
			</tr>
			<tr>
				<td><input type ="checkbox" name="km">Keep me Logged</td>
				<td><input type="submit" name="sub1" value="Log In"></td>
			</tr>
		</table>
	</form>
	<a href="signupform.jsp"><p class="small">New User SignUp</p></a>
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
