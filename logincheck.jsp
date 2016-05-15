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
		
		ResultSet rst=dcon.getData("select * from users where email='"+email+"' and password='"+password+"'");
		if(rst.next())
		{
			int userid=rst.getInt(1);
			String mobile=rst.getString("mobile");
			rst.close();
			dcon.close();
			dcon.setData("update users set online=1 where userid="+userid);
			buddies.CommonMethods cm=new buddies.CommonMethods();
			String s1=cm.friendList(userid);
			HttpSession session=request.getSession();
			session.setAttribute("email",email);
			session.setAttribute("userid",userid);
			session.setAttribute("mobile",mobile);
			session.setAttribute("frlist",s1);
			/*
			rst=dcon.getData("select * from usersprofile where userid="+userid+"");
			String fname=rst.getString("fname");
			rst.close();
			dcon.close();
			session.setAttribute("fname",fname);
			image also
			*/
			
			String km = request.getParameter("km");
			if(km!=null && km.equals("on")) 
			{
				Cookie c1 = new Cookie("email", email);
				Cookie c2 = new Cookie("password", password);
				c1.setMaxAge(15*14*3600);
				c2.setMaxAge(15*14*3600);
				response.addCookie(c1);
				response.addCookie(c2);
			}
%>
			<jsp:forward page="home.jsp"></jsp:forward>
<%
			
		} 
		else 
		{
			Cookie c1 = new Cookie("email", email);
			Cookie c2 = new Cookie("password", password);
			c1.setMaxAge(0);
			c2.setMaxAge(0);
			response.addCookie(c1);
			response.addCookie(c2);
			out.print("<script>alert('Invalid user or password');</script>");
%>
			<jsp:include page="index.jsp"></jsp:include>
<%
		}
%>
	</body>
</html>
