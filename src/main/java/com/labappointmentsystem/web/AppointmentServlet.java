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

import com.labappointmentsystem.dao.AppointmentDao;
import com.labappointmentsystem.dao.UserDao;
import com.labappointmentsystem.model.Appointment;
import com.labappointmentsystem.model.User;
import com.labappointmentsystem.util.ValidationUtils;

/**
 * Servlet implementation class AppointmentServlet
 */
@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AppointmentServlet() {
		super();
		// TODO Auto-generated constructor stub
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
		Appointment appointment = null;

		Enumeration<String> parameterNames = request.getParameterNames();
		Map<String, String> createFileds = new HashMap<>();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			createFileds.put(paramName, paramValue);
		}
		session.setAttribute("createFileds", createFileds);

		String email_address = (String) session.getAttribute("user-email");
		String booking_date = request.getParameter("booking_date");
		String booking_time = request.getParameter("booking_time");
		String recommended_doctor = request.getParameter("recommended_doctor");
		String[] medical_test = request.getParameterValues("medical_test");

		String bookingDateError = ValidationUtils.isFieldRequired("booking_date", booking_date);
		if (bookingDateError != null) {
			fieldErrors.put("booking_date", bookingDateError);
		}

		String bookingTimeError = ValidationUtils.isFieldRequired("booking_time", booking_time);
		if (bookingTimeError != null) {
			fieldErrors.put("booking_time", bookingTimeError);
		}

		String recommendedDoctorError = ValidationUtils.isFieldRequired("recommended_doctor", recommended_doctor);
		if (recommendedDoctorError != null) {
			fieldErrors.put("recommended_doctor", recommendedDoctorError);
		}

		if (medical_test == null) {
			fieldErrors.put("medical_test",
					"The " + ValidationUtils.convertUnderscoreToSpace("medical_test") + " is required.");
		}

		if (fieldErrors.isEmpty()) {
			try {
				User userData = UserDao.findUserByEmail(email_address);
				if (userData != null) {
					int userId = userData.getId();
					String userEmail = userData.getEmail();
					appointment = AppointmentDao.createAppointment(userId, userEmail, recommended_doctor, booking_date,
							booking_time, medical_test);
				} else {
					fieldErrors.put("common", "Something went wrong. please try again later.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (appointment == null) {
			fieldErrors.put("common", "Something went wrong. please try again later.");
			session.setAttribute("fieldErrors", fieldErrors);
		} else {
			session.setAttribute("create-status", "Your appointment has been created successfully. your appointment details will be sent to your email shortly.");
		}
		response.sendRedirect("dashboard.jsp");
	}

}
