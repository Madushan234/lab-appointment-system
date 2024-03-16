package com.labappointmentsystem.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
 * Servlet implementation class ForgotPasswordServlet
 */
@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPasswordServlet() {
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
		response.sendRedirect("forgot-password.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Map<String, String> fieldErrors = new HashMap<>();
		boolean status = false;
    	
		String emailAddress = request.getParameter("email_address");

		String emailError = ValidationUtils.isFieldRequired("email_address", emailAddress);
		if (emailError != null) {
			fieldErrors.put("email_address", emailError);
		} else {
			String emailError1 = ValidationUtils.isValidEmail("email_address", emailAddress);
			if (emailError1 != null) {
				fieldErrors.put("email_address", emailError1);
			}
		}

		if (fieldErrors.isEmpty()) {
			try {
				boolean sendStatus = UserDao.createPasswordResetTokens(emailAddress);
				if (sendStatus) {
					session.setAttribute("forgot-password-email", emailAddress); 
					status = true;
				} else {
					fieldErrors.put("email_address", "These credentials do not match our records.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (status) {
			response.sendRedirect("new-password.jsp");
		} else {
			session.setAttribute("fieldErrors", fieldErrors);
			response.sendRedirect("forgot-password.jsp");
		}
	}
}
