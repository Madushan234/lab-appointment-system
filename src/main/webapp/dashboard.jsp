<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.util.SessionMapUtils"%>
<%@ page import="com.labappointmentsystem.dao.MedicalTestDao"%>
<%@ page import="com.labappointmentsystem.model.MedicalTest"%>
<%@ page import="java.util.List"%>
<%
String userEmail = (String) session.getAttribute("user-email");
String userFirstName = (String) session.getAttribute("user-first-name");
String userLastName = (String) session.getAttribute("user-last-name");
String userRole = (String) session.getAttribute("user-role");
if (userFirstName == null || userEmail == null) {
	response.sendRedirect("login.jsp");
}

Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
String bookingDateError = SessionMapUtils.getFiledValue(fieldErrors, "booking_date");
String bookingTimeError = SessionMapUtils.getFiledValue(fieldErrors, "booking_time");
String medicalTestError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test");
String recommendedDoctorError = SessionMapUtils.getFiledValue(fieldErrors, "recommended_doctor");
String common = SessionMapUtils.getFiledValue(fieldErrors, "common");
session.removeAttribute("fieldErrors");

String status = (String) session.getAttribute("create-status");
session.removeAttribute("create-status");
if (status != null) {
	session.removeAttribute("createUserFileds");
}

String booking_date, booking_time, recommended_doctor;
booking_date = booking_time = recommended_doctor = "";
Map<String, String> inputs = (Map<String, String>) session.getAttribute("createFileds");
booking_date = SessionMapUtils.getFiledValue(inputs, "booking_date");
booking_time = SessionMapUtils.getFiledValue(inputs, "booking_time");
recommended_doctor = SessionMapUtils.getFiledValue(inputs, "recommended_doctor");
session.removeAttribute("createFileds");

List<MedicalTest> medicalTestList = MedicalTestDao.getAllActiveMedicalTest();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC - Dashboard</title>
<script src="assets/js/js/jquery-3.7.1.min.js"></script>

<link rel="stylesheet" href="assets/css/vendors/feather/feather.css">
<link rel="stylesheet"
	href="assets/css/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" href="assets/css/vendors/vendor.bundle.base.css">
<link rel="stylesheet"
	href="assets/css/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
<link rel="stylesheet" type="text/css"
	href="assets/css/vendors/select.dataTables.min.css">
<link rel="stylesheet"
	href="assets/css/vendors/vertical-layout-light/style.css">
