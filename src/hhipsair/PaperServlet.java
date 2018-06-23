package hhipsair;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class PaperServlet
 */
@WebServlet("/Paper")
public class PaperServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaperServlet() {
        super();
        // TODO Auto-generated constructor stub
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
		StringBuffer jb = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null)
				jb.append(line);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		if (jb.toString().length() < 500)
			System.out.println(jb.toString());

		try {
			JSONObject jsonObject = new JSONObject(jb.toString());
			
			if (jsonObject.has("isactive") == true) {
				System.out.println("PaperServlet - change paper isactive");
				doChangePaperIsactive(jsonObject.getInt("idpaper"), jsonObject.getInt("isactive"), response);
				return;
				
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		doGet(request, response);
	}

	private void doChangePaperIsactive(int idpaper, int isactive, HttpServletResponse response) {
		// TODO Auto-generated method stub
		DBProblemManagement dbm = new DBProblemManagement();
		dbm.updatePaperIsactive(idpaper, isactive);
		
		try {
			response.getWriter().append("{\"SUCCESS\":0}");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
