<%@ page session="false"%>
<html>
	<head>
		<title>Buddies</title>
	<head>
	<body>
<%
		String message = request.getParameter("message");
		String sid=request.getParameter("sid");
		String rid=request.getParameter("rid");
		HttpSession session = request.getSession(false);
		if(session==null)
		{
			out.print("<script>alert('Login first');</script>");
%>
			<jsp:include page="index.jsp"></jsp:include>
<%
			return;
		}
		buddies.DConnection dcon = new buddies.DConnection();
		dcon.setData("insert into messages(rid, sid, message, flag) values("+ rid +","+ sid +",'"+ message +"',0)");
		dcon.close();
%>	

		<jsp:include page="home.jsp">
			<jsp:param name="mode" value="showmsg" />
			<jsp:param name="frid" value="<%=rid%>" />
		</jsp:include>

	</body>
</html>
