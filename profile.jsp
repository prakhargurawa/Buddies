<%@ page session="false" import="java.sql.*" isELIgnored="false"%>
<%@ page import="java.text.*,java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.DeferredFileOutputStream"%>
<html>
	<head>
		<title>Profile</title>
		<link rel="stylesheet" href="css/stylehome.css" type="text/css" />
	</head>
	<body>
<%
		String profilepic = "";
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
				<jsp:useBean id="p1" class="buddies.Profile" ></jsp:useBean>
<%
				String mode=request.getParameter("mode");
				if("display".equals(mode))
				{
					try
					{
						ResultSet rst=p1.display((Integer)session.getAttribute("userid"));
						rst.next();
%>
<table style="margin-left: 15px;
font-size: 12px;">
	<tr>
		<td><img src='userimages/<%=rst.getString("imagename")%>'alt="Image text" width="100" height="100"></td>
	</tr>
	<tr>
		<td>Name:</td>
		<td><%=rst.getString("name")%></td>
	</tr>
	<tr>
		<td>DOB:</td>
		<td><%=rst.getString("dob")%></td>
	</tr>
	<tr>
		<td>Gender:</td>
		<td><%=rst.getString("gender")%></td>
	</tr>
</table>
<%						
					}
					catch(SQLException e)
					{
						out.print(e);
					}
				}
				else if("edit".equals(mode))
				{
					try
					{
						ResultSet rst=p1.display((Integer)session.getAttribute("userid"));
						rst.next();
%>
<form action="profile.jsp?mode=update" method="post" enctype="multipart/form-data">
	<table style="margin-left: 15px;
font-size: 12px;">
		<tr>
			<td>Name</td>
			<td><input type="text" name="name" value="<%=rst.getString("name")%>" /></td>
		</tr>
		<tr>
			<td>DOB</td>
			<td><input type="date" name="dob" value="<%=rst.getString("dob")%>" /></td>
		</tr>
		<tr>
			<td>Gender</td>
			<td>
<%
				String gender=rst.getString("gender");
				if("male".equals(gender))
				{
%>				
					<input type="radio" name="gender" value="male" checked="on" />Male<input type="radio" name="gender" value="female" />Female
<%
				}
				else
				{
%>
					<input type="radio" name="gender" value="male" />Male<input type="radio" name="gender" value="female" checked="on" />Female
<%
				}
%>							
			</td>
		</tr>
		<tr>
			<td>Profile Picture</td>
			<td><input type="file" name="profilepic" /></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" name="submit" value="update" />
		</tr>
	</table>
</form>
<%						
					}
					catch(SQLException e)
					{
						out.print(e);
					}

				}
				else
				{
					int userid=(Integer)session.getAttribute("userid");
					String name="",dob="",gender="";
					boolean isMultipart = ServletFileUpload.isMultipartContent(request);
					if (isMultipart) 
					{
						FileItemFactory factory = new DiskFileItemFactory();
						ServletFileUpload upload = new ServletFileUpload(factory);
						List items = null;
						try 
						{
							items = upload.parseRequest(request);
						} 
						catch (FileUploadException e) 
						{
							e.printStackTrace();
						}
						Iterator itr = items.iterator();
						while (itr.hasNext()) 
						{
							FileItem item = (FileItem) itr.next();
							if (!item.isFormField())
							{
								try 
								{
									File savedFile=null;
									if(item.getFieldName().equals("profilepic"))
									{
										profilepic=item.getName();
										profilepic=userid+profilepic.substring(profilepic.lastIndexOf("."));
										savedFile = new File(config.getServletContext().getRealPath("/")+"userimages/"+profilepic);
									}
									item.write(savedFile);
								} 
								catch (Exception e) 
								{
									e.printStackTrace();
								}
							}
							else
							{
								String fieldname = item.getFieldName();
								String fieldvalue = item.getString();
								if(fieldname.equals("name"))
									name=fieldvalue;
								if(fieldname.equals("dob"))
									dob=fieldvalue;
								if(fieldname.equals("gender"))
									gender=fieldvalue;
							}
						}
					}
%>
					<jsp:setProperty name="p1" property="name" value="<%=name%>" ></jsp:setProperty>
					<jsp:setProperty name="p1" property="dob" value="<%=dob%>" ></jsp:setProperty>
					<jsp:setProperty name="p1" property="gender" value="<%=gender%>" ></jsp:setProperty>
					<jsp:setProperty name="p1" property="profilepic" value="<%=profilepic%>" ></jsp:setProperty>
<%
					p1.update(userid);
%>
					<jsp:forward page="profile.jsp?mode=display"></jsp:forward>
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
