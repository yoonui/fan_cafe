package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class BoardDAO {
	// DAO : 데이터베이스 접근 객체의 약자
	
	private Connection conn; // 데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;
	
	// mysql 처리 부분
	public BoardDAO() { // 생성자가 실행될 때마다 자동으로 db연결이 이루어질 수 있도록 함
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
	
	// 현재의 시간을 가져오는 함수
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
			return ""; // 데이터베이스 오류
	}
	
	// bbsid 게시글 번호를 가져오는 함수
	public int getNext() {
		String SQL ="SELECT bbsid FROM board ORDER BY bbsid DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 글인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	// 글을 작성하는 함수
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
		return -1; // 데이터베이스 오류
	}
	
	// 데이터베이스에서 글 목록 가져오기. 리스트에 담아 반환.
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
	
	// 게시판에 따른 데이터베이스에서 글 목록 가져오기. 리스트에 담아 반환.
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
	
	// 각 게시판별 페이징 처리를 위한 boolean 함수 추가. 10 단위 페이징 처리를 위한 함수
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

	// 글 내용 불러오는 함수
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
	
	// 수정 함수
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
		
		return -1; // 데이터베이스 오류
	}
	
	// 삭제 함수
	public int delete(int bbsid) {
		String SQL = "DELETE FROM board WHERE bbsid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsid);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; // 데이터베이스 오류
	}

}

