package kr.or.ddit.user.vo;

public class PageVo {
	private int page;
	private int pageSize;
	private String userid;
	private String usernm;
	private String alias;
	
	public PageVo() {
		
	}
	
	public PageVo(int page,int pageSize) {
		this.page = page;
		this.pageSize = pageSize;
	}
	
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsernm() {
		return usernm;
	}

	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	@Override
	public String toString() {
		return "PageVo [page=" + page + ", pageSize=" + pageSize + ", userid=" + userid + ", usernm=" + usernm
				+ ", alias=" + alias + "]";
	}
	

	
	
}
