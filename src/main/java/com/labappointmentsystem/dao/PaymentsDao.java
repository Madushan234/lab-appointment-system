package com.labappointmentsystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.labappointmentsystem.model.Payment;
import com.labappointmentsystem.util.DbConnectionManager;
import com.labappointmentsystem.util.EmailSender;
import com.labappointmentsystem.util.EmailSenderFactory;

public class PaymentsDao {

	private static Payment getPaymentFromResultSet(ResultSet rs) throws SQLException {
		Payment payment = new Payment();
		payment.setId(rs.getInt("id"));
		payment.setAppointmentId(rs.getInt("appointment_id"));
		payment.setDescription(rs.getString("description"));
		payment.setInvoice(rs.getString("invoice"));
		return payment;
	}

	// find payment by id
	public static Payment findPaymentByAppointmentId(String id) {
		Connection con = null;
		Payment payment = null;
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT * FROM payments WHERE appointment_id = ?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				payment = getPaymentFromResultSet(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return payment;
	}

	public static Payment createPayment(String appointmentId, double amount, String description, String invoice,
			String email) {
		Connection con = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String sql = "INSERT INTO payments (appointment_id, description, amount, invoice) VALUES (?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, appointmentId);
			preparedStatement.setString(2, description);
			preparedStatement.setDouble(3, amount/100);
			preparedStatement.setString(4, invoice);
			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				rs = preparedStatement.getGeneratedKeys();
				if (rs.next()) {
					String htmlContent = "<html><body>" + "<h3>Dear Customer,</h3>"
							+ "<p>Thank you for your payment. Your transaction has been successfully processed.</p>"
							+ "<br/><p>Transaction Details:</p>"
							+ "<p>Your appointment details are as follows:.</p>"
							+ "<p>Appointment Number : <strong>" + appointmentId + "</strong></p>"
							+ "<p>Amount Paid: <strong>" + amount + "</strong></p>" + "<p>Invoice Url : <strong>"
							+ invoice + "</strong></p>" + "<br/><p>Thank you for choosing our services.</p>"
							+ "<p>The ABC Laboratories Team</p>" + "</body></html>";
					EmailSender emailSender = EmailSenderFactory.getEmailSender("gmail");
					emailSender.sendEmail(email, "ABC laboratory appointment payment sucessfull. ID: " + appointmentId,
							htmlContent);
					return findPaymentByAppointmentId(appointmentId);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return null;
	}

}
