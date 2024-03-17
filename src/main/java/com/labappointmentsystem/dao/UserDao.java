package com.labappointmentsystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
	
	public static int getRoleId(String name) {
		Connection con = null;
	    ResultSet rs = null;
	    int roleId = 0;

	    try {
	        con = DbConnectionManager.getConnection();
	        String sql = "SELECT id FROM roles WHERE name=?";
	        PreparedStatement pst = con.prepareStatement(sql);
	        pst.setString(1, name);
	        rs = pst.executeQuery();

	        if (rs.next()) {
	            roleId = rs.getInt("id");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {			
	    	DbConnectionManager.closeConnection(con);
	    }
	    return roleId;
	}

	public static User findUserByEmail(String emailAddress) {
		Connection con = null;
		User user = null;
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT u.id, u.email, u.first_name, u.last_name, u.tel_number, u.nic, u.dob, r.name AS role_name FROM users u JOIN roles r ON u.role_id = r.id WHERE u.email=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, emailAddress);
			rs = pst.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setRoleName(rs.getString("role_name"));
	            user.setTelNumber(rs.getString("tel_number"));
	            user.setNic(rs.getString("nic"));
	            user.setDob(rs.getString("dob"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return user;
	}

	
	
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
						message.setSubject("Password Reset OTP");
						String htmlContent = "<html><body>" + "<h3>Hello,</h3>"
								+ "<p>We received a request to reset your password for your ABC Laboratories web system account. "
								+ "Please use the following OTP to complete the password reset process.</p>"
								+ "<p>Your OTP : <strong>" + token + "</strong></p>" + "<br/><p>Thank you,</p>"
								+ "<p>The ABC Laboratories Team</p>" + "</body></html>";
						message.setContent(htmlContent, "text/html");
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


	
	public static User createUser(Connection con,String first_name, String last_name, String email_address, String password,
			String confirm_password, String telephone_number, String nic, String date_of_birth, int roleId) {

		PreparedStatement preparedStatement = null;
		try {
			con = DbConnectionManager.getConnection();
			String sql = "INSERT INTO users (first_name, last_name, email, password, tel_number, nic, dob, role_id) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, first_name);
			preparedStatement.setString(2, last_name);
			preparedStatement.setString(3, email_address);
			preparedStatement.setString(4, password);
			preparedStatement.setString(5, telephone_number);
			preparedStatement.setString(6, nic);
			preparedStatement.setString(7, date_of_birth);
			preparedStatement.setInt(8, roleId);
			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				return findUserByEmail(email_address);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		}
		return null;
	}
	
	
	
	public static List<User> getAllTechnicians() {
	    Connection con = null;
	    List<User> userList = new ArrayList<>();
	    ResultSet rs = null;
	    try {
	        con = DbConnectionManager.getConnection();
	        String query = "SELECT * FROM users u JOIN roles r ON u.role_id = r.id WHERE r.name='technician'";
	        PreparedStatement pst = con.prepareStatement(query);
	        rs = pst.executeQuery();
	        while (rs.next()) {
	            User user = new User();
	            user.setEmail(rs.getString("email"));
	            user.setFirstName(rs.getString("first_name"));
	            user.setLastName(rs.getString("last_name"));
	            user.setTelNumber(rs.getString("tel_number"));
	            user.setNic(rs.getString("nic"));
	            user.setDob(rs.getString("dob"));
	            userList.add(user);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DbConnectionManager.closeConnection(con);
	    }
	    return userList;
	}
	
	public static List<User> getAllUsers() {
	    Connection con = null;
	    List<User> userList = new ArrayList<>();
	    ResultSet rs = null;
	    try {
	        con = DbConnectionManager.getConnection();
	        String query = "SELECT *, r.display_name AS role_name FROM users u JOIN roles r ON u.role_id = r.id";
	        PreparedStatement pst = con.prepareStatement(query);
	        rs = pst.executeQuery();
	        while (rs.next()) {
	            User user = new User();
	            user.setEmail(rs.getString("email"));
	            user.setFirstName(rs.getString("first_name"));
	            user.setLastName(rs.getString("last_name"));
	            user.setTelNumber(rs.getString("tel_number"));
	            user.setNic(rs.getString("nic"));
	            user.setDob(rs.getString("dob"));
				user.setRoleName(rs.getString("role_name"));
	            userList.add(user);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DbConnectionManager.closeConnection(con);
	    }
	    return userList;
	}

	public static User createTechnicians(String first_name, String last_name, String email_address, String password,
			String confirm_password, String telephone_number, String nic, String date_of_birth, String role) {
		Connection con = null;
		User user = null;
		try {
			con = DbConnectionManager.getConnection();
			user = createUser(con, first_name, last_name, email_address, password, confirm_password, telephone_number,
		            nic, date_of_birth, getRoleId(role));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return user;
	}

	public static User updateUserByEmail(String first_name, String last_name, String email_address, String telephone_number, String nic, String date_of_birth) {

        Connection con = null;
        PreparedStatement preparedStatement = null;
        try {
            con = DbConnectionManager.getConnection();
            String sql = "UPDATE users SET first_name=?, last_name=?, tel_number=?, nic=?, dob=? WHERE email=?";
            preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, first_name);
            preparedStatement.setString(2, last_name);
            preparedStatement.setString(3, telephone_number);
            preparedStatement.setString(4, nic);
            preparedStatement.setString(5, date_of_birth);
            preparedStatement.setString(6, email_address);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                return findUserByEmail(email_address);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnectionManager.closeConnection(con);
        }
        return null;
    }

	

	public static User createPatient(String first_name, String last_name, String email_address, String password,
			String confirm_password, String telephone_number, String nic, String date_of_birth, String role) {
		Connection con = null;
		User user = null;
		try {
			con = DbConnectionManager.getConnection();
			user = createUser(con, first_name, last_name, email_address, password, confirm_password, telephone_number,
		            nic, date_of_birth, getRoleId(role));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return user;
	}
}
