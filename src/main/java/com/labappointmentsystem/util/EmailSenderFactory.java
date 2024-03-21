package com.labappointmentsystem.util;

public class EmailSenderFactory {

	public static EmailSender getEmailSender(String provider) {
		if ("gmail".equalsIgnoreCase(provider)) {
			return new GmailEmailSender();
		}
		return null;
	}
}
