package buddies;
import java.sql.*;
public class CommonMethods
{
	ResultSet rst;
	public String friendList(int userid)
	{
		String s1="( ";
		try
		{
			DConnection dcon=new DConnection();
			rst=dcon.getData("select rid from friends where sid="+userid+" and flag=1");
			while(rst.next())
			{
				s1+=rst.getString(1)+",";	
			}	
			rst.close();
			dcon.close();
			rst=dcon.getData("select sid from friends where rid="+userid+" and flag=1");
			while(rst.next())
			{
				s1+=rst.getString(1)+",";	
			}
			s1=s1.substring(0,s1.length()-1);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		s1+=")";
		return s1;
	}
}