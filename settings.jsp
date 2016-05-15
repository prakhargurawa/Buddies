<%@ page session="false" import="java.sql.*"%>
<html>
	<head>
		<title>Buddies</title>
		<link rel="stylesheet" type="text/css" href="css/stylehome.css" />
	</head>
	<body>
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
		
%>		
		<div class="container">
			<div class="header">
				<%@ include file="header.jsp" %>
			</div><!-- end .header -->
			<div class="sidebar1">
				<%@ include file="sidebar1.jsp" %>
			</div><!-- end .sidebar1 -->
			<div class="content">
			<jsp:useBean id="dcon" class="buddies.DConnection"></jsp:useBean>
<%
			if(request.getParameter("mode").equals("1")) 
			{
%>			
				<!-- This is form section -->	
				<form action="settings.jsp?mode=2" method="post" style="font-size: 12px;
margin: 10px;">
					Email: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="email" name="email" placeholder="Enter current Email" /><br />
					current password: <input type="password" name="password"  placeholder="Enter new password"/><br />
					<input type="submit" name="submit" value="submit" /><br />
				</form>
<%
			}
			else if("2".equals(request.getParameter("mode")))
			{
				ResultSet rst = dcon.getData("select * from users where userid=" + (Integer)session.getAttribute("userid") + " and email='"+ request.getParameter("email") +"' and password='"+ request.getParameter("password") +"'");
				if(rst.next())
				{
%>
					<form action="settings.jsp?mode=3" method="post" style="font-size: 12px;
margin: 10px;">
						Email:<input type="email" name="email" placeholder="Enter new Email" /><br />
						password:<input type="password" name="password" placeholder="Enter new password" /><br />
						retype:<input type="password" name="password" placeholder="Retype password" /><br />
						<input type="submit" name="submit" value="Update" /><br />
					</form>
<%						
				}
				else
				{
%>
					<!-- Enter alert of something here! -->
					<jsp:forward page="settings.jsp?mode=1"></jsp:forward>
<%
				}
			}
			else 
			{ 
				String email = "" , password = "";
				email = request.getParameter("email");
				password = request.getParameter("password");
				dcon.setData("update users set email='"+email+"', password='"+password+"' where userid=" + (Integer)session.getAttribute("userid"));
%>
				<jsp:forward page="home.jsp"></jsp:forward>
<%
			}
%>				
			</div><!-- end .content -->
			<div class="sidebar2">
				<%@ include file="sidebar2.jsp" %>
			</div><!-- end .sidebar2 -->
			<div class="footer">
				<%@ include file="footer.jsp" %>
			</div><!-- end .footer -->
		</div><!-- end .container -->
	</body>
</html>