<link rel="shortcut icon" href="assets/image/favicon.png" />
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
</head>
<body>
	<div class="container-scroller">

		<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
			<div
				class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
				<a class="navbar-brand brand-logo mr-5" href="dashboard.jsp"><img
					src="assets/image/logo.png" class="ml-4" alt="logo" style="height: 40px;width: 200px;" /></a>
					<a class="navbar-brand brand-logo-mini" href="dashboard.jsp"><img
					src="assets/image/logo-mini.png" alt="logo" style="height: 40px;width: 40px;" /></a>
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
							<a class="dropdown-item" href="logout"> <i
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
						href="dashboard.jsp"> <i class="icon-bar-graph-2 menu-icon"></i>
							<span class="menu-title">Dashboard</span>
					</a></li>
					<%
					if ("patient".equals(userRole)) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="backend-my-appointment/index.jsp"> <i
							class="icon-paper menu-icon"></i> <span class="menu-title">My
								Appointment</span>
					</a></li>
					<%
					}
					if ("technician".equals(userRole) || "admin".equals(userRole)) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="backend-appointment/index.jsp"> <i
							class="icon-paper menu-icon"></i> <span class="menu-title">All
								Appointment</span>
					</a></li>
					<%
					}
					if ("admin".equals(userRole)) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="backend-medical-test/index.jsp"> <i
							class="icon-server menu-icon"></i> <span class="menu-title">Medical
								Test</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="backend-technicians/index.jsp"> <i
							class="icon-head menu-icon"></i> <span class="menu-title">Technician</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="backend-users/index.jsp"> <i
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
									<h2 class="font-weight-bold mb-0 text-center">Welcome to the ABC Laboratories</h2>
									<%
									if ("patient".equals(userRole)) {
									%>
									<div class="row">
										<div
											class="border col-xl-5 col-11 mx-auto mt-5 p-4 rounded-xl">
											<h4 class="mb-2 text-center">Create a Appointment</h4>
											<form class="pt-3" action="apppointment" method="post">
												<div>
													<div class="form-group">
														<label for="booking_date" class="font-weight-500">Booking
															Date</label> <input type="date"
															class="form-control form-control-lg" id="booking_date"
															name="booking_date" placeholder="Booking Date"
															value="<%=booking_date%>">
														<%=(bookingDateError != null) ? "<span class=\"text-danger\">" + bookingDateError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="booking_time" class="font-weight-500">Booking
															Time</label> <select id="booking_time" name="booking_time"
															class="form-control form-control-lg">
															<option value="">Select Booking Time</option>
															<option value="09:00">09:00</option>
															<option value="09:30">09:30</option>
															<option value="10:00">10:00</option>
															<option value="10:30">10:30</option>
															<option value="11:00">11:00</option>
															<option value="11:30">11:30</option>
															<option value="12:00">12:00</option>
															<option value="12:30">12:30</option>
															<option value="13:00">13:00</option>
															<option value="13:30">13:30</option>
															<option value="14:00">14:00</option>
															<option value="14:30">14:30</option>
															<option value="15:00">15:00</option>
															<option value="15:30">15:30</option>
															<option value="16:00">16:00</option>
															<option value="16:30">16:30</option>
															<option value="17:00">17:00</option>
															<option value="17:30">17:30</option>
															<option value="18:00">18:00</option>
															<option value="18:30">18:30</option>
															<option value="19:00">19:00</option>
															<option value="19:30">19:30</option>
															<option value="20:00">20:00</option>
															<option value="20:30">20:30</option>
														</select>
														<%=(bookingTimeError != null) ? "<span class=\"text-danger\">" + bookingTimeError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="recommended_doctor" class="font-weight-500">Recommended
															Doctor</label> <input type="text"
															class="form-control form-control-lg"
															id="recommended_doctor" name="recommended_doctor"
															placeholder="Recommended Doctor"
															value="<%=recommended_doctor%>">
														<%=(recommendedDoctorError != null) ? "<span class=\"text-danger\">" + recommendedDoctorError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="booking_time" class="font-weight-500">Medical
															Tests</label> <select
															class="js-example-basic-multiple form-control form-control-lg"
															id="medical_test" name="medical_test" multiple="multiple">
															<%
															for (MedicalTest medicalTest : medicalTestList) {
															%>
															<option value="<%=medicalTest.getId()%>"><%=medicalTest.getName()%></option>
															<%
															}
															%>
														</select>
														<%=(medicalTestError != null) ? "<span class=\"text-danger\">" + medicalTestError + "</span>" : ""%>
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
										<div class="col-xl-5 col-11 mx-auto mt-5 p-3">
											<img src="assets/image/home.svg" class="mr-2" alt="logo" />
										</div>
									</div>
									<%
									}else{
									%>
										<div class="col-12 mx-auto d-flex justify-content-center align-items-center">
											<img src="assets/image/home2.svg" style="height: 624px;" alt="logo" />
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














	<script src="assets/js/js/vendor.bundle.base.js"></script>
	<script src="assets/js/js/chart.js/Chart.min.js"></script>
	<script src="assets/js/js/datatables.net/jquery.dataTables.js"></script>
	<script src="assets/js/js/datatables.net-bs4/dataTables.bootstrap4.js"></script>
	<script src="assets/js/js/dataTables.select.min.js"></script>
	<script src="assets/js/js/off-canvas.js"></script>
	<script src="assets/js/js/hoverable-collapse.js"></script>
	<script src="assets/js/js/template.js"></script>
	<script src="assets/js/js/settings.js"></script>
	<script src="assets/js/js/todolist.js"></script>
	<script src="assets/js/js/dashboard.js"></script>
	<script src="assets/js/js/Chart.roundedBarCharts.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
	<script>
		$(document).ready(function() {
			$('.js-example-basic-multiple').select2();
		});
	</script>
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
	%>
</body>
</html>