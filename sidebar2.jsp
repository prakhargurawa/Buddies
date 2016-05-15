Friends
<ul>
<%
{
	buddies.DConnection dcon2=new buddies.DConnection();
	String s1=(String)session.getAttribute("frlist");
	if(s1.equals("()"))
		return;
	ResultSet rst3=dcon2.getData("select name,online,users.userid from users,usersprofile where users.userid=usersprofile.userid and users.userid in "+s1);
	while(rst3.next())
	{
		if(rst3.getInt("online")==1)
		{
%>                       
			<li>
				<img src='userimages/<%=rst3.getInt("userid")%>.jpg' alt='rst3.getString("name")' width="30" height="30"/>
				<a href="#" onclick="showprivatechat(<%=rst3.getInt("userid")%>)"><%=rst3.getString("name")%></a> <img src="images/bullet.jpg" width="10" height="10"/>
			</li>
<%
		}
		else
		{
%>
			<li>
				<img src='userimages/<%=rst3.getInt("userid")%>.jpg' alt='rst3.getString("name")' width="30" height="30"/>
				<a href="#" onclick="showprivatechat(<%=rst3.getInt("userid")%>)"><%=rst3.getString("name")%></a>
			</li>
<%	
		}
	}
	dcon2.close();
}
%>
</ul>
