package buddies;
import java.sql.*;
import javax.servlet.jsp.tagext.*;
import java.io.*;
import javax.servlet.jsp.*;
public class ShowMessage extends TagSupport
{
	ResultSet rst;
	private String frid, message, flag, userid;
	public void setUserid(String userid) 
	{
		this.userid = userid;
	}
	public void setFrid(String frid)
	{
		this.frid = frid;
	}	
	public int doStartTag() throws JspException
	{
		try 
		{
			JspWriter out = pageContext.getOut();
			DConnection dcon = new DConnection();
			rst = dcon.getData("select * from messages where (sid="+userid+" and rid="+frid+") or (sid="+frid+" and rid="+userid+") order by messageid desc");
			while(rst.next()) 
			{
				if(rst.getString("sid").equals(userid))
				{
					out.print("Me: " + rst.getString("message")+"<br />");	
				}
				else
				{
					DConnection dcon2 = new DConnection();
					ResultSet rst2 = dcon2.getData("select name from usersprofile where userid=" + frid);
					rst2.next();
					out.print(rst2.getString("name") + ": " + rst.getString("message")+"<br />");
					rst2.close();
					dcon2.close();	
				}
			}
			rst.close();
			dcon.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
}