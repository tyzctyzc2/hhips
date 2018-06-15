package hhipsair;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Writer;
//import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletConfig;
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
 * Servlet implementation class ChapterServlet
 */
@WebServlet("/Chapter")
public class ChapterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Configuration configuration = null;
	private static boolean initFlag = false;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChapterServlet() {
		super();
		// TODO Auto-generated constructor stub

	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void init() {
		if (initFlag == true)
			return;

		ServletContext context = getServletContext();
		String fullPath = context.getRealPath("/201804");
		FileHelper.absolutePath = fullPath.substring(0, fullPath.length() - 6);
		System.out.println("DBProblem absolutePath set to [[[[[[[[" + FileHelper.absolutePath + "]]]]]]");

		if (null == configuration) {
			configuration = new Configuration();
			configuration.setServletContextForTemplateLoading(getServletContext(), "WEB-INF/templates");
			configuration.setEncoding(Locale.CHINA, "utf-8");
		}
		initFlag = true;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		init();
		if (request.getParameter("chapterid") != null) {
			getChapterProblems(response, request.getParameter("chapterid"));
			return;
		} else if (request.getParameter("sourceid") != null) {
			getChapterList(response, request.getParameter("sourceid"));
			return;
		} else {
			response.getWriter().append("don't know how to process your request!");
		}
	}

	private void getChapterList(HttpServletResponse response, String sourceIDString)
			throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException, ServletException {

		System.out.println(sourceIDString);
		int sourceID = 0;
		try {
			sourceIDString = sourceIDString.replace(",", "");
			sourceID = Integer.parseInt(sourceIDString);
		} catch (Exception e) {
			sourceID = 1;
		}

		Template t = configuration.getTemplate("chapterlist.ftl");
		response.setContentType("text/html; charset=" + t.getEncoding());
		Writer out = response.getWriter();
		Map<String, Object> root = PageMaker.prepareChapterList(sourceID);

		// Merge the data-model and the template
		try {
			t.process(root, out);
		} catch (TemplateException e) {
			throw new ServletException("Error while processing FreeMarker template", e);
		}
	}

	private void getChapterProblems(HttpServletResponse response, String chapterIDString)
			throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException,
			ServletException {
		int chapterID = 0;
		try {
			chapterID = Integer.parseInt(chapterIDString);
		} catch (Exception e) {
			chapterID = 1;
		}

		Template t = configuration.getTemplate("chapterview.ftl");
		response.setContentType("text/html; charset=" + t.getEncoding());
		Writer out = response.getWriter();
		Map<String, Object> root = PageMaker.prepareChapterProblems(chapterID);

		// Merge the data-model and the template
		try {
			t.process(root, out);
		} catch (TemplateException e) {
			throw new ServletException("Error while processing FreeMarker template", e);
		}
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
		
		DBProblemManagement dbChapter = new DBProblemManagement();

		if (dbChapter.createNewChapter(jb.toString()) == 0) {
			response.getWriter().append("Save failed at: ").append(request.getContextPath());
		}

		response.getWriter().append("{\"success\":true}");
	}

}
