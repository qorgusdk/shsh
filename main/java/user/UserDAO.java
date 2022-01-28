package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn; //�ڹٿ� �����ͺ��̽��� ����
	private PreparedStatement pstmt; //������ ��� �� ����
	private ResultSet rs; //����� �޾ƿ���
	
	//�⺻ ������
	//UserDAO�� ����Ǹ� �ڵ����� �����Ǵ� �κ�
	//�޼ҵ帶�� �ݺ��Ǵ� �ڵ带 �̰��� ������ �ڵ尡 ����ȭ�ȴ�
	public UserDAO() {
		try {
			String jdbcDriver = "jdbc:mysql://192.168.0.115:3306/KSH?" + "useUnicode=true&characterEncoding=utf8"; 
			String dbUser = "root"; String dbPass = "1234"; 
			// MySQL JDBC Driver Loading 
			Class.forName("com.mysql.jdbc.Driver"); 
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			System.out.println("tjdrhd");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	//�α��� ����
		public int login(String dbUser, String dbPass) {
			String sql = "select pw from users where id = ?";
			try {
				pstmt = conn.prepareStatement(sql); //sql�������� ��� ��Ų��
				pstmt.setString(1, dbUser); //ù��° '?'�� �Ű������� �޾ƿ� 'userID'�� ����
				rs = pstmt.executeQuery(); //������ ������ ����� rs�� ����
				if(rs.next()) {
					if(rs.getString(1).equals(dbPass)) {
						return 1; //�α��� ����
					}else
						return 0; //��й�ȣ Ʋ��
				}
				return -1; //���̵� ����
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -2; //����
		}


	//ȸ������ ����
		public int join(User user) {
			  String sql = "insert into users values(?, ?, ?)";
			  try {
			    pstmt = conn.prepareStatement(sql);
			    pstmt.setString(1, user.getUserId());
			    pstmt.setString(2, user.getUserPw());
			    pstmt.setString(3, user.getUserName());
			    return pstmt.executeUpdate();
			  }catch (Exception e) {
			 	e.printStackTrace();
			  }
			  return -1;
			}	
		
		
}


