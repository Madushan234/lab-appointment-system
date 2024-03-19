<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.util.SessionMapUtils"%>
<%@ page import="com.labappointmentsystem.dao.AppointmentDao"%>
<%@ page import="com.labappointmentsystem.model.Appointment"%>
<%@ page import="com.labappointmentsystem.dao.MedicalTestRecordDao"%>
<%@ page import="com.labappointmentsystem.model.MedicalTestRecord"%>
<%@ page import="java.util.List"%>
<%
String userEmail = (String) session.getAttribute("user-email");
String userFirstName = (String) session.getAttribute("user-first-name");
String userLastName = (String) session.getAttribute("user-last-name");
String userRole = (String) session.getAttribute("user-role");
if (userFirstName == null || userEmail == null) {
	response.sendRedirect("../login.jsp");
}

String appoimentId = request.getParameter("appoiment");
String first_name, last_name, email, tel_number, appointment_status, recommended_doctor, booking_date, booking_time,
		amount;
first_name = last_name = email = tel_number = appointment_status = recommended_doctor = booking_date = booking_time = amount = "";
boolean isInvalidAppointment = false;
List<MedicalTestRecord> medicalTestRecordList = MedicalTestRecordDao.findTestRecordByAppointmentId(appoimentId);
if (appoimentId != null) {
	Appointment appointmentData = AppointmentDao.findAppointmentById(appoimentId);
	if (appointmentData != null) {
		first_name = appointmentData.getUser().getFirstName();
		last_name = appointmentData.getUser().getLastName();
		email = appointmentData.getUser().getEmail();
		tel_number = appointmentData.getUser().getTelNumber();
		appointment_status = appointmentData.getAppointmentStatus();
		recommended_doctor = appointmentData.getRecommendedDoctor();
		booking_date = appointmentData.getSelectDate();
		booking_time = appointmentData.getSelectTime();
		amount = String.valueOf(appointmentData.getAmount());
	} else {
		isInvalidAppointment = true;
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
									if (!isInvalidAppointment) {
									%>

									<div class="d-flex justify-content-between m-3">
										<p class="card-title mb-0">
											Appointment Number:
											<%=appoimentId%>
										</p>
									</div>

									<div class="my-5 pl-5">
										<div class="col-12 col-xl-6 table-responsive">
											<table
												class="table border table-striped table-borderless font-weight-bold ">
												<tr>
													<th colspan="2" class="bg-info text-white">Appointment
														details</th>
												</tr>
												<tr>
													<td>Patient Name :</td>
													<td><%=first_name%> <%=last_name%></td>
												</tr>
												<tr>
													<td>Email :</td>
													<td><%=email%></td>
												</tr>
												<tr>
													<td>Telephone number :</td>
													<td><%=tel_number%></td>
												</tr>
												<tr>
													<td>Appointment Status :</td>
													<td class="text-uppercase"><%=appointment_status%></td>
												</tr>
												<tr>
													<td>Amount :</td>
													<td><%=amount%></td>
												</tr>
												<tr>
													<td>Recommended Doctor :</td>
													<td><%=recommended_doctor%></td>
												</tr>
												<tr>
													<td>Booking Date :</td>
													<td><%=booking_date%></td>
												</tr>
												<tr>
													<td>Booking Time :</td>
													<td><%=booking_time%></td>
												</tr>
											</table>
										</div>
									</div>

									<div class="my-5 pl-5">
										<h4 class="pl-5 mb-3">All medical test details</h4>
										<div class="table-responsive rounded-xl">
											<table class="table table-striped table-borderless">
												<thead class="bg-info text-white">
													<tr>
														<th>ID</th>
														<th>Medical Test Name</th>
														<th>Status</th>
														<th>Action</th>
													</tr>
												</thead>
												<tbody>
													<%
													for (MedicalTestRecord medicalTestRecord : medicalTestRecordList) {
													%>
													<tr>
														<td><%=medicalTestRecord.getId()%></td>
														<td><%=medicalTestRecord.getMedicalTest().getName()%></td>
														<td class="text-uppercase"><%=medicalTestRecord.getStatus().getName()%></td>
														<td><a
															href="medical-test-details.jsp?medical-test-record=<%=String.valueOf(medicalTestRecord.getId())%>">Manage</a></td>
													</tr>
													<%
													}
													%>
												</tbody>
											</table>
										</div>
									</div>

									<%
									} else {
									%>
									<div class="d-flex justify-content-between m-3">
										<p class="card-title mb-0">This appointment details not
											found.</p>
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
	<script src="../assets/js/js/todolist.js"></script>
	<script src="../assets/js/js/dashboard.js"></script>
	<script src="../assets/js/js/Chart.roundedBarCharts.js"></script>

	<%
	if (isInvalidAppointment) {
	%>
	<script type="text/javascript">
		Swal.fire({
			title : "Failed!",
			text : "This appointment details not found.",
			icon : "error"
		});
	</script>
	<%
	}
	%>
</body>