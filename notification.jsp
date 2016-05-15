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
		int userid=(Integer)session.getAttribute("userid");
		boolean likeflag=false;		
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

							


							
				
			</div><!-- end .content -->
			<div class="sidebar2">
				<div class="sidebar2top">
					<%@ include file="sidebar2.jsp" %>
				</div>
				<div class="sidebar2bottom" id="sidebar2bottom">
<%
					String ss1=request.getParameter("mode");
					String ffrid=request.getParameter("frid");
					if("showmsg".equals(ss1))
					{
						session.setAttribute("frid",ffrid);
%>
						
						<%@ include file="sidebar2bottom.jsp" %>
						
<%
					}
%>
				</div>
			</div><!-- end .sidebar2 -->
			<div class="footer">
				<%@ include file="footer.jsp" %>
			</div><!-- end .footer -->
		</div><!-- end .container -->
	</body>
</html>
