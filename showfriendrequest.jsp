<%@ page session="false" import="java.sql.*,java.util.*"%>
<html>
	<head>
		<title>Buddies</title>
		<link rel="stylesheet" type="text/css" href="css/stylehome.css" />
	<head>
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
				int userid=(Integer)session.getAttribute("userid");
				try
				{
					ResultSet rst=dcon.getData("select sid from friends where rid="+userid+" and flag=0");
					while(rst.next())
					{
						int sid=rst.getInt("sid");
						ResultSet rst2=dcon.getData("select name from usersprofile where userid="+sid);
						rst2.next();
%>

<form action="acceptrequest.jsp?rid=<%=userid%>&sid=<%=sid%>" method="post">
	Name:<%=rst2.getString(1)%>	
	<input type="submit" style="box-shadow: 2px 4px 11px rgb(204, 204, 204)" value="Accept" name="b1" />
	<input type="submit" style="box-shadow: 2px 4px 11px rgb(204, 204, 204)" value="Decline" name="b1" />
</form>
<%
					}
				}
				catch(SQLException e)
				{
					out.print(e);
				}
				//rst.close();
				//rst2.close();
				dcon.close();
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
