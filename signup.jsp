<%@ page import="java.sql.*" session="false"%>
<!doctype html>
<html>
	<head>
	</head>
	<body>
		<jsp:useBean id="dcon" class="buddies.DConnection"></jsp:useBean>
<%
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String dob = request.getParameter("dob");
		String gen = request.getParameter("gender");
		String mobile=request.getParameter("mobile");
		if(email == null || password == null || name == null || dob == null || gen == null || mobile == null || "".equals(email.trim()) || "".equals(password.trim()) || "".equals(name.trim()) || "".equals(dob.trim()) || "".equals(gen.trim()) || "".equals(mobile.trim()))
		{
%>
			<!-- Include warning msg -->
			<jsp:forward page="index.jsp"></jsp:forward>
<%
			return;
		}	
			try {
			dcon.setData("insert into users(email, password, mobile,online) values('"+email+"', '"+password+"', '"+mobile+"',0)");
			ResultSet rst = dcon.getData("select max(userid) from users");
			rst.next();
			int userid = rst.getInt(1);
			dcon.setData("insert into usersprofile(userid, name, dob, gender) values("+userid+", '"+name+"', '"+dob+"', '"+gen+"')");
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
%>


			<jsp:forward page="index.jsp"></jsp:forward>
	</body>
</html>
