<%@ page session="false" import="java.sql.*,java.io.*"%>
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
		ResultSet rst=dcon.getData("select * from post where postid="+postid);
		rst.next();
		String msg=rst.getString("msg");
		String sourceimg=rst.getString("imagename");
		rst.close();
		dcon.close();
		String targetimg="";
		if(sourceimg != null && !"".equals(sourceimg))
		{
			try
			{
				rst=dcon.getData("select max(postid) from post");
				rst.next();
				targetimg=rst.getInt(1)+sourceimg.substring(sourceimg.indexOf("."),sourceimg.length());
				File f1=new File(application.getRealPath("/")+"postimages/"+sourceimg);
				File f2=new File(application.getRealPath("/")+"postimages/"+targetimg);
				java.nio.file.Files.copy(f1.toPath(),f2.toPath());
			}
			catch(IOException e)
			{
				out.print(e);
			}
		}

		java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.text.SimpleDateFormat sdf2=new java.text.SimpleDateFormat("HH:mm:ss");
		dcon.setData("insert into post(userid,date,time,msg,likes,imagename) values("+userid+",'"+sdf.format(new java.util.Date())+"','"+sdf2.format(new java.util.Date())+"','"+msg+"',0,'')");
		dcon.close();
%>	

		<jsp:forward page="home.jsp"></jsp:forward>

	</body>
</html>
