<%@ taglib uri="/WEB-INF/mytag.tld" prefix="my" %>
<%@ page isELIgnored="false" %>
<%
	
	if(session.getAttribute("frid")!=null || request.getParameter("frid")!=null)
	{
		String s1=request.getParameter("frid");
		if(s1 == null)
			s1=(String)session.getAttribute("frid");
		String s2=((Integer)session.getAttribute("userid"))+"";
		session.setAttribute("frid",s1);		
%>
<form action='sendmessage.jsp?rid=<%=s1%>&sid=<%=s2%>' method="post">
	<input type="text" name="message" /><br />
	<input type="submit" name="submit" value="send" />
</form>
<h4>Previous messages</h4>
<my:ShowMessage frid="<%=s1%>" userid="<%=s2%>"></my:ShowMessage>
<%
	}
%>