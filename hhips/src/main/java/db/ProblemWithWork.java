package db;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Set;

@Entity
@Table(name = "v_problem")
public class ProblemWithWork extends Problem {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6153152256230565269L;
	@org.hibernate.annotations.OrderBy(clause = "idwork desc")
	
	private Set myWork;
	
	public ProblemWithWork() {
		
	}
	
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
