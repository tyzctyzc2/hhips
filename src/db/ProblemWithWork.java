package db;

import java.util.Set;

public class ProblemWithWork extends Problem {
	@org.hibernate.annotations.OrderBy(clause = "idwork desc")
	private Set myWork;
	
	public Set getMyWork() {
		return myWork;
	}

	public void setMyWork(Set myWork) {
		this.myWork = myWork;
	}
	
	public String modulename;

	public String getModulename() {
		return modulename;
	}

	public void setModulename(String modulename) {
		this.modulename = modulename;
	}
}
