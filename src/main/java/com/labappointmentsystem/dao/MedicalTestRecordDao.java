package com.labappointmentsystem.dao;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.labappointmentsystem.model.MedicalTest;
import com.labappointmentsystem.model.MedicalTestRecord;
import com.labappointmentsystem.model.Status;
import com.labappointmentsystem.model.User;
import com.labappointmentsystem.util.DbConnectionManager;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;

public class MedicalTestRecordDao {

	public static List<MedicalTestRecord> findTestRecordByAppointmentId(String appointmentId) {
		Connection con = null;
		List<MedicalTestRecord> testRecords = new ArrayList<>();
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT mtr.id AS record_id, mtr.appointment_id, mtr.medical_test_id, mtr.technician_id, mtr.status_id,"
					+ " mtr.report, mtr.result, mt.name AS test_name, mt.description AS test_description, mt.amount AS test_amount,"
					+ " mt.id AS test_id, mt.normal_record_data AS test_normal_record_data, mt.processing_time AS test_processing_time,"
					+ " s.name AS status_name FROM medical_test_records mtr JOIN medical_tests mt"
					+ " ON mtr.medical_test_id = mt.id JOIN status s ON mtr.status_id = s.id WHERE mtr.appointment_id = ?";

			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, appointmentId);
			rs = pst.executeQuery();
			while (rs.next()) {
				MedicalTestRecord testRecord = getTestRecordFromResultSet(rs);
				testRecords.add(testRecord);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return testRecords;
	}

	public static MedicalTestRecord findTestRecordById(String id) {
		Connection con = null;
		MedicalTestRecord testRecords = null;
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT mtr.id AS record_id, mtr.appointment_id, mtr.medical_test_id, mtr.technician_id, mtr.status_id,"
					+ " mtr.report, mtr.result, mt.name AS test_name, mt.description AS test_description, mt.amount AS test_amount,"
					+ " mt.id AS test_id, mt.normal_record_data AS test_normal_record_data, mt.processing_time AS test_processing_time,"
					+ " s.name AS status_name FROM medical_test_records mtr JOIN medical_tests mt"
					+ " ON mtr.medical_test_id = mt.id JOIN status s ON mtr.status_id = s.id WHERE mtr.id = ?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				testRecords = getTestRecordFromResultSet(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return testRecords;
	}

	private static MedicalTestRecord getTestRecordFromResultSet(ResultSet rs) throws SQLException {
		MedicalTestRecord testRecord = new MedicalTestRecord();
		testRecord.setId(rs.getInt("record_id"));
		testRecord.setAppointmentId(rs.getInt("appointment_id"));
		testRecord.setMedicalTestId(rs.getInt("medical_test_id"));
		testRecord.setTechnicianId(rs.getInt("technician_id"));
		testRecord.setStatusId(rs.getInt("status_id"));
		testRecord.setReport(rs.getBytes("report"));
		testRecord.setResult(rs.getString("result"));

		MedicalTest medicalTest = new MedicalTest();
		medicalTest.setId(rs.getInt("test_id"));
		medicalTest.setName(rs.getString("test_name"));
		medicalTest.setDescription(rs.getString("test_description"));
		medicalTest.setNormalRecordData(rs.getString("test_normal_record_data"));
		medicalTest.setAmount(rs.getDouble("test_amount"));
		medicalTest.setProcessingTime(rs.getDouble("test_processing_time"));
		testRecord.setMedicalTest(medicalTest);

		Status status = new Status();
		status.setName(rs.getString("status_name"));
		testRecord.setStatus(status);

		User user = new User();
		testRecord.setUser(user);

		return testRecord;
	}

	public static List<Status> getAllRecordStatus() {
		Connection con = null;
		List<Status> statusList = new ArrayList<>();
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			PreparedStatement pst = con.prepareStatement("SELECT * FROM status");
			rs = pst.executeQuery();
			while (rs.next()) {
				Status status = new Status();
				status.setId(rs.getInt("id"));
				status.setName(rs.getString("name"));
				statusList.add(status);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return statusList;
	}

	public static MedicalTestRecord updateTestReord(String test_record_id, String test_result, String test_status)
			throws FileNotFoundException {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement preparedStatement = null;

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		Document doc = new Document();
		try {
			PdfWriter writer = PdfWriter.getInstance(doc, outputStream);
			doc.open();
			String htmlContent = "<div> " + "<hr></hr>" + "<h3 style=\"text-align: center\">BLLOD SUGER</h3>" + "<div>"
					+ test_result.replaceAll("\\n", "<br/>") + "</div><br/><br/>" + "</div>";
			try {
				XMLWorkerHelper.getInstance().parseXHtml(writer, doc, new java.io.StringReader(htmlContent));
			} catch (IOException e) {
				e.printStackTrace();
			}
			doc.close();
			writer.close();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		byte[] pdfBytes = outputStream.toByteArray();
		System.out.println("PDF created.");

		try {
			con = DbConnectionManager.getConnection();
			String sql = "UPDATE medical_test_records SET result=?, status_id=?, report=? WHERE id=?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, test_result);
			preparedStatement.setString(2, test_status);
			preparedStatement.setBytes(3, pdfBytes);
			preparedStatement.setString(4, test_record_id);
			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				return findTestRecordById(test_record_id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return null;
	}

	public static byte[] getReportFromDatabase(int recordId) {
		Connection con = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		byte[] pdfBytes = null;
		try {
			con = DbConnectionManager.getConnection();
			String sql = "SELECT report FROM medical_test_records WHERE id = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, recordId);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				pdfBytes = resultSet.getBytes("report");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return pdfBytes;
	}

}
