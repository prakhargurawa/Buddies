<%@ page session="false"%>
<html>
	<head>
		<title>Buddies</title>
	<head>
	<body>
<%
		String searchbox = request.getParameter("searchbox");
		String sid = request.getParameter("sid");
		String rid = request.getParameter("rid");
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
		dcon.setData("insert into friends values("+rid+","+sid+",0)");
		dcon.close();
%>	

		<jsp:forward page="friendsearch.jsp">
			<jsp:param name="searchbox" value="<%=searchbox%>"></jsp:param> 
		</jsp:forward>

	</body>
</html>
