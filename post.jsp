<%@ page session="false" %>
<%@ page import="java.sql.*,java.text.*,java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.DeferredFileOutputStream"%>
<%
{
	buddies.DConnection dcon=new buddies.DConnection();
	int postid=0;
	String msg="",pic="";
	ResultSet rst=dcon.getData("select max(postid) from post");
	try
	{
		if(rst!=null)
		{
			rst.next();
			postid=rst.getInt(1)+1;
			rst.close();
		}
		else
		{
			postid=1;	
		}
		dcon.close();
	}
	catch(SQLException e)
	{
		out.print(e);
	}
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
					if(item.getFieldName().equals("pic"))
					{
					pic=item.getName();
pic=postid+pic.substring(pic.lastIndexOf("."));

					savedFile = new File(config.getServletContext().getRealPath("/")+"postimages/"+pic);
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
				if(fieldname.equals("msg"))
					msg=fieldvalue;
			}
		}
	}
	HttpSession session=request.getSession(false);
	SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date d1=new java.util.Date();
	SimpleDateFormat sdf2 =  new SimpleDateFormat("HH:mm:ss");
	int userid=(Integer)session.getAttribute("userid");
	dcon.setData("insert into post values("+postid+","+userid+",'"+sdf.format(d1)+"','"+sdf2.format(d1)+"','"+msg+"',0,'"+pic+"')");
	dcon.close();
}
%>
<jsp:forward page="home.jsp"></jsp:forward>

