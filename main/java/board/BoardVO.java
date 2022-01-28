package board;

import java.util.Date;

public class BoardVO {
	private int board_num;
	private String writer;
	private Date w_day;
	private String title;
	private String content;
	
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getW_day() {
		return w_day;
	}
	public void setW_day(Date w_day) {
		this.w_day = w_day;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	

}
