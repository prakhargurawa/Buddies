<%@ page session="false" import="java.sql.*,java.util.*,java.text.*"%>
<html>
	<head>
		<title>Buddies</title>
		<link rel="stylesheet" type="text/css" href="css/stylehome.css" />

<script>
	function showprivatechat(frid)
	{
//		document.getElementById("sidebar2bottom").style.display="block";
		var xmlhttp;
		xmlhttp=new XMLHttpRequest();
		xmlhttp.onreadystatechange=function()
		{
			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
			    document.getElementById("sidebar2bottom").innerHTML=xmlhttp.responseText;
			}
		}
		xmlhttp.open("GET","sidebar2bottom.jsp?frid="+frid,true);
		xmlhttp.send();
	}
</script>

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
			<div class="content" style="margin-left:20px; font-size:12px;">
			  <form action="post.jsp" method="post" enctype="multipart/form-data">
					<input type="Text" placeholder="Enter your message" name="msg" style="width:400px;height:30px;" /><br />
					<input type="file" name="pic" style="background-color:lightgray; margin-top:5px" /><br />
					<input type="submit" name="submit1" value="Post" style="margin-top:5px" />
			  </form>
			  <jsp:useBean id="dcon" class="buddies.DConnection"></jsp:useBean>
<%
			  String myfrlist = (String)(session.getAttribute("frlist"));
			  if("()".equals(myfrlist) || myfrlist == null) 
			  {
				out.print("No posts");
			  }
			  else
			  {
				try
				{
					ResultSet rst=dcon.getData("select * from post where userid = "+ userid +" or userid in " + myfrlist + " order by postid desc");
					while(rst.next())
					{
%>
						<div style="border: 1px solid rgb(225, 215, 215);
width: 575px;
padding-left: 15px;
padding-top: 5px;" id="<%=rst.getString(1)%>">
<%
				
							int postuserid=rst.getInt("userid");
							int postid=rst.getInt("postid");
							buddies.DConnection dcon2=new buddies.DConnection();
							ResultSet rst2=dcon2.getData("select name from usersprofile where userid="+postuserid+"");
							rst2.next();
%>
							<%=rst2.getString(1)%><br />
<%								
							rst2.close();
							dcon2.close();
							rst2=dcon2.getData("select * from likes where postid="+postid+" and userid="+userid);
							if(rst2.next())
								likeflag=true;
							else
								likeflag=false;
							rst2.close();
							dcon2.close();
try
{
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date postdatetime=sdf.parse(rst.getString("date") + " " + rst.getString("time"));
	Calendar c1=Calendar.getInstance();
	c1.setTime(postdatetime);
	long postmillis=c1.getTimeInMillis();
	Calendar c2=Calendar.getInstance();
	long currentmillis=c2.getTimeInMillis();
	long diff=(currentmillis-postmillis)/1000;
	if(diff<60)
		out.print(diff + " seconds Ago<br />");
	else
	{
		diff=diff/60;
		if(diff<60)
			out.print(diff + " Minutes Ago<br />");	
		else
		{
			diff=diff/60;
			if(diff<24)
				out.print(diff + " Hours Ago<br />");
			else
				out.print(rst.getString("date")+"<br />");
		}
	}
}
catch(ParseException e)
{
	out.print(e);
}
%>
							<%=rst.getString("msg")%><br />
<%
							String img=rst.getString("imagename");
							if(img!=null && !img.trim().equals(""))
							{
%>
								<img src="<%="postimages/"+rst.getString("imagename")%>" width="150" height="150" /><br />
<%
							}
							if(likeflag==true)
							{
%>
								<a
 href="like.jsp?postid=<%=rst.getString("postid")%>" style="color:blue">Like</a> 
<%
							}
							else
							{
%>
								<a href="like.jsp?postid=<%=rst.getString("postid")%>">Like</a> 
<%
							}
%>
							<a href="share.jsp?postid=<%=rst.getString("postid")%>&userid=<%=userid%>">Share</a><br />
							<%=rst.getString("likes")%> likes<br />
<%
							rst2=dcon2.getData("select * from comments where postid="+postid);
							while(rst2.next())
							{
								String commentuserid=rst2.getString("userid");
								String comment = rst2.getString("comment");
								buddies.DConnection dcon3 = new buddies.DConnection();
								ResultSet rst3 = dcon3.getData("select name from usersprofile where userid=" + commentuserid);
								rst3.next();
%>
								<img src="userimages/<%=commentuserid%>.jpg" width="33" height="33"/>
								<%=rst3.getString("name")%>	
								<%=comment%><br />
<%
								rst3.close();
								dcon3.close();
							}
							rst2.close();
							dcon2.close();
%>
							<form action="comment.jsp?postid=<%=postid%>" method="post">
								<img src='userimages/<%=(Integer)session.getAttribute("userid")%>.jpg'alt="Image" width="38" height="38">
								<textarea name="comment" rows=1 cols="15"></textarea>
								<input style="background-color: beige;
box-shadow: 2px 4px 11px rgb(204, 204, 204);
position: relative;
top: -5px;" type="submit" value="Submit"  />
							</form>

						</div>
<%
					}
					rst.close();
					dcon.close();
				}
				catch(SQLException e)
				{
					out.print(e);
				}
			  }
				
							
%>				
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
