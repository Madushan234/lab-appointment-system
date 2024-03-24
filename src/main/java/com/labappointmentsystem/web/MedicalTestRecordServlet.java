package com.labappointmentsystem.web;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.labappointmentsystem.dao.MedicalTestRecordDao;
import com.labappointmentsystem.dao.UserDao;
import com.labappointmentsystem.model.MedicalTestRecord;
import com.labappointmentsystem.model.User;
import com.labappointmentsystem.util.ValidationUtils;

/**
 * Servlet implementation class MedicalTestRecordServlet
 */
@WebServlet("/backend-appointment/update-test-record")
public class MedicalTestRecordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MedicalTestRecordServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Map<String, String> fieldErrors = new HashMap<>();
		MedicalTestRecord medicalTestRecord = null;

		Enumeration<String> parameterNames = request.getParameterNames();
		Map<String, String> inputFiledsData = new HashMap<>();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			inputFiledsData.put(paramName, paramValue);
		}
		session.setAttribute("inputFiledsData", inputFiledsData);

		String test_record_id = request.getParameter("test_record_id");
		String test_result = request.getParameter("test_result");
		String test_status = request.getParameter("test_status");
		String email_address = (String) session.getAttribute("user-email");

		String error = ValidationUtils.isFieldRequired("test_result", test_result);
		if (error != null) {
			fieldErrors.put("test_result", error);
		}

		String error1 = ValidationUtils.isFieldRequired("test_status", test_status);
		if (error1 != null) {
			fieldErrors.put("test_status", error1);
		}

		String error2 = ValidationUtils.isFieldRequired("test_status", test_record_id);
		if (error1 != null) {
			fieldErrors.put("common", "Something went wrong. please try again later.");
		}

		if (fieldErrors.isEmpty()) {
			try {
				User userData = UserDao.findUserByEmail(email_address);
				if (userData != null) {
					String technician_id = String.valueOf(userData.getId());
					medicalTestRecord = MedicalTestRecordDao.updateTestReord(test_record_id, test_result, test_status,
							technician_id);
				} else {
					fieldErrors.put("common", "Something went wrong. please try again later.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (medicalTestRecord == null) {
			fieldErrors.put("common", "Something went wrong. please try again later.");
			session.setAttribute("fieldErrors", fieldErrors);
		} else {
			session.setAttribute("record-status", "Medical test record updated successfully.");
		}
		response.sendRedirect("medical-test-details.jsp?medical-test-record=" + test_record_id);
	}
}
