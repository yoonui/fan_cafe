package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import board.BOARD;


public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// mysql에 접속 주는 부분
	public UserDAO() { // 생성자가 실행될 때마다 자동으로 db연결이 이루어질 수 있도록 함
		try {
			String dbURL ="jdbc:mysql://localhost:3306/spring_db?characterEncoding=UTF-8&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
			String dbID="root";
			String dbPassword="1189";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인을 시도하는 함수
	public int login(String userID, String userPassword) {
		String SQL = "SELECT pw FROM USER WHERE id=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}else {
					return 0;
				}
			}
			return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	// 닉네임을 리턴하는 함수
	public String nick(String userID) {
		String SQL = "SELECT nickname FROM USER WHERE id=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	// 회원가입
	public int join(USERS user) {
		String SQL = "INSERT INTO user VALUES (?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPw());
			pstmt.setString(3, user.getNickname());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
	
	// 사용자 계정을 불러오는 함수
	public USERS getuser (String userid) {
		String SQL = "SELECT * FROM user WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				USERS u = new USERS();
				
				u.setId(rs.getString(1));
				u.setPw(rs.getString(2));
				u.setNickname(rs.getString(3));
			
				return u;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 수정 함수
	public int update(String id, String pw, String nickname) {
		String SQL = "UPDATE user SET pw = ?, nickname = ? WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, pw);
			pstmt.setString(2, nickname);
			pstmt.setString(3, id);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; // 데이터베이스 오류
	}
	
	// 닉네임 중복을 확인하는 함수
	public int overlap(String id, String nick) {
		String SQL = "SELECT id FROM USER WHERE nickname = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(id)) { // 자신의 아이디와 닉네임이 겹쳐지는 경우
					return 1;
				}
				return 0; // 닉네임이 중복됨
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1; // 닉네임이 중복되지 않음
	}
}

