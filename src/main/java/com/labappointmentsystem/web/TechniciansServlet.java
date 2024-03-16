package com.labappointmentsystem.web;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.labappointmentsystem.dao.UserDao;
import com.labappointmentsystem.model.User;
import com.labappointmentsystem.util.ValidationUtils;

/**
 * Servlet implementation class TechniciansServlet
 */
@WebServlet("/backend-technicians/technicians")
public class TechniciansServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TechniciansServlet() {
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
		response.sendRedirect("backend-technicians/index.jsp");
		// String path = request.getServletPath();
		// String action = request.getPathInfo();
		// System.out.println(action);
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
		User user = null;

		Enumeration<String> parameterNames = request.getParameterNames();
		Map<String, String> createTechniciansFileds = new HashMap<>();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			createTechniciansFileds.put(paramName, paramValue);
		}
		session.setAttribute("createTechniciansFields", createTechniciansFileds);

		String formAction = request.getParameter("action");
		String first_name = request.getParameter("first_name");
		String last_name = request.getParameter("last_name");
		String email_address = request.getParameter("email_address");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");
		String telephone_number = request.getParameter("telephone_number");
		String nic = request.getParameter("nic");
		String date_of_birth = request.getParameter("date_of_birth");

		String firstNameError = ValidationUtils.isFieldRequired("first_name", first_name);
		if (firstNameError != null) {
			fieldErrors.put("first_name", firstNameError);
		}

		String lastNameError = ValidationUtils.isFieldRequired("first_name", last_name);
		if (lastNameError != null) {
			fieldErrors.put("last_name", lastNameError);
		}

		String emailError = ValidationUtils.isFieldRequired("email_address", email_address);
		if (emailError != null) {
			fieldErrors.put("email_address", emailError);
		} else {
			String emailError1 = ValidationUtils.isValidEmail("email_address", email_address);
			if (emailError1 != null) {
				fieldErrors.put("email_address", emailError1);
			}
		}
		
		if (formAction.equals("create")) {
			String passwordError = ValidationUtils.isFieldRequired("password", password);
			if (passwordError != null) {
				fieldErrors.put("password", passwordError);
			} else {
				String passwordError1 = ValidationUtils.isLengthIsValid("password", password, 8);
				if (passwordError1 != null) {
					fieldErrors.put("password", passwordError1);
				}
			}

			String confirmPasswordError = ValidationUtils.isFieldRequired("confirm_password", confirm_password);
			if (confirmPasswordError != null) {
				fieldErrors.put("confirm_password", confirmPasswordError);
			} else {
				String confirmPasswordError1 = ValidationUtils.isLengthIsValid("confirm_password", confirm_password, 8);
				if (confirmPasswordError1 != null) {
					fieldErrors.put("confirm_password", confirmPasswordError1);
				}
			}
		}

		String telError = ValidationUtils.isFieldRequired("telephone_number", telephone_number);
		if (telError != null) {
			fieldErrors.put("telephone_number", telError);
		}

		String nicError = ValidationUtils.isFieldRequired("nic", nic);
		if (nicError != null) {
			fieldErrors.put("nic", nicError);
		}

		String dobError = ValidationUtils.isFieldRequired("date_of_birth", date_of_birth);
		if (dobError != null) {
			fieldErrors.put("date_of_birth", dobError);
		}

		if (fieldErrors.isEmpty()) {
			try {
				User userData = UserDao.findUserByEmail(email_address);
				if (formAction.equals("create")) {
					if (userData == null) {
						user = UserDao.createTechnicians(first_name, last_name, email_address, password,
								confirm_password, telephone_number, nic, date_of_birth, "technician");
					} else {
						fieldErrors.put("email_address", "This email is already used.");
					}
				} else {
					if (userData != null) {
						user = UserDao.updateUserByEmail(first_name, last_name, email_address, telephone_number, nic,
								date_of_birth);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (user == null) {
			fieldErrors.put("common", "Something went wrong. please try again later.");
			session.setAttribute("fieldErrors", fieldErrors);
		} else {
			if (formAction.equals("create")) {
				session.setAttribute("technician-create-status", "Technician created successfully.");
			}else {
				session.setAttribute("technician-create-status", "Technician updated successfully.");
			}
		}
		if (formAction.equals("create")) {
			response.sendRedirect("create.jsp");
		}else {
			response.sendRedirect("create.jsp?email-address="+email_address);
		}
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
