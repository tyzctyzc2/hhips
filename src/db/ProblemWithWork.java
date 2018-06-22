package db;

import java.util.Set;

public class ProblemWithWork extends Problem {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6153152256230565269L;
	@org.hibernate.annotations.OrderBy(clause = "idwork desc")
	
	private Set myWork;
	
	public ProblemWithWork() {
		
	}
	
	public ProblemWithWork(Set _work, String _modulename, 
			Module _module, SourceChapter _sourcechapter, Integer _problemlevel, String _problemdetail,
			String _problemindex, Integer _problemcisactive, String _problemanswerstring, String _problemanswerdetail) {
		super(_module, _sourcechapter, _problemlevel, _problemdetail,_problemindex,
				_problemcisactive,  _problemanswerstring,  _problemanswerdetail);
		
		this.myWork = _work;
		this.modulename = _modulename;
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
