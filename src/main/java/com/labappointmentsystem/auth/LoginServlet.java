package com.labappointmentsystem.auth;

import java.io.IOException;
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
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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
		response.sendRedirect("login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String emailAddress = request.getParameter("email_address");
		String password = request.getParameter("password");

		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();

		Map<String, String> fieldErrors = new HashMap<>();

		String emailError = ValidationUtils.isFieldRequired("email_address", emailAddress);
		if (emailError != null) {
			fieldErrors.put("email_address", emailError);
		} else {
			String emailError1 = ValidationUtils.isValidEmail("email_address", emailAddress);
			if (emailError1 != null) {
				fieldErrors.put("email_address", emailError1);
			}
		}

		String passwordError = ValidationUtils.isFieldRequired("password", password);
		if (passwordError != null) {
			fieldErrors.put("password", passwordError);
		} else {
			String passwordError1 = ValidationUtils.isLengthIsValid("password", password, 8);
			if (passwordError1 != null) {
				fieldErrors.put("password", passwordError1);
			}
		}

		if (fieldErrors.isEmpty()) {
			try {
				User user = UserDao.authenticateUser(emailAddress, password);
				if (user != null) {
					session.setAttribute("user-email", user.getEmail());
					session.setAttribute("user-name", user.getFirstName() + " " + user.getLastName());
					session.setAttribute("user-role", user.getRoleName());
					response.sendRedirect("dashboard.jsp");
				} else {
					fieldErrors.put("email_address", "These credentials do not match our records.");
					dispatcher = request.getRequestDispatcher("login.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			dispatcher = request.getRequestDispatcher("login.jsp");
		}

		if (dispatcher != null) {
			request.setAttribute("fieldErrors", fieldErrors);
			dispatcher.forward(request, response);
		} else {
			response.getWriter().write("Error: Unable to get the request dispatcher.");
		}
	}
}
