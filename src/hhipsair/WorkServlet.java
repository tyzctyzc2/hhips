package hhipsair;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Work.WorkColumnName;
import freemarker.template.Configuration;

/**
 * Servlet implementation class WorkServlet
 */
@WebServlet("/Work")
public class WorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Configuration configuration = null;
	private static boolean initFlag = false;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WorkServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	public void init() {
		if (initFlag == true)
			return;
		
		ServletContext context = getServletContext();
		String fullPath = context.getRealPath("/201804");
		FileHelper.absolutePath = fullPath.substring(0, fullPath.length()-6);
		System.out.println("DBProblem absolutePath set to [[[[[[[["+FileHelper.absolutePath+"]]]]]]");
		
		if (null == configuration) {
			configuration = new Configuration();
			configuration.setServletContextForTemplateLoading(getServletContext(), "WEB-INF/templates");
			configuration.setEncoding(Locale.CHINA, "utf-8");
		}
		initFlag = true;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("idwork") != null) {
			System.out.println("get mark request");
			
			 DBWork dbWork = new DBWork();
			 if (dbWork.updateWorkMark(Integer.parseInt(request.getParameter("idwork")), Integer.parseInt(request.getParameter("workmark")))==true)
				 response.getWriter().append("{\"Success\":1} ");
			else
				response.getWriter().append("{\"Success\":0} ");
			return;
		}
		System.out.println("get save request");
		StringBuffer jb = new StringBuffer();
		  String line = null;
		  try {
		    BufferedReader reader = request.getReader();
		    while ((line = reader.readLine()) != null)
		      jb.append(line);
		  } catch (Exception e) { 
			  System.out.println(e.toString());
		  }
		  
		  System.out.println(jb.toString());
		  
		  DBWork dbWork = new DBWork();

		  int workID = dbWork.PushWork(jb.toString());
		if (workID == 0) {
			response.getWriter().append("Save work failed at: ").append(request.getContextPath());
			return;
		}
		
		DBProblemManagement dbm = new DBProblemManagement();
		dbm.UpdatePaperProblemAfterWork(workID, jb.toString());
		
		response.getWriter().append("Save work at: ").append(request.getContextPath());
	}

}
