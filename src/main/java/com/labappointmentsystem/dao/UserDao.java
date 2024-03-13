package com.labappointmentsystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.labappointmentsystem.model.User;
import com.labappointmentsystem.util.DbConnectionManager;

public class UserDao {
	private static final String EMAIL = "countinglead@gmail.com";
	private static final String PASSWORD = "axrooqqmntvcxcdu";

	public static User authenticateUser(String emailAddress, String password) {
		Connection con = null;
		User user = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT u.email, u.first_name, u.last_name, r.name AS role_name FROM users u JOIN roles r ON u.role_id = r.id WHERE u.email=? AND u.password=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, emailAddress);
			pst.setString(2, password);
			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setEmail(rs.getString("email"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setRoleName(rs.getString("role_name"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return user;
	}

	public static User findUserByEmail(String emailAddress) {
		Connection con = null;
		User user = null;
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT u.email, u.first_name, u.last_name, r.name AS role_name FROM users u JOIN roles r ON u.role_id = r.id WHERE u.email=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, emailAddress);
			rs = pst.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setEmail(rs.getString("email"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setRoleName(rs.getString("role_name"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return user;
	}

	public static boolean createPasswordResetTokens(String emailAddress) {
		int token = 289758;
		Connection con = null;
		User user = findUserByEmail(emailAddress);
		try {
			if (user != null) {
				con = DbConnectionManager.getConnection();
				Random rand = new Random();
				token = rand.nextInt(999999);
				String insertQuery = "INSERT INTO password_reset_tokens (email, token) VALUES (?, ?)";
				PreparedStatement pst = con.prepareStatement(insertQuery);
				pst.setString(1, emailAddress);
				pst.setString(2, String.valueOf(token));
				int rowsAffected = pst.executeUpdate();
				if (rowsAffected > 0) {
					Properties props = new Properties();
					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.socketFactory.port", "465");
					props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", "465");
					Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(EMAIL, PASSWORD);
						}
					});
					MimeMessage message = new MimeMessage(session);
					try {
						message.setFrom(new InternetAddress(EMAIL));
						message.addRecipient(Message.RecipientType.TO, new InternetAddress(emailAddress));
						message.setSubject("Hello");
						message.setText("your OTP is: " + String.valueOf(token));
						Transport.send(message);
						System.out.println("message sent successfully");
						return true;
					} catch (AddressException e) {
						e.printStackTrace();
					} catch (MessagingException e) {
						e.printStackTrace();
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return false;
	}
	
	private static boolean verifyOTP(String emailAddress, String otp) {
	    Connection con = null;
	    ResultSet rs = null;
	    try {
	        con = DbConnectionManager.getConnection();
	        String query = "SELECT email FROM password_reset_tokens WHERE email=? AND token=?";
	        PreparedStatement pst = con.prepareStatement(query);
	        pst.setString(1, emailAddress);
	        pst.setString(2, otp);
	        rs = pst.executeQuery();
	        return rs.next(); 
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DbConnectionManager.closeConnection(con);
	    }
	    return false;
	}

	public static boolean resetPassword(String emailAddress, String otp, String password, String confirmPassword) {

		Connection con = null;
		User user = findUserByEmail(emailAddress);
		try {
			if (user != null && verifyOTP(emailAddress, otp)) {
				con = DbConnectionManager.getConnection();
				String updateQuery = "UPDATE users SET password = ? WHERE email = ?";
				PreparedStatement updatePst = con.prepareStatement(updateQuery);
				updatePst.setString(1, password); 
				updatePst.setString(2, emailAddress);
				int rowsAffected = updatePst.executeUpdate();
				if (rowsAffected > 0) {
					String deleteQuery = "DELETE FROM password_reset_tokens WHERE email = ?";
					PreparedStatement deletePst = con.prepareStatement(deleteQuery);
					deletePst.setString(1, emailAddress);
					deletePst.executeUpdate();
					return true; 
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return false;
	}
}
