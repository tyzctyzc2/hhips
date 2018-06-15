package hhipsair;

import java.io.IOException;
import java.io.Writer;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * Servlet implementation class SourceServlet
 */
@WebServlet("/Source")
public class SourceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Configuration configuration = null;
	private static boolean initFlag = false;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SourceServlet() {
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		init();
		Template t = configuration.getTemplate("source.ftl");
		response.setContentType("text/html; charset=" + t.getEncoding());
		Writer out = response.getWriter();
		Map<String, Object> root = PageMaker.prepareSourceList();

		// Merge the data-model and the template
		try {
			t.process(root, out);
		} catch (TemplateException e) {
			throw new ServletException("Error while processing FreeMarker template", e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
