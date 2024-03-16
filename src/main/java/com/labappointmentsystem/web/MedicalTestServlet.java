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

import com.labappointmentsystem.dao.MedicalTestDao;
import com.labappointmentsystem.model.MedicalTest;
import com.labappointmentsystem.util.ValidationUtils;

/**
 * Servlet implementation class MedicalTestServlet
 */
@WebServlet("/backend-medical-test/medical-test")
public class MedicalTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MedicalTestServlet() {
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
		response.sendRedirect("backend-medical-test/index.jsp");
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
		MedicalTest medicalTest = null;

		Enumeration<String> parameterNames = request.getParameterNames();
		Map<String, String> createMedicalTestFileds = new HashMap<>();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			createMedicalTestFileds.put(paramName, paramValue);
		}
		session.setAttribute("createMedicalTestFileds", createMedicalTestFileds);

		String formAction = request.getParameter("action");
		String medical_test_id = request.getParameter("medical_test_id");
		String medical_test_name = request.getParameter("medical_test_name");
		String medical_test_description = request.getParameter("medical_test_description");
		String medical_test_normal_record_data = request.getParameter("medical_test_normal_record_data");

		String medical_test_amount_param = request.getParameter("medical_test_amount");
		double medical_test_amount = 0;
		if (medical_test_amount_param != null && !medical_test_amount_param.isEmpty()) {
			medical_test_amount = Double.parseDouble(medical_test_amount_param);
		}
		String medical_test_processing_time_param = request.getParameter("medical_test_processing_time");
		double medical_test_processing_time = 0;
		if (medical_test_processing_time_param != null && !medical_test_processing_time_param.isEmpty()) {
			medical_test_processing_time = Double.parseDouble(medical_test_processing_time_param);
		}

		String error = ValidationUtils.isFieldRequired("medical_test_name", medical_test_name);
		if (error != null) {
			fieldErrors.put("medical_test_name", error);
		}

		String error1 = ValidationUtils.isFieldRequired("medical_test_description", medical_test_description);
		if (error1 != null) {
			fieldErrors.put("medical_test_description", error1);
		}

		String error2 = ValidationUtils.isFieldRequired("medical_test_normal_record_data",
				medical_test_normal_record_data);
		if (error2 != null) {
			fieldErrors.put("medical_test_normal_record_data", error2);
		}

		String error4 = ValidationUtils.isFieldRequired("medical_test_amount", medical_test_amount_param);
		if (error4 != null) {
			fieldErrors.put("medical_test_amount", error4);
		}

		String error5 = ValidationUtils.isFieldRequired("medical_test_processing_time",
				medical_test_processing_time_param);
		if (error5 != null) {
			fieldErrors.put("medical_test_processing_time", error5);
		}

		if (fieldErrors.isEmpty()) {
			try {
				if (formAction.equals("create")) {
					medicalTest = MedicalTestDao.createMedicalTest(medical_test_name, medical_test_description,
							medical_test_normal_record_data, medical_test_amount, medical_test_processing_time);

				} else {
					medicalTest = MedicalTestDao.updateMedicalTest(medical_test_id, medical_test_name,
							medical_test_description, medical_test_normal_record_data, medical_test_amount,
							medical_test_processing_time);

				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (medicalTest == null) {
			fieldErrors.put("common", "Something went wrong. please try again later.");
			session.setAttribute("fieldErrors", fieldErrors);
		} else {
			if (formAction.equals("create")) {
				session.setAttribute("medical-test-create-status", "Medical test created successfully.");
			} else {
				session.setAttribute("medical-test-create-status", "Medical test updated successfully.");
			}
		}
		if (formAction.equals("create")) {
			response.sendRedirect("create.jsp");
		} else {
			response.sendRedirect("create.jsp?medical-test=" + medical_test_id);
		}
	}

}
