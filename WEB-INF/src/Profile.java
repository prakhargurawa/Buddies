package buddies;
import java.sql.*;
public class Profile
{
	ResultSet rst;
	private String name,dob,gender,profilepic;

	public void setName(String name)
	{
		this.name=name;
	}
	public void setDob(String dob)
	{
		this.dob=dob;
	}
	public void setGender(String gender)
	{
		this.gender=gender;
	}
	public void setProfilepic(String profilepic)
	{
		this.profilepic = profilepic;
	}
	public ResultSet display(int userid)
	{
		DConnection dcon=new DConnection();
		rst=dcon.getData("select * from usersprofile where userid="+userid);
		return rst;
	}
	public void update(int userid)
	{
		DConnection dcon=new DConnection();
		dcon.setData("update usersprofile set name='"+name+"', dob='"+dob+"', gender='"+gender+"', imagename='"+profilepic+"' where userid="+userid);
		dcon.close();
	}
}
