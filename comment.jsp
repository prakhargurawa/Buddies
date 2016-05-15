<%@ page session="false" import="java.sql.*,java.io.*"%>
<html>
	<head>
		<title>Buddies</title>
	<head>
	<body>
<%
		String postid = request.getParameter("postid");
		String comment = request.getParameter("comment");
		HttpSession session = request.getSession(false);
		int userid=(Integer)session.getAttribute("userid");
		if(session==null)
		{
			out.print("<script>alert('Login first');</script>");
%>
			<jsp:include page="index.jsp"></jsp:include>
<%
			return;
		}
		buddies.DConnection dcon = new buddies.DConnection();
		dcon.setData("insert into comments(postid,userid,comment) values("+postid+","+userid+",'"+comment+"')");
		dcon.close();
%>	

		<jsp:forward page="home.jsp"></jsp:forward>

	</body>
</html>
