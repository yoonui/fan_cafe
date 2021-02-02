package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class BoardDAO {
	// DAO : �����ͺ��̽� ���� ��ü�� ����
	
	private Connection conn; // �����ͺ��̽��� �����ϰ� ���ִ� ��ü
	private ResultSet rs;
	
	// mysql ó�� �κ�
	public BoardDAO() { // �����ڰ� ����� ������ �ڵ����� db������ �̷���� �� �ֵ��� ��
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
	
	// ������ �ð��� �������� �Լ�
	public String getDate() {
			String SQL ="SELECT NOW()";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return ""; // �����ͺ��̽� ����
	}
	
	// bbsid �Խñ� ��ȣ�� �������� �Լ�
	public int getNext() {
		String SQL ="SELECT bbsid FROM board ORDER BY bbsid DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ù��° ���� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	// ���� �ۼ��ϴ� �Լ�
	public int write(String bbsTitle, String userid, String nickname, String bbsContent, String bdpost) {
		String SQL ="INSERT INTO board VALUES (?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userid);
			pstmt.setString(4, nickname);
			pstmt.setString(5, getDate());
			pstmt.setString(6, bbsContent);
			pstmt.setString(7, bdpost);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	// �����ͺ��̽����� �� ��� ��������. ����Ʈ�� ��� ��ȯ.
		public ArrayList<BOARD> getallList(int pageNumber){
			String SQL = "SELECT * FROM board WHERE bbsid < ? ORDER BY bbsid DESC LIMIT 10";
			ArrayList<BOARD> list = new ArrayList<BOARD>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext()-(pageNumber-1)*10);
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					BOARD bbs = new BOARD();
					
					bbs.setBbsid(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserid(rs.getString(3));
					bbs.setNickname(rs.getString(4));
					bbs.setBdDate(rs.getString(5));
					bbs.setBbsContent(rs.getString(6));
					bbs.setBdpost(rs.getString(7));
					
					list.add(bbs);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			return list;
		}
	
	// �Խ��ǿ� ���� �����ͺ��̽����� �� ��� ��������. ����Ʈ�� ��� ��ȯ.
	public ArrayList<BOARD> getList(int pageNumber, String bdpost){
		String SQL = "SELECT * FROM board WHERE bbsid < ? AND bdpost = ? ORDER BY bbsid DESC LIMIT 10";
		ArrayList<BOARD> list = new ArrayList<BOARD>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			pstmt.setString(2, bdpost);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BOARD bbs = new BOARD();
				
				bbs.setBbsid(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserid(rs.getString(3));
				bbs.setNickname(rs.getString(4));
				bbs.setBdDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBdpost(rs.getString(7));
				
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// �� �Խ��Ǻ� ����¡ ó���� ���� boolean �Լ� �߰�. 10 ���� ����¡ ó���� ���� �Լ�
	public boolean nextPage (int pageNumber, String bdpost) {
		String SQL = "SELECT * FROM board WHERE bbsid < ? AND bdpost = ? ORDER BY bbsid DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			pstmt.setString(2, bdpost);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean AllnextPage (int pageNumber) {
		String SQL = "SELECT * FROM board WHERE bbsid < ? ORDER BY bbsid DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 		
	}

	// �� ���� �ҷ����� �Լ�
	public BOARD getBbs (int bbsid) {
		String SQL = "SELECT * FROM board WHERE bbsid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BOARD bbs = new BOARD();
				
				bbs.setBbsid(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserid(rs.getString(3));
				bbs.setNickname(rs.getString(4));
				bbs.setBdDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBdpost(rs.getString(7));
				
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// ���� �Լ�
	public int update(int bbsid, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE board SET bbsTitle = ?, bbsContent = ? WHERE bbsid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsid);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; // �����ͺ��̽� ����
	}
	
	// ���� �Լ�
	public int delete(int bbsid) {
		String SQL = "DELETE FROM board WHERE bbsid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsid);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; // �����ͺ��̽� ����
	}

}

