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
				<form action="post.jsp" method="post" enctype="multipart/form-data">
					<input type="Text" placeholder="Enter your message" name="msg" /><br />
					Upload Image<input type="file" name="pic" /><br />
					<input type="submit" name="submit1" value="Post" />
				</form>
				<jsp:useBean id="dcon" class="buddies.DConnection"></jsp:useBean>
<%
				String searchbox=request.getParameter("searchbox");
				int myuserid=(Integer)session.getAttribute("userid");
				try
				{
					Vector<Integer> pendinglist=new Vector<Integer>();
					Vector<Integer> friendlist=new Vector<Integer>();
					ResultSet rst=dcon.getData("select * from friends where sid="+myuserid+" or rid="+myuserid);
					while(rst.next())
					{
						if(rst.getInt("sid")==myuserid)
						{
							if(rst.getInt("flag")==0)
								pendinglist.addElement(rst.getInt("rid"));
							else
								friendlist.addElement(rst.getInt("rid"));
						}
						else
						{
							if(rst.getInt("flag")==0)
								pendinglist.addElement(rst.getInt("sid"));
							else
								friendlist.addElement(rst.getInt("sid"));
						}
					}					
					rst=dcon.getData("select * from usersprofile where name like '"+searchbox+"%'");
					while(rst.next())
					{
						if(rst.getInt("userid")==myuserid)
							continue;
						else if(pendinglist.contains(rst.getInt("userid")))
						{
%>
							Name:<%=rst.getString("name")%> Request Pending<br />
<%
						}
						else if(friendlist.contains(rst.getInt("userid")))
						{
%>
							Name:<%=rst.getString("name")%> Already Friend<br />
<%

						}
						else
						{
%>
						Name:<%=rst.getString("name")%>
						<form action="sendfriendrequest.jsp?sid=<%=myuserid%>&rid=<%=rst.getString("userid")%>&searchbox=<%=searchbox%>" method="post">
							<input type="submit" value="Add Friend" name="submit" />
						</form>
						<br />
<%

						}
					}					
				}
				catch(SQLException e)
				{
					out.print(e);
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
