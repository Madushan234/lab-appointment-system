package com.labappointmentsystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.labappointmentsystem.model.Appointment;
import com.labappointmentsystem.model.User;
import com.labappointmentsystem.util.DbConnectionManager;
import com.labappointmentsystem.util.EmailSender;
import com.labappointmentsystem.util.EmailSenderFactory;

public class AppointmentDao {

	private static Appointment getAppointmentFromResultSet(ResultSet rs) throws SQLException {
		Appointment appointment = new Appointment();
		appointment.setId(rs.getInt("id"));
		appointment.setAppointmentStatus(rs.getString("appointment_status"));
		appointment.setAmount(rs.getDouble("amount"));
		appointment.setRecommendedDoctor(rs.getString("recommended_doctor"));
		appointment.setSelectDate(rs.getString("select_date"));
		appointment.setSelectTime(rs.getString("select_time"));
		appointment.setUserId(rs.getInt("user_id"));
		User user = new User();
		user.setFirstName(rs.getString("first_name"));
		user.setLastName(rs.getString("last_name"));
		user.setEmail(rs.getString("email"));
		user.setTelNumber(rs.getString("tel_number"));
		appointment.setUser(user);
		return appointment;
	}

	//find appointment by id
	public static Appointment findAppointmentById(String id) {
		Connection con = null;
		Appointment appointment = null;
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT appointments.*, users.* FROM appointments "
					+ "JOIN users ON appointments.user_id = users.id WHERE appointments.id = ?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				appointment = getAppointmentFromResultSet(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return appointment;
	}

	//get all appointment
	public static List<Appointment> getAllAppointments() {
		Connection con = null;
		List<Appointment> appointments = new ArrayList<>();
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT appointments.*, users.* FROM appointments "
					+ "JOIN users ON appointments.user_id = users.id ORDER BY appointments.id DESC";
			PreparedStatement pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Appointment appointment = getAppointmentFromResultSet(rs);
				appointments.add(appointment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return appointments;
	}

	//get appointment by user email
	public static List<Appointment> getAppointmentsByUserEmail(String email) {
		Connection con = null;
		List<Appointment> appointments = new ArrayList<>();
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT appointments.*, users.* FROM appointments "
					+ "JOIN users ON appointments.user_id = users.id WHERE users.email = ? ORDER BY appointments.id DESC";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, email);
			rs = pst.executeQuery();
			while (rs.next()) {
				Appointment appointment = getAppointmentFromResultSet(rs);
				appointments.add(appointment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return appointments;
	}

	//create appointment
	public static Appointment createAppointment(int userId, String userEmail, String recommended_doctor,
			String booking_date, String booking_time, String[] medical_test) {
		Connection con = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		double totalAmount = 0;
		try {
			con = DbConnectionManager.getConnection();
			con.setAutoCommit(false);
			String countQuery = "SELECT COUNT(*) FROM appointments WHERE select_date = ? AND select_time = ?";
			preparedStatement = con.prepareStatement(countQuery);
			preparedStatement.setString(1, booking_date);
			preparedStatement.setString(2, booking_time);
			rs = preparedStatement.executeQuery();
			if (rs.next()) {
				int appointmentCount = rs.getInt(1);
				if (appointmentCount >= 5) {
					return null;
				}
			}

			String query = "INSERT INTO appointments (user_id, appointment_status, recommended_doctor, select_date, select_time) VALUES (?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setInt(1, userId);
			preparedStatement.setString(2, "booked");
			preparedStatement.setString(3, recommended_doctor);
			preparedStatement.setString(4, booking_date);
			preparedStatement.setString(5, booking_time);
			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				rs = preparedStatement.getGeneratedKeys();
				if (rs.next()) {
					int appointmentId = rs.getInt(1);
					for (String medicalTestId : medical_test) {
						String query1 = "SELECT * FROM medical_tests WHERE id = ?";
						preparedStatement = con.prepareStatement(query1);
						preparedStatement.setInt(1, Integer.parseInt(medicalTestId));
						ResultSet rsMedicalTest = preparedStatement.executeQuery();
						if (rsMedicalTest.next()) {
							String query3 = "INSERT INTO medical_test_records "
									+ "(appointment_id, medical_test_id, status_id) " + "VALUES (?, ?, ?)";
							preparedStatement = con.prepareStatement(query3);
							preparedStatement.setInt(1, appointmentId);
							preparedStatement.setInt(2, rsMedicalTest.getInt("id"));
							preparedStatement.setInt(3, 7);
							int rowsAffected1 = preparedStatement.executeUpdate();
							if (rowsAffected1 > 0) {
								totalAmount += rsMedicalTest.getDouble("amount");
							}
						}
					}

					String query1 = "UPDATE appointments SET amount=? WHERE id=?";
					preparedStatement = con.prepareStatement(query1);
					preparedStatement.setDouble(1, totalAmount);
					preparedStatement.setInt(2, appointmentId);
					int rowsAffected2 = preparedStatement.executeUpdate();
					if (rowsAffected2 > 0) {
						con.commit();

						String htmlContent = "<html><body>" + "<h3>Hello,</h3>"
								+ "<p>Thank you for choosing ABC laboratory for your medical tests. "
								+ "We are thrilled to have you on board and look forward to providing you with exceptional service</p>"
								+ "<br/><p>Your appointment details are as follows:.</p>"
								+ "<p>Appointment Number : <strong>" + appointmentId + "</strong></p>"
								+ "<p>Booking date : <strong>" + booking_date + "</strong></p>"
								+ "<p>Booking time : <strong>" + booking_time + "</strong></p>"
								+ "<br/><p>Thank you,</p>" + "<p>The ABC Laboratories Team</p>" + "</body></html>";
						EmailSender emailSender = EmailSenderFactory.getEmailSender("gmail");
						boolean isEmailSend= false;
						if (emailSender != null) {
							isEmailSend = emailSender.sendEmail(userEmail, "ABC laboratory appointment. ID: " + appointmentId, htmlContent);
						}
						if(isEmailSend) {
							return findAppointmentById(String.valueOf(appointmentId));
						}
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				if (con != null) {
					con.rollback();
				}
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (con != null) {
					con.setAutoCommit(true);
					DbConnectionManager.closeConnection(con);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
