package com.labappointmentsystem.util;

public interface EmailSender {
    boolean sendEmail(String emailAddress, String subject, String bodyContent);
}
