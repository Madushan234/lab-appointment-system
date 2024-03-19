<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.util.SessionMapUtils"%>
<%@ page import="com.labappointmentsystem.dao.AppointmentDao"%>
<%@ page import="com.labappointmentsystem.dao.MedicalTestRecordDao"%>
<%@ page import="com.labappointmentsystem.model.MedicalTestRecord"%>
<%@ page import="com.labappointmentsystem.model.Appointment"%>
<%@ page import="com.labappointmentsystem.model.Status"%>
<%@ page import="java.util.List"%>
<%
String userEmail = (String) session.getAttribute("user-email");
String userFirstName = (String) session.getAttribute("user-first-name");
String userLastName = (String) session.getAttribute("user-last-name");
String userRole = (String) session.getAttribute("user-role");
if (userFirstName == null || userEmail == null) {
	response.sendRedirect("../login.jsp");
}

Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
String testResultError = SessionMapUtils.getFiledValue(fieldErrors, "test_result");
String common = SessionMapUtils.getFiledValue(fieldErrors, "common");
session.removeAttribute("fieldErrors");

String status = (String) session.getAttribute("record-status");
session.removeAttribute("record-status");

String testRecordId = request.getParameter("medical-test-record");
String test_name, test_description, test_normal_record_data, status_name, result, test_id, appoiment_id, test_result;
test_name = test_description = test_normal_record_data = status_name = result = test_id = appoiment_id = test_result = "";
double test_processing_time = 0;
boolean isInvalidMedicalTest = false;
byte[] report = null;
int status_id = 0;
List<Status> statusList = null;
if (testRecordId != null) {
	MedicalTestRecord medicalTestRecord = MedicalTestRecordDao.findTestRecordById(testRecordId);
	if (medicalTestRecord != null) {
		statusList = MedicalTestRecordDao.getAllRecordStatus();
		test_id = String.valueOf(medicalTestRecord.getMedicalTest().getId());
		test_name = medicalTestRecord.getMedicalTest().getName();
		test_description = medicalTestRecord.getMedicalTest().getDescription();
		test_normal_record_data = medicalTestRecord.getMedicalTest().getNormalRecordData();
		test_processing_time = medicalTestRecord.getMedicalTest().getProcessingTime();
		status_name = medicalTestRecord.getStatus().getName();
		report = medicalTestRecord.getReport();
		status_id = medicalTestRecord.getStatusId();
		result = (medicalTestRecord.getResult() != null) ? medicalTestRecord.getResult() : "";
		appoiment_id = String.valueOf(medicalTestRecord.getAppointmentId());
	} else {
		isInvalidMedicalTest = true;
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC - Appointment</title>
<script src="../assets/js/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../assets/css/vendors/feather/feather.css">
<link rel="stylesheet"
	href="../assets/css/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet"
	href="../assets/css/vendors/vendor.bundle.base.css">
<link rel="stylesheet"
	href="../assets/css/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
<link rel="stylesheet" type="text/css"
	href="../assets/css/vendors/select.dataTables.min.css">
<link rel="stylesheet"
	href="../assets/css/vendors/vertical-layout-light/style.css">
<link rel="shortcut icon" href="../assets/images/favicon.png" />
</head>
<body>
	<div class="container-scroller">

		<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
			<div
				class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
				<a class="navbar-brand brand-logo mr-5" href="index.html"><img
					src="../assets/image/logo.svg" class="mr-2" alt="logo" /></a> <a
					class="navbar-brand brand-logo-mini" href="index.html"><img
					src="../assets/image/logo-mini.svg" alt="logo" /></a>
			</div>
			<div
				class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
				<button class="navbar-toggler navbar-toggler align-self-center"
					type="button" data-toggle="minimize">
					<span class="icon-menu"></span>
				</button>
				<ul class="navbar-nav navbar-nav-right">
					<li class="nav-item nav-profile dropdown"><a
						class="nav-link dropdown-toggle d-flex align-items-center"
						href="#" data-toggle="dropdown" id="profileDropdown"> <span
							class="title">Hi, <%=userFirstName%> <%=userLastName%></span>
					</a>
						<div class="dropdown-menu dropdown-menu-right navbar-dropdown"
							aria-labelledby="profileDropdown">
							<a class="dropdown-item" href="../logout"> <i
								class="ti-power-off text-primary"></i> Logout
							</a>
						</div></li>
				</ul>
				<button
					class="navbar-toggler navbar-toggler-right d-lg-none align-self-center"
					type="button" data-toggle="offcanvas">
					<span class="icon-menu"></span>
				</button>
			</div>
		</nav>

		<div class="container-fluid page-body-wrapper">

			<nav class="sidebar sidebar-offcanvas" id="sidebar">
				<ul class="nav">
					<li class="nav-item"><a class="nav-link"
						href="../dashboard.jsp"> <i class="icon-bar-graph-2 menu-icon"></i>
							<span class="menu-title">Dashboard</span>
					</a></li>
					<%
					if (userRole != null) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="../backend-my-appointment/index.jsp"> <i
							class="icon-paper menu-icon"></i> <span class="menu-title">My
								Appointment</span>
					</a></li>
					<%
					}
					if ("technician".equals(userRole) || "admin".equals(userRole)) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="../backend-appointment/index.jsp"> <i
							class="icon-paper menu-icon"></i> <span class="menu-title">All
								Appointment</span>
					</a></li>
					<%
					}
					if ("admin".equals(userRole)) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="../backend-medical-test/index.jsp"> <i
							class="icon-server menu-icon"></i> <span class="menu-title">Medical
								Test</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="../backend-technicians/index.jsp"> <i
							class="icon-head menu-icon"></i> <span class="menu-title">Technician</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="../backend-users/index.jsp"> <i
							class="icon-head menu-icon"></i> <span class="menu-title">Users</span>
					</a></li>
					<%
					}
					%>

				</ul>
			</nav>

			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-md-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<%
									if (!isInvalidMedicalTest) {
									%>
									<div class="d-flex justify-content-between m-3">
										<p class="card-title mb-0">
											Appointment Number:
											<%=appoiment_id%>
											(<%=test_name%>)
										</p>
									</div>

									<div class="my-5 px-5">
										<div class="col-12 table-responsive">
											<table
												class="table border table-striped table-borderless font-weight-bold ">
												<tr>
													<th colspan="2" class="bg-info text-white">Medical
														test details</th>
												</tr>
												<tr>
													<td>Medical Test Record Id :</td>
													<td><%=testRecordId%></td>
												</tr>
												<tr>
													<td>Medical Test Id :</td>
													<td><%=test_id%></td>
												</tr>
												<tr>
													<td>Medical Test Name :</td>
													<td><%=test_name%></td>
												</tr>
												<tr>
													<td>Medical Test Description :</td>
													<td><%=test_description != null ? test_description.replaceAll("\\n", "<br>") : ""%></td>
												</tr>
												<tr>
													<td>Current Status :</td>
													<td class="text-uppercase"><%=status_name%></td>
												</tr>
												<tr>
													<td>Medical Test Normal Record Details :</td>
													<td><%=test_normal_record_data != null ? test_normal_record_data.replaceAll("\\n", "<br>") : ""%></td>
												</tr>
												<tr>
													<td>Medical Test Result:</td>
													<td style="line-height: 25px;"><%=result != null ? result.replaceAll("\\n", "<br>") : ""%>
													</td>
												</tr>
												<%
												if (report != null) {
												%>
												<tr>
													<td>Medical Test Report:</td>
													<td><a href="../download-report?recordId=<%=testRecordId%>"
														class="btn btn-primary">Download Report</a></td>
												</tr>
												<%
												}
												%>
											</table>
										</div>
									</div>

									<%
									} else {
									%>
									<div class="d-flex justify-content-between m-3">
										<p class="card-title mb-0">This medical test details not
											found..</p>
									</div>
									<%
									}
									%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<script src="../assets/js/js/vendor.bundle.base.js"></script>
	<script src="../assets/js/js/chart.js/Chart.min.js"></script>
	<script src="../assets/js/js/datatables.net/jquery.dataTables.js"></script>
	<script
		src="../assets/js/js/datatables.net-bs4/dataTables.bootstrap4.js"></script>
	<script src="../assets/js/js/dataTables.select.min.js"></script>
	<script src="../assets/js/js/off-canvas.js"></script>
	<script src="../assets/js/js/hoverable-collapse.js"></script>
	<script src="../assets/js/js/template.js"></script>
	<script src="../assets/js/js/settings.js"></script>
	<script src="../assets/js/js/dashboard.js"></script>
	<script src="../assets/js/js/Chart.roundedBarCharts.js"></script>

	<%
	if (status != null) {
	%>
	<script type="text/javascript">
		Swal.fire({
			title : "Good job!",
			text :  "<%=status%>
		",
			icon : "success"
		});
	</script>
	<%
	}
	if (isInvalidMedicalTest) {
	%>
	<script type="text/javascript">
		Swal.fire({
			title : "Failed!",
			text : "This medical test details not found.",
			icon : "error"
		});
	</script>
	<%
	}
	%>
</body>