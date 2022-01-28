package board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private CallableStatement cstmt;
	private ResultSet rs;
	
	private String driver = "com.mysql.cj.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/test?serverTimezone=UTC";
	private String id = "Test";
	private String pw = "Test1234";
	
	private int lastnum = 0;
	
	public BoardDAO(){
		DBconn();
	}
	
	public List<BoardVO> getList(){
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		try {
			String sql = "select * from board";
			
			con = DriverManager.getConnection(url, id, pw);
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				BoardVO b = new BoardVO();
				
				b.setBoard_num(rs.getInt(1));
				b.setWriter(rs.getString(2));
				b.setW_day(rs.getDate(3));
				
				String title = rs.getString(4);
				if(title.length() > 20) {
					String subt = title.substring(0, 20);
					title = subt.concat("...");
				}
				
				b.setTitle(title);
				b.setContent(rs.getString(5));
				list.add(b);
				
				lastnum += 1;
			}
			
			rs.close();
			stmt.close();
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<BoardVO> getList2(String start, String end){
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		try {
			String sql = "select * from board where w_day >= \'" + start + "\' and w_day <= \'" + end + "\'";
			
			con = DriverManager.getConnection(url, id, pw);
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				BoardVO b = new BoardVO();
				
				b.setBoard_num(rs.getInt(1));
				b.setWriter(rs.getString(2));
				b.setW_day(rs.getDate(3));
				
				String title = rs.getString(4);
				if(title.length() > 20) {
					String subt = title.substring(0, 20);
					title = subt.concat("...");
				}
				
				b.setTitle(title);
				b.setContent(rs.getString(5));
				list.add(b);
				
				lastnum += 1;
			}
			
			rs.close();
			stmt.close();
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	private void DBconn() {
		try {
			Class.forName(driver);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getLastnum() {
		return lastnum;
	}
	
	public int insertBoard(BoardVO vo) {
		
		int result = 0;
		
		try {
			String sql = "insert into board values(?,?,?,?,?)";
			con = DriverManager.getConnection(url, id, pw);
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, vo.getBoard_num());
			pstmt.setString(2, vo.getWriter());
			pstmt.setDate(3, new java.sql.Date(vo.getW_day().getTime()));
			pstmt.setString(4, vo.getTitle());
			pstmt.setString(5, vo.getContent());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if(result == 0) {
			try {
				String sql = "update board set title = ?, content = ?, w_day = ? where board_num = ?";
				con = DriverManager.getConnection(url, id, pw);
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getContent());
				pstmt.setDate(3, new java.sql.Date(vo.getW_day().getTime()));
				pstmt.setInt(4, vo.getBoard_num());
				
				result = pstmt.executeUpdate();
				
				pstmt.close();
				con.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	
	public BoardVO getBoard(String bn) {
		BoardVO vo = new BoardVO();
		
		try {
			String sql = "select * from board where board_num = " + bn;
			con = DriverManager.getConnection(url, id, pw);
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				vo.setBoard_num(rs.getInt(1));
				vo.setWriter(rs.getString(2));
				vo.setW_day(rs.getDate(3));
				vo.setTitle(rs.getString(4));
				vo.setContent(rs.getString(5));
			}
			
			con.close();
			stmt.close();
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public int deleteBoard(String bn) {
		int result = 0;
		
		try {
			String sql = "delete from board where board_num = " + bn;
			con = DriverManager.getConnection(url, id, pw);
			stmt = con.createStatement();
			
			result = stmt.executeUpdate(sql);
			
			sql = "{CALL decnum("+ bn +") }";
			cstmt = con.prepareCall(sql);
			cstmt.execute();
			
			
			con.close();
			stmt.close();
			cstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
