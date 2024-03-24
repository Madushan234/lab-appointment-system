package com.labappointmentsystem.util;

import javax.servlet.http.HttpSession;

public class UserAuthManager {
	
	private static UserAuthManager instance;

	private UserAuthManager() {}

	public static synchronized UserAuthManager getInstance() {
		if (instance == null) {
			instance = new UserAuthManager();
		}
		return instance;
	}

	public boolean isAuthenticated(HttpSession session) {
		String userEmail = (String) session.getAttribute("user-email");
		String userFirstName = (String) session.getAttribute("user-first-name");
		String userLastName = (String) session.getAttribute("user-last-name");
		String userRole = (String) session.getAttribute("user-role");
		return (userEmail != null && userFirstName != null && userRole != null && userLastName != null);
	}
	
	public boolean isPasswordResetOtpSend(HttpSession session) {
		String userEmail = (String) session.getAttribute("forgot-password-email");
		return (userEmail != null);
	}
}
