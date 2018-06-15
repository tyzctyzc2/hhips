package hhipsair;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Writer;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freemarker.core.ParseException;
import freemarker.template.Configuration;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;

/**
 * Servlet implementation class ProblemPusher
 */
@WebServlet("/Problem")
public class ProblemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Configuration configuration = null;
	private static boolean initFlag = false;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProblemServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("chapterid") != null) {
			int chapterID = 0;
			try {
				chapterID = Integer.parseInt(request.getParameter("chapterid"));
			} catch (Exception e) {
				chapterID = 1;
			}
			System.out.println("create new problem in chapter " + Integer.toString(chapterID));
			getNewProblmCase(response, chapterID);
			return;
		} else if (request.getParameter("problemid") != null) {
			int problemID = 0;
			try {
				problemID = Integer.parseInt(request.getParameter("problemid"));
			} catch (Exception e) {
				response.getWriter().append("wrong problem ID " + request.getParameter("problemid"));
				return;
			}
			System.out.println("get problem detail " + Integer.toString(problemID));
			getProblemDetailCase(response, problemID);
			return;
		} else if (request.getParameter("active") != null) {
			int activeLevel = 0;
			try {
				activeLevel = Integer.parseInt(request.getParameter("active"));
			} catch (Exception e) {
				response.getWriter().append("wrong active Level  " + request.getParameter("active"));
				return;
			}
			getProblemNextActive(response, activeLevel);
		} else if (request.getParameter("paperid") != null) {
			String paperID = request.getParameter("paperid");
			String showAnswer = request.getParameter("showanswer");
			int showA = 0;
			if (showAnswer != null)
				showA = 1;
			if (paperID.indexOf("-1") >-1)
				getPaperList(response);
			else
				getPaperProblemList(response, request.getParameter("paperid"), showA);
		} else {
			response.getWriter().append("don't know how to process your request!");
		}
	}

	private void getPaperList(HttpServletResponse response) {
		try {
			Template t = configuration.getTemplate("paperlist.ftl");
			response.setContentType("text/html; charset=" + t.getEncoding());
			Writer out = response.getWriter();
			Map<String, Object> root = PageMaker.preparePaperList();

			t.process(root, out);
		} catch (Exception e) {
			System.out.println(e.toString());
			try {
				response.getWriter().append(e.toString());
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println(e1.toString());
			}
		}
	}

	private void getPaperProblemList(HttpServletResponse response, String paperParameter, int showAnswer) {
		try {
			Template t = configuration.getTemplate("paperproblemlist.ftl");
			response.setContentType("text/html; charset=" + t.getEncoding());
			Writer out = response.getWriter();
			Map<String, Object> root = PageMaker.preparePaperProblemList(paperParameter);
			
			root.put("showAnswer", showAnswer);
			
			t.process(root, out);
		} catch (Exception e) {
			System.out.println(e.toString());
			try {
				response.getWriter().append(e.toString());
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println(e1.toString());
			}
		}
	}

	private void getProblemNextActive(HttpServletResponse response, int activeLevel) throws IOException {
		DBProblem dbProblem = new DBProblem();
		String pp = dbProblem.getNextActiveProblem();
		response.getWriter().append(pp);
	}

	private void getProblemDetailCase(HttpServletResponse response, int problemID) throws TemplateNotFoundException,
			MalformedTemplateNameException, ParseException, IOException, ServletException {
		Template t = configuration.getTemplate("problemdetail.ftl");
		response.setContentType("text/html; charset=" + t.getEncoding());
		Writer out = response.getWriter();
		Map<String, Object> root = PageMaker.prepareProblemDetail(problemID);

		// Merge the data-model and the template
		try {
			t.process(root, out);
		} catch (TemplateException e) {
			throw new ServletException("Error while processing FreeMarker template", e);
		}
	}

	private void getNewProblmCase(HttpServletResponse response, int chapterID) throws TemplateNotFoundException,
			MalformedTemplateNameException, ParseException, IOException, ServletException {

		Template t = configuration.getTemplate("newproblem.ftl");
		response.setContentType("text/html; charset=" + t.getEncoding());
		Writer out = response.getWriter();
		Map<String, Object> root = PageMaker.prepareNewProblemData(chapterID);

		// Merge the data-model and the template
		try {
			t.process(root, out);
		} catch (TemplateException e) {
			throw new ServletException("Error while processing FreeMarker template", e);
		}
	}

	public void init() {
		if (initFlag == true)
			return;

		ServletContext context = getServletContext();
		String fullPath = context.getRealPath("/201804");
		FileHelper.absolutePath = fullPath.substring(0, fullPath.length() - 6);
		System.out.println("DBProblem absolutePath set to [" + FileHelper.absolutePath + "]");

		if (null == configuration) {
			configuration = new Configuration();
			configuration.setServletContextForTemplateLoading(getServletContext(), "WEB-INF/templates");
			configuration.setEncoding(Locale.CHINA, "utf-8");
		}
		initFlag = true;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		
		String activeLevel = request.getParameter("active");
		if (activeLevel != null) {
			System.out.println("active request");
			String problemIDString = request.getParameter("problemid");
			String paperIDString = request.getParameter("paperid");
			doActiveProblem(response, Integer.parseInt(problemIDString), Integer.parseInt(activeLevel), Integer.parseInt(paperIDString));
			return;
		}
		
		String problemstatus = request.getParameter("problemstatus");
		if (problemstatus != null) {
			System.out.println("change problem status");
			String problemid = request.getParameter("problemid");
			String paperproblemid = request.getParameter("paperproblemid");
			doChangeProblemStatus(response, Integer.parseInt(problemid), Integer.parseInt(paperproblemid), Integer.parseInt(problemstatus));
			return;
		}
		
		String deleteProblemID = request.getParameter("delete");
		if (deleteProblemID != null) {
			System.out.println("delete request");
			int problemID = Integer.parseInt(deleteProblemID);
			DBProblem dbProblem = new DBProblem();
			dbProblem.deleteProblem(problemID);
			response.getWriter().append("1");
			return;
		}

		DBProblem dbProblem = new DBProblem();

		if (dbProblem.PushProblem(jb.toString()) == false) {
			response.getWriter().append("Save failed at: ").append(request.getContextPath());
		}

		response.getWriter().append("Save at: ").append(request.getContextPath());
	}

	private void doChangeProblemStatus(HttpServletResponse response, int problemid, int paperproblemid, int problemstatus) throws IOException {

		DBProblemManagement dbProblemManagement = new DBProblemManagement();
		if (dbProblemManagement.ChangeProblemPaperStatus(problemid, paperproblemid, problemstatus) == false) {
			try {
				response.getWriter().append("-1");
				return;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		response.getWriter().append("0");
	}

	private void doActiveProblem(HttpServletResponse response, int problemID, int activeLevel, int paperID) throws IOException {
		DBProblemManagement dbProblemManagement = new DBProblemManagement();
		dbProblemManagement.createPaperProblem(problemID, paperID);
		response.getWriter().append("1");
	}

}
