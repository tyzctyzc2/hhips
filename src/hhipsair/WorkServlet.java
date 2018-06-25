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

import org.json.JSONException;
import org.json.JSONObject;

import freemarker.template.Configuration;

/**
 * Servlet implementation class WorkServlet
 */
@WebServlet({"/Work","/Work/Mark"})
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
	
	void processMarkWork(String requestJSON, HttpServletResponse response) {
		System.out.println(requestJSON);
		JSONObject jsonObject;
		int idwork = 0;
		int workmark = -1;
		try {
			jsonObject = new JSONObject(requestJSON);
			idwork = jsonObject.getInt("idwork");
			workmark = jsonObject.getInt("workmark");

			DBProblemManagement dbm = new DBProblemManagement();
			if (workmark == 1) {//wrong case
				dbm.ChangeProblemPaperStatus(jsonObject.getInt("idproblem"), jsonObject.getInt("paperproblemid"), 1);
			}
			else if (workmark == 0) {//correct case
				dbm.ChangeProblemPaperStatus(jsonObject.getInt("idproblem"), jsonObject.getInt("paperproblemid"), 3);
			}
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		 DBWork dbWork = new DBWork();
		 if (dbWork.updateWorkMark(idwork, workmark)==true)
			try {
				response.getWriter().append("{\"Success\":1} ");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		else
			try {
				response.getWriter().append("{\"Success\":0} ");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("get work change request");
			
		StringBuffer jb = new StringBuffer();
		  String line = null;
		  try {
		    BufferedReader reader = request.getReader();
		    while ((line = reader.readLine()) != null)
		      jb.append(line);
		  } catch (Exception e) { 
			  System.out.println(e.toString());
		  }
		  
		  if (jb.toString().length() == 0) {
			  System.out.println("WorkServlet - empty new work!!!");
			  response.getWriter().append("WorkServlet - empty new work!!!");
			  return;
		  }

		  if (jb.toString().indexOf("idwork") > 0) {
			  System.out.println("WorkServlet - mark a work request");
			  processMarkWork(jb.toString(), response);
			  return;
		  }
		  System.out.println("WorkServlet - save a new work request");
		  DBWork dbWork = new DBWork();

		  int workID = dbWork.PushWork(jb.toString());
		if (workID == 0) {
			System.out.println("WorkServlet - Save work failed");
			response.getWriter().append("Save work failed at: ").append(request.getContextPath());
			return;
		}
		
		DBProblemManagement dbm = new DBProblemManagement();
		dbm.UpdatePaperProblemAfterWork(workID, jb.toString());
		
		response.getWriter().append("Save work at: ").append(request.getContextPath());
	}

}
