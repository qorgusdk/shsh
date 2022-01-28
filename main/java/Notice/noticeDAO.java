package Notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class noticeDAO {

	private Connection conn; //자바와 데이터베이스를 연결
	private PreparedStatement pstmt; //쿼리문 대기 및 설정
	private ResultSet rs; //결과값 받아오기
	
	//기본 생성자
	//UserDAO가 실행되면 자동으로 생성되는 부분
	//메소드마다 반복되는 코드를 이곳에 넣으면 코드가 간소화된다
	public noticeDAO() {
		try {
			String jdbcDriver = "jdbc:mysql://localhost:3306/KSH?" + "useUnicode=true&characterEncoding=utf8"; 
			String dbUser = "root"; String dbPass = "12341234"; 
			// MySQL JDBC Driver Loading 
			Class.forName("com.mysql.jdbc.Driver"); 
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	//작성일자 메소드
		public String getDate() {
			String sql = "select now()";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return ""; //데이터베이스 오류
		}
		
		//게시글 번호 부여 메소드
		public int getNext() {
			//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
			String sql = "select nID from notice order by nID desc";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) + 1;
				}
				return 1; //첫 번째 게시물인 경우
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
		
		//글쓰기 메소드	ID, Date, Title, Contents, Writer
		public int write(String noticeTitle, String userId, String noticeContents) {
			String sql = "insert into notice values(?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext());
				pstmt.setString(2, getDate());
				pstmt.setString(3, noticeTitle);
				pstmt.setString(4, noticeContents);
				pstmt.setString(5, userId);
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
	
		//게시글 리스트 메소드
		public ArrayList<notice> getList(int pageNumber){
			String sql = "select * from notice where nID < ? order by nID desc limit 10";
			ArrayList<notice> list = new ArrayList<notice>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					notice Notice = new notice();
					Notice.setNoticeId(rs.getInt(1));
					Notice.setNoticeDate(rs.getString(2));
					Notice.setNoticeTitle(rs.getString(3));
					Notice.setNoticeContents(rs.getString(4));
					Notice.setNoticeWriter(rs.getString(5));
					list.add(Notice);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}
		
		//페이징 처리 메소드
		public boolean nextPage(int pageNumber) {
			String sql = "select * from notice where nID < ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		

		//하나의 게시글을 보는 메소드
		public notice getNotice(int nID) {
			String sql = "select * from notice where nID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, nID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					notice Notice = new notice();
					Notice.setNoticeId(rs.getInt(1));
					Notice.setNoticeDate(rs.getString(2));
					Notice.setNoticeTitle(rs.getString(3));
					Notice.setNoticeContents(rs.getString(4));
					Notice.setNoticeWriter(rs.getString(5));
					return Notice;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	
}
