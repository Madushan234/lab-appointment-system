package com.labappointmentsystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.labappointmentsystem.model.MedicalTest;
import com.labappointmentsystem.model.User;
import com.labappointmentsystem.util.DbConnectionManager;

public class MedicalTestDao {

	public static MedicalTest findMedicalTestById(String id) {
		Connection con = null;
		MedicalTest medicalTest = null;
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT id, name, description, normal_record_data, amount, processing_time, is_active FROM medical_tests WHERE id=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				medicalTest = new MedicalTest();
				medicalTest.setId(rs.getInt("id"));
				medicalTest.setName(rs.getString("name"));
				medicalTest.setDescription(rs.getString("description"));
				medicalTest.setNormalRecordData(rs.getString("normal_record_data"));
				medicalTest.setAmount(rs.getDouble("amount"));
				medicalTest.setProcessingTime(rs.getInt("processing_time"));
				medicalTest.setActive(rs.getBoolean("is_active"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return medicalTest;
	}

	public static MedicalTest createMedicalTest(String medical_test_name, String medical_test_description,
			String medical_test_normal_record_data, double medical_test_amount, int medical_test_processing_time) {
		Connection con = null;
		PreparedStatement preparedStatement = null;
		try {
			con = DbConnectionManager.getConnection();
			String sql = "INSERT INTO medical_tests (name, description, normal_record_data, amount, processing_time) "
					+ "VALUES (?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, medical_test_name);
			preparedStatement.setString(2, medical_test_description);
			preparedStatement.setString(3, medical_test_normal_record_data);
			preparedStatement.setDouble(4, medical_test_amount);
			preparedStatement.setInt(5, medical_test_processing_time);
			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				return findMedicalTestById(medical_test_name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return null;
	}

	public static MedicalTest updateMedicalTest(String medical_test_id, String medical_test_name,
			String medical_test_description, String medical_test_normal_record_data, double medical_test_amount,
			int medical_test_processing_time) {
		Connection con = null;
		PreparedStatement preparedStatement = null;
		try {
			con = DbConnectionManager.getConnection();
			String sql = "UPDATE medical_tests SET name=?, description=?, normal_record_data=?, amount=?, processing_time=? WHERE id=?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, medical_test_name);
			preparedStatement.setString(2, medical_test_description);
			preparedStatement.setString(3, medical_test_normal_record_data);
			preparedStatement.setDouble(4, medical_test_amount);
			preparedStatement.setInt(5, medical_test_processing_time);
			preparedStatement.setString(6, medical_test_id);
			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				return findMedicalTestById(medical_test_id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return null;
	}



	public static List<MedicalTest> getAllMedicalTest() {
		Connection con = null;
		List<MedicalTest> medicalTestList = new ArrayList<>();
		ResultSet rs = null;
		try {
			con = DbConnectionManager.getConnection();
			String query = "SELECT * FROM medical_tests";
			PreparedStatement pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				MedicalTest medicalTest = new MedicalTest();
				medicalTest.setId(rs.getInt("id"));
				medicalTest.setName(rs.getString("name"));
				medicalTest.setDescription(rs.getString("description"));
				medicalTest.setNormalRecordData(rs.getString("normal_record_data"));
				medicalTest.setAmount(rs.getDouble("amount"));
				medicalTest.setProcessingTime(rs.getInt("processing_time"));
				medicalTestList.add(medicalTest);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionManager.closeConnection(con);
		}
		return medicalTestList;
	}
}
