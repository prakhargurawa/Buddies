<%@ page session="false" import="java.sql.*,java.util.*,java.text.*"%>
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

			<div>
				<div id=middle_left style="font-size:12px;padding-top:24px; height:auto; padding-right:10px; width:auto;float:left;border-right:solid #ccc 1px;border-bottom:solid #ccc 1px; padding-bottom:10px">
<%
					String sOfFrlist=(String)session.getAttribute("frlist");
					int userid = (Integer)session.getAttribute("userid");
					if(sOfFrlist.equals("()"))
						return;
					buddies.DConnection mydcon = new buddies.DConnection();
					ResultSet rst3 = mydcon.getData("select name, online, users.userid from users, usersprofile where users.userid=usersprofile.userid and users.userid in "+sOfFrlist);
					while(rst3.next())
					{
%>	
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="showmessage.jsp?rid=<%=userid%>&sid=<%=rst3.getString(3)%>&msgmode=1"><%=rst3.getString(1)%><a><br />
<%
					}
					rst3.close();
					mydcon.close();
%>
				</div>
				<div id=middle_right style="float: right; padding:10px; border:solid #ccc 1px">
<%
					String mode = request.getParameter("msgmode");
					if(mode == null)
					{}
					else
					{
						int rid = Integer.parseInt(request.getParameter("rid"));
						int sid = Integer.parseInt(request.getParameter("sid"));
						String sendmessage = request.getParameter("sendmessage");
						if(sendmessage != null && sendmessage.trim() != "") 
						{
							buddies.DConnection sendcon = new buddies.DConnection();
							sendcon.setData("insert into messages(sid, rid, message, flag) values ("+sid+", "+rid+", '"+sendmessage+"', 0)");
						}
%>
						<form action="showmessage.jsp?rid=<%=rid%>&sid=<%=sid%>&msgmode=1" method="post">
							<input type="text" name="sendmessage" /><br />
							<input type="submit" name="submit" value="send" style="box-shadow: 2px 8px 11px rgb(204, 204, 204)" />
						</form>
<%
						buddies.DConnection mydcon2 = new buddies.DConnection();
						ResultSet rst4 = mydcon2.getData("select message from messages where (rid=" + rid + " and sid = " + sid + ") or (rid = " + sid + " and sid = " + rid + ") order by messageid desc");
						StringBuffer sb = new StringBuffer();
						sb.append("<br />");
						while(rst4.next())
						{
							sb.append(rst4.getString(1) + "<br />");	
						}
						out.print(sb);
						rst4.close();
						mydcon.close();				
					}
%>
				</div>
			</div>

			<div class="footer">
				<%@ include file="footer.jsp" %>
			</div><!-- end .footer -->
		</div><!-- end .container -->
	</body>
</html>

