<%@ page session="false"%>
<html>
	<head>
		<title>Buddies</title>
	<head>
	<body>
<%
		String b1 = request.getParameter("b1");
		String sid=request.getParameter("sid");
		String rid=request.getParameter("rid");
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
		if("accept".equalsIgnoreCase(b1))
		{
			dcon.setData("update friends set flag=1 where sid="+sid+" and rid="+rid);
			buddies.CommonMethods cm=new buddies.CommonMethods();
			String s1=cm.friendList(userid);
			session.setAttribute("frlist",s1);
		}
		else
			dcon.setData("delete from friends where sid="+sid+" and rid="+rid);
		dcon.close();
%>	

		<jsp:forward page="showfriendrequest.jsp"></jsp:forward>

	</body>
</html>
