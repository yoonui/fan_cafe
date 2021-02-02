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
	
	// mysql�� ���� �ִ� �κ�
	public UserDAO() { // �����ڰ� ����� ������ �ڵ����� db������ �̷���� �� �ֵ��� ��
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
	
	// �α����� �õ��ϴ� �Լ�
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
	
	// �г����� �����ϴ� �Լ�
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
	
	// ȸ������
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
		return -1; //DB ����
	}
	
	// ����� ������ �ҷ����� �Լ�
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
	
	// ���� �Լ�
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
		
		return -1; // �����ͺ��̽� ����
	}
	
	// �г��� �ߺ��� Ȯ���ϴ� �Լ�
	public int overlap(String id, String nick) {
		String SQL = "SELECT id FROM USER WHERE nickname = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(id)) { // �ڽ��� ���̵�� �г����� �������� ���
					return 1;
				}
				return 0; // �г����� �ߺ���
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1; // �г����� �ߺ����� ����
	}
}

