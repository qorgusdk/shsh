package faulty;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dbconn.DBconn;

public class FaultyDAO {
	
	private DBconn db;

	private Statement stmt;
	private PreparedStatement pstmt;
	private CallableStatement cstmt;
	private ResultSet rs;
	private Connection con;
	
	public FaultyDAO() {
		DBconn();
	}
	
	private String driver = "com.mysql.cj.jdbc.Driver";
	private String url = "jdbc:mysql://192.168.0.115:3306/mes?" + "useUnicode=true&characterEncoding=utf8"; 
	private String id = "Usera";
	private String pw = "1234";
	
	private void DBconn() {
		try {
			Class.forName(driver);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//불량 리스트 출력 
	public List<Faulty> getList(){
		List<Faulty> list = new ArrayList<Faulty>();
		
		try {
			String sql = "select * from faulty";
			
			con = DriverManager.getConnection(url, id, pw);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Faulty b = new Faulty();
				
				b.setFaulty_no(rs.getInt("faulty_no"));
				b.setLink_info(rs.getString("link_info"));
				b.setFaulty_type(rs.getString("faulty_type"));
				b.setCause_of_defect(rs.getString("cause_of_defect"));
				b.setDate_of_occurrence(rs.getString("date_of_occurrence"));
				b.setMaterials_cost(rs.getInt("materials_cost"));
				b.setCost(rs.getInt("cost"));
				b.setFaulty_title(rs.getString("faulty_title"));
				b.setFaulty_content(rs.getString("faulty_content"));
				b.setSolution(rs.getString("solution"));
				b.setUser_id(rs.getString("user_id"));
				b.setProc_date(rs.getString("proc_date"));
				b.setPart_name(rs.getString("part_name"));
				b.setProcess(rs.getString("process"));
				
				list.add(b);
			}
			
			rs.close();
			pstmt.close();
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//불량 읽어오기
		public Faulty getBoard(String bn) {
			Faulty vo = new Faulty();
			
			try {
				String sql = "select * from faulty where faulty_no = " + bn;
				con = db.getCon();
				stmt = con.createStatement();
				
				rs = stmt.executeQuery(sql);
				while(rs.next()) {
					vo.setFaulty_no(rs.getInt("faulty_no"));
					vo.setLink_info(rs.getString("link_info"));
					vo.setFaulty_type(rs.getString("faulty_type"));
					vo.setCause_of_defect(rs.getString("cause_of_defect"));
					vo.setDate_of_occurrence(rs.getString("date_of_occurrence"));
					vo.setMaterials_cost(rs.getInt("materials_cost"));
					vo.setCost(rs.getInt("cost"));
					vo.setFaulty_title(rs.getString("faulty_title"));
					vo.setFaulty_content(rs.getString("faulty_content"));
					vo.setSolution(rs.getString("solution"));
					vo.setUser_id(rs.getString("user_id"));
					vo.setProc_date(rs.getString("proc_date"));
					vo.setPart_name(rs.getString("part_name"));
					vo.setProcess(rs.getString("process"));
				}
				
				con.close();
				stmt.close();
				rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return vo;
		}
	
}
