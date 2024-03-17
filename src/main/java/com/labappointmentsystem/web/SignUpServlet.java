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
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/sign-up")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignUpServlet() {
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
		Map<String, String> createUserFileds = new HashMap<>();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			createUserFileds.put(paramName, paramValue);
		}
		session.setAttribute("createUserFileds", createUserFileds);

		String first_name = request.getParameter("first_name");
		String last_name = request.getParameter("last_name");
		String email_address = request.getParameter("email_address");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");
		String telephone_number = request.getParameter("telephone_number");
		String nic = request.getParameter("nic");
		String date_of_birth = request.getParameter("date_of_birth");
		String booking_date = request.getParameter("booking_date");
		String booking_time = request.getParameter("booking_time");
		String recommended_doctor = request.getParameter("recommended_doctor");
		String[] medical_test = request.getParameterValues("medical_test");

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

		boolean isAppointmentAvailable = false;
		if (!(booking_date == "" && booking_time == "" && recommended_doctor == ""  && medical_test == null)) {
			String bookingDateError = ValidationUtils.isFieldRequired("booking_date", booking_date);
			String bookingTimeError = ValidationUtils.isFieldRequired("booking_time", booking_time);
			String recommendedDoctorError = ValidationUtils.isFieldRequired("recommended_doctor", recommended_doctor);
			if (bookingDateError != null) {
				fieldErrors.put("booking_date", bookingDateError);
			}
			if (bookingTimeError != null) {
				fieldErrors.put("booking_time", bookingTimeError);
			}
			if (recommendedDoctorError != null) {
				fieldErrors.put("recommended_doctor", recommendedDoctorError);
			}
			if (medical_test == null) {
				fieldErrors.put("medical_test",
						"The " + ValidationUtils.convertUnderscoreToSpace("medical_test") + " is required.");
			}
			isAppointmentAvailable = true;
		}

		System.out.println(fieldErrors);
		if (fieldErrors.isEmpty()) {
			System.out.println("-----1111");
			try {
				User userData = UserDao.findUserByEmail(email_address);
				if (userData == null) {
					user = UserDao.createPatient(first_name, last_name, email_address, password, confirm_password,
							telephone_number, nic, date_of_birth, "patient");
					if (user != null && isAppointmentAvailable) {
						int userId = user.getId();
						String userEmail = user.getEmail();
						appointment = AppointmentDao.createAppointment(userId, userEmail, recommended_doctor, booking_date,
								booking_time, medical_test);
					}
				} else {
					fieldErrors.put("email_address", "This email is already used.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			System.out.println("-----2222");
		}

		if (user == null) {
			fieldErrors.put("common", "Something went wrong. please try again later.");
			session.setAttribute("fieldErrors", fieldErrors);
		} else {
			if (!isAppointmentAvailable) {
				session.setAttribute("user-create-status", "Your user account has been created successfully. please booked your first appointment after login to the system.");
			} else if (appointment == null && isAppointmentAvailable) {
				session.setAttribute("user-create-status",
						"Your user account has been created successfully. you've appointment create failed. please booked your first appointment after login to the system.");
			} else {
				session.setAttribute("user-create-status",
						"Your user account has been created successfully. As you've booked your first appointment, your appointment details will be sent to your email shortly.");
			}
		}
		response.sendRedirect("sign-up.jsp");
	}

}
