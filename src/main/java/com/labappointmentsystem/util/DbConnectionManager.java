package com.labappointmentsystem.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DbConnectionManager {
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/lab-appointment-system";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "";

	private static final String TEST_JDBC_URL = "jdbc:mysql://localhost:3306/lab-appointment-system-test";
	private static final String TEST_USERNAME = "root";
	private static final String TEST_PASSWORD = "";

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException e) {
			throw new SQLException("Database driver not found", e);
		}
	}

	public static Connection getTestConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(TEST_JDBC_URL, TEST_USERNAME, TEST_PASSWORD);
			executeResetScript(connection);
			return connection;
		} catch (ClassNotFoundException e) {
			throw new SQLException("Database driver not found", e);
		}
	}

	private static void executeResetScript(Connection connection) throws SQLException {
		Statement statement = connection.createStatement();
		String script = "db.sql";
		try {
			statement.executeLargeUpdate(new String(Files.readAllBytes(Paths.get(script)), StandardCharsets.UTF_8));
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			
		}
	}

	public static void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
