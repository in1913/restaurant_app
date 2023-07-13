package myRest;

public class ReviewDTO {
	private int rnum;
	private int unum;
	private int star;
	private String content;
	private String writeday;
	private String writeip;
	
	public ReviewDTO() {}
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteip() {
		return writeip;
	}
	public void setWriteip(String writeip) {
		this.writeip = writeip;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
	
}
