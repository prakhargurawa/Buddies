package buddies;
import java.sql.*;
public class DConnection 
{
	Connection conn;
	Statement stmt;
	ResultSet rst;
	public DConnection()
	{
		setData("create table if not exists users(userid int primary key auto_increment, email varchar(255) unique key not null, password varchar(255) , mobile varchar(15) unique key not null, online bit)");
		close();
		setData("create table if not exists adminusers(userid int primary key auto_increment,email varchar(255) unique key not null, password varchar(255), mobile varchar(15) unique key not null)");
		close();
		setData("create table if not exists usersprofile(userid int, name varchar(255), dob date, gender enum('male', 'female'),  foreign key(userid) references users(userid), imagename varchar(50))");
		close();
		setData("create table if not exists post(postid int primary key auto_increment, userid int, date date, time time, msg text, likes int, imagename varchar(20))");
		close();
		setData("create table if not exists friends(rid int, sid int ,flag bit)");
		close();
		setData("create table if not exists likes(postid int, userid int)");
		close();
		setData("create table if not exists comments(commentid int primary key auto_increment, postid int,userid int,comment varchar(255))");
		close();
		setData("create table if not exists messages(messageid int primary key auto_increment, sid int,rid int,message text,flag bit)");
		close();
	}
	public int setData(String qry)//insert,delete,update
	{
		int cnt=0;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/buddies","root","");
			stmt=conn.createStatement();
			cnt=stmt.executeUpdate(qry);
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();	
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return cnt;
	}
	public ResultSet getData(String qry)//select
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/buddies","root","");
			stmt=conn.createStatement();
			rst=stmt.executeQuery(qry);
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();	
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}		
		return rst;
	}
	public void close()
	{
		try
		{
			if(stmt!=null)
				stmt.close();
			if(conn!=null)
				conn.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
}
