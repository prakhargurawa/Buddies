<%@ page session="false"%>
<html>
	<head>
		<title>Buddies</title>
	<head>
	<body>
		<jsp:useBean id="dcon" class="buddies.DConnection"></jsp:useBean>
<%
		HttpSession session=request.getSession(false);
		if(session==null)
		{
			out.print("<script>alert('Login first');</script>");
%>
			<jsp:include page="index.jsp"></jsp:include>
<%
			return;
		}
		Cookie c1 = new Cookie("email", "");
		Cookie c2 = new Cookie("password", "");
		c1.setMaxAge(0);
		c2.setMaxAge(0);
		response.addCookie(c1);
		response.addCookie(c2);
		dcon.setData("Update users set online = 0 where userid=" + session.getAttribute("userid"));
		dcon.close();	
		session.invalidate();
%>		
<jsp:forward page="index.jsp"></jsp:forward>		
	</body>
</html>
