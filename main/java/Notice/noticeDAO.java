package Notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class noticeDAO {

	private Connection conn; //�ڹٿ� �����ͺ��̽��� ����
	private PreparedStatement pstmt; //������ ��� �� ����
	private ResultSet rs; //����� �޾ƿ���
	
	//�⺻ ������
	//UserDAO�� ����Ǹ� �ڵ����� �����Ǵ� �κ�
	//�޼ҵ帶�� �ݺ��Ǵ� �ڵ带 �̰��� ������ �ڵ尡 ����ȭ�ȴ�
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

	//�ۼ����� �޼ҵ�
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
			return ""; //�����ͺ��̽� ����
		}
		
		//�Խñ� ��ȣ �ο� �޼ҵ�
		public int getNext() {
			//���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�
			String sql = "select nID from notice order by nID desc";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) + 1;
				}
				return 1; //ù ��° �Խù��� ���
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //�����ͺ��̽� ����
		}
		
		//�۾��� �޼ҵ�	ID, Date, Title, Contents, Writer
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
			return -1; //�����ͺ��̽� ����
		}
	
		//�Խñ� ����Ʈ �޼ҵ�
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
		
		//����¡ ó�� �޼ҵ�
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
		

		//�ϳ��� �Խñ��� ���� �޼ҵ�
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
