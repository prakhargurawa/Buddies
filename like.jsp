<%@ page session="false" import="java.sql.*"%>
<html>
	<head>
		<title>Buddies</title>
	<head>
	<body>
<%
		String postid = request.getParameter("postid");
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
		ResultSet rst=dcon.getData("select * from likes where userid="+userid+ " and postid="+postid);
		if(rst.next())
		{
			dcon.setData("update post set likes=likes-1 where postid="+postid);
			dcon.close();
			dcon.setData("delete from likes where userid="+userid+ " and postid="+postid);
			dcon.close();
		}
		else
		{
			dcon.setData("update post set likes=likes+1 where postid="+postid);
			dcon.close();
			dcon.setData("insert into likes values("+postid+","+userid+")");
			dcon.close();
		}
		dcon.close();
%>	

		<jsp:forward page="home.jsp"></jsp:forward>

	</body>
</html>
