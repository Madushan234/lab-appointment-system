package com.labappointmentsystem.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.labappointmentsystem.dao.MedicalTestRecordDao;

/**
 * Servlet implementation class ReportServlet
 */
@WebServlet("/download-report")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    int recordId = Integer.parseInt(request.getParameter("recordId"));
        byte[] pdfBytes = MedicalTestRecordDao.getReportFromDatabase(recordId); 

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"report.pdf\"");

        try (ServletOutputStream out = response.getOutputStream()) {
            out.write(pdfBytes);
            out.flush();
        }
	}

}
