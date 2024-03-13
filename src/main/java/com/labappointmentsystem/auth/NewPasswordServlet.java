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
import com.labappointmentsystem.util.ValidationUtils;

/**
 * Servlet implementation class NewPasswordServlet
 */
@WebServlet("/new-password")
public class NewPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String emailAddress = (String) session.getAttribute("forgot-password-email");
		String otp = request.getParameter("otp");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirm_password");

		RequestDispatcher dispatcher = null;

		Map<String, String> fieldErrors = new HashMap<>();

		String otpError = ValidationUtils.isFieldRequired("otp", otp);
		if (otpError != null) {
			fieldErrors.put("otp", otpError);
		} else {
			String otpError1 = ValidationUtils.isLengthIsValid("otp", otp, 6);
			if (otpError1 != null) {
				fieldErrors.put("otp", otpError1);
			}
		}

		String passwordError = ValidationUtils.isFieldRequired("password", password);
		if (passwordError != null) {
			fieldErrors.put("password", passwordError);
		} else {
			String passwordError1 = ValidationUtils.isLengthIsValid("password", password, 8);
			if (passwordError1 != null) {
				fieldErrors.put("password", passwordError1);
			}else {
				if (!password.equals(confirmPassword)) {
					fieldErrors.put("password", "The password and confirm password does not match");
				}
			}
		}

		String confirmPasswordError = ValidationUtils.isFieldRequired("confirm_password", confirmPassword);
		if (confirmPasswordError != null) {
			fieldErrors.put("confirm_password", confirmPasswordError);
		} else {
			String confirmPasswordError1 = ValidationUtils.isLengthIsValid("confirm_password", confirmPassword, 8);
			if (confirmPasswordError1 != null) {
				fieldErrors.put("password", confirmPasswordError1);
			}
		}

		if (fieldErrors.isEmpty()) {
			try {
				boolean status = UserDao.resetPassword(emailAddress, otp, password, confirmPassword);
				if (status) {
					session.setAttribute("forgot-password-email", null); 
		            session.setAttribute("forgot-password-success", "Password reset successfully. Please log in.");
					response.sendRedirect("login.jsp");
				} else {
					fieldErrors.put("otp", "Invalid otp.");
					dispatcher = request.getRequestDispatcher("new-password.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			dispatcher = request.getRequestDispatcher("new-password.jsp");
		}

		if (dispatcher != null) {
			request.setAttribute("fieldErrors", fieldErrors);
			dispatcher.forward(request, response);
		} else {
			response.getWriter().write("Error: Unable to get the request dispatcher.");
		}
	}

}
