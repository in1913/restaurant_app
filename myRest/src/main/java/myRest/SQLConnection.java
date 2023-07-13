package myRest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLConnection {
	private static String uid = "root";
	private static String pass = "whoareyou1085!";
	private static String url = "jdbc:mysql://localhost:3306/mywork";
	private static String opt = "useUnicode=true&characterEncoding=UTF-8";
	static {
		url = url + "?" + opt;
	}
	public static Connection initConnection() {
		Connection conn = null;
		
		try {
			// JDBC 클래스를 얻는다.	
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// DB 연결
			conn = DriverManager.getConnection(url, uid, pass);
			System.out.println("접속 성공");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}
