<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.util.SessionMapUtils"%>
<%@ page import="com.labappointmentsystem.dao.MedicalTestDao"%>
<%@ page import="com.labappointmentsystem.model.MedicalTest"%>
<%
String userEmail = (String) session.getAttribute("user-email");
String userFirstName = (String) session.getAttribute("user-first-name");
String userLastName = (String) session.getAttribute("user-last-name");
String userRole = (String) session.getAttribute("user-role");
if (userFirstName == null || userEmail == null) {
	response.sendRedirect("../login.jsp");
}
Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
String idError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test_id");
String nameError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test_name");
String descriptionError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test_description");
String dataError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test_normal_record_data");
String amountError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test_amount");
String timeError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test_processing_time");
String isActiveError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test_is_active");
String common = SessionMapUtils.getFiledValue(fieldErrors, "common");
session.removeAttribute("fieldErrors");

String status = (String) session.getAttribute("medical-test-create-status");
session.removeAttribute("medical-test-create-status");

String updateTestId = request.getParameter("medical-test");
if (status != null || updateTestId != null) {
	session.removeAttribute("createMedicalTestFileds");
}

String testId, testName, testDescription, testNormalRecordData, testAmount, testProccesingTime;
testId = testName = testDescription = testNormalRecordData = testAmount = testProccesingTime = "";
boolean testIsActive = true;
boolean isInvalidTest = false;
if (updateTestId != null) {
	MedicalTest medicalTestData = MedicalTestDao.findMedicalTestById(updateTestId);
	if (medicalTestData != null) {
		testId = String.valueOf(medicalTestData.getId());
		testName = medicalTestData.getName();
		testDescription = medicalTestData.getDescription();
		testNormalRecordData = medicalTestData.getNormalRecordData();
		testAmount = String.valueOf(medicalTestData.getAmount());
		testProccesingTime = String.valueOf(medicalTestData.getProcessingTime());
		testIsActive = medicalTestData.isActive();
	} else {
		updateTestId = null;
		isInvalidTest = true;
	}
} else {
	Map<String, String> inputs = (Map<String, String>) session.getAttribute("createMedicalTestFileds");
	testId = SessionMapUtils.getFiledValue(inputs, "medical_test_id");
	testName = SessionMapUtils.getFiledValue(inputs, "medical_test_name");
	testDescription = SessionMapUtils.getFiledValue(inputs, "medical_test_description");
	testNormalRecordData = SessionMapUtils.getFiledValue(inputs, "medical_test_normal_record_data");
	testAmount = SessionMapUtils.getFiledValue(inputs, "medical_test_amount");
	testProccesingTime = SessionMapUtils.getFiledValue(inputs, "medical_test_processing_time");
	session.removeAttribute("createTechniciansFields");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC - All Appointment</title>
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
									<div class="d-flex justify-content-between m-3">
										<p class="card-title mb-0">
											<%=(updateTestId == null) ? "Create a New Technician" : "Update a Technician"%>
										</p>
									</div>
									<div class="my-5">
										<form class="pt-3" action="medical-test" method="post">
											<div class="row">
												<div class="col-md-6">
													<input type="hidden" name="action"
														value="<%=(updateTestId != null) ? "update" : "create"%>">
													<input type="hidden" name="medical_test_id"
														value="<%=updateTestId %>">
													<div class="form-group">
														<label for="medical_test_name" class="font-weight-500">Medical
															Test Name</label> <input type="text"
															class="form-control form-control-lg"
															id="medical_test_name" name="medical_test_name"
															placeholder="Medical Test Name" value="<%=testName%>">
														<%=(nameError != null) ? "<span style=\"color: red;\">" + nameError + "</span>" : ""%>

													</div>
													<div class="form-group">
														<label for="medical_test_description"
															class="font-weight-500">Medical Test Description</label>
														<textarea class="form-control form-control-lg"
															id="medical_test_description"
															name="medical_test_description" rows="15"
															placeholder="Medical Test Description"><%=testDescription%></textarea>
														<%=(descriptionError != null) ? "<span style=\"color: red;\">" + descriptionError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="medical_test_amount" class="font-weight-500">Medical
															Test Amount</label> <input type="number" min="1" step="0.01"
															class="form-control form-control-lg"
															id="medical_test_amount" name="medical_test_amount"
															placeholder="Medical Test Amount" value="<%=testAmount%>">
														<%=(amountError != null) ? "<span style=\"color: red;\">" + amountError + "</span>" : ""%>
													</div>
													<%
													if (updateTestId != null) {
													%>
													<div class="form-group">
														<input type="checkbox" class="mr-2"
														        <%= testIsActive ? "checked" : "" %>
															id="medical_test_is_active" name="medical_test_is_active"
															placeholder="Medical Test Is Active"> <label
															for="medical_test_is_active" class="font-weight-500">Medical
															Test Is Active</label>
														<%=(isActiveError != null) ? "<span style=\"color: red;\">" + isActiveError + "</span>" : ""%>
													</div>
													<%
													}
													%>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<label for="medical_test_processing_time"
															class="font-weight-500">Medical Test Processing
															Time</label> <input type="number" min="1" step="0.25"
															class="form-control form-control-lg"
															id="medical_test_processing_time"
															name="medical_test_processing_time"
															placeholder="Medical Test Processing Time"
															value="<%=testProccesingTime%>">
														<%=(timeError != null) ? "<span style=\"color: red;\">" + timeError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="medical_test_normal_record_data"
															class="font-weight-500">Medical Test Normal
															Record Data</label>
														<textarea class="form-control form-control-lg"
															id="medical_test_normal_record_data"
															name="medical_test_normal_record_data" rows="15"
															placeholder="Medical Test Description"><%=testNormalRecordData%></textarea>
														<%=(dataError != null) ? "<span style=\"color: red;\">" + dataError + "</span>" : ""%>
													</div>
												</div>
											</div>

											<div class="form-group">
												<%=(common != null) ? "<span style=\"color: red;\">" + common + "</span>" : ""%>
											</div>

											<div class="form-group">
												<button type="submit" class="btn btn-primary">Submit</button>
											</div>
										</form>
									</div>

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
	<script src="../assets/js/js/todolist.js"></script>
	<script src="../assets/js/js/dashboard.js"></script>
	<script src="../assets/js/js/Chart.roundedBarCharts.js"></script>

	<%
	if (status != null) {
	%>
	<script type="text/javascript">
		Swal.fire({
			title : "Good job!",
			text :  "<%=status%>",
			icon : "success"
		});
	</script>
	<%
	}
	if (isInvalidTest) {
	%>
	<script type="text/javascript">
		Swal.fire({
			title : "Failed!",
			text : "These medical test do not match our records.",
			icon : "error"
		});
	</script>
	<%
	}
	%>
</body>
