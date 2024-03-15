<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.util.SessionMapUtils"%>
<%@ page import="com.labappointmentsystem.dao.UserDao"%>
<%@ page import="com.labappointmentsystem.model.User"%>
<%
String userEmail = (String) session.getAttribute("user-email");
String userFirstName = (String) session.getAttribute("user-first-name");
String userLastName = (String) session.getAttribute("user-last-name");
String userRole = (String) session.getAttribute("user-role");
if (userFirstName == null || userEmail == null) {
	response.sendRedirect("../login.jsp");
}
if (!"admin".equals(userRole)) {
	response.sendRedirect("../dashboard.jsp");
}

Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
String firstNameError = SessionMapUtils.getFiledValue(fieldErrors, "first_name");
String lastNameError = SessionMapUtils.getFiledValue(fieldErrors, "last_name");
String emailError = SessionMapUtils.getFiledValue(fieldErrors, "email_address");
String passwordError = SessionMapUtils.getFiledValue(fieldErrors, "password");
String confirmPasswordError = SessionMapUtils.getFiledValue(fieldErrors, "confirm_password");
String telephoneNumberError = SessionMapUtils.getFiledValue(fieldErrors, "telephone_number");
String nicError = SessionMapUtils.getFiledValue(fieldErrors, "nic");
String dobError = SessionMapUtils.getFiledValue(fieldErrors, "date_of_birth");
String common = SessionMapUtils.getFiledValue(fieldErrors, "common");
session.removeAttribute("fieldErrors");

String status = (String) session.getAttribute("technician-create-status");
session.removeAttribute("technician-create-status");

String updateUserEmail = request.getParameter("email-address");
if (status != null || updateUserEmail != null) {
	session.removeAttribute("createTechniciansFields");
}

String firstName, lastName, email, password, confirmPassword, telephoneNumber, nic, dob;
firstName = lastName = email = password = confirmPassword = telephoneNumber = nic = dob = "";
boolean isInvalidUser = false;
if (updateUserEmail != null) {
	User userData = UserDao.findUserByEmail(updateUserEmail);
	if (userData != null) {
		firstName = userData.getFirstName();
		lastName = userData.getLastName();
		email = userData.getEmail();
		telephoneNumber = userData.getTelNumber();
		nic = userData.getNic();
		dob = userData.getDob();
	} else {
		updateUserEmail = null;
		isInvalidUser = true;
	}
} else {
	Map<String, String> inputs = (Map<String, String>) session.getAttribute("createTechniciansFields");
	firstName = SessionMapUtils.getFiledValue(inputs, "first_name");
	lastName = SessionMapUtils.getFiledValue(inputs, "last_name");
	email = SessionMapUtils.getFiledValue(inputs, "email_address");
	password = SessionMapUtils.getFiledValue(inputs, "password");
	confirmPassword = SessionMapUtils.getFiledValue(inputs, "confirm_password");
	telephoneNumber = SessionMapUtils.getFiledValue(inputs, "telephone_number");
	nic = SessionMapUtils.getFiledValue(inputs, "nic");
	dob = SessionMapUtils.getFiledValue(inputs, "date_of_birth");
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
<title>ABC - Technicians</title>
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
											<%=(updateUserEmail == null) ? "Create a New Technician" : "Update a Technician"%>
										</p>
									</div>
									<div class="my-5">
										<form class="pt-3" action="technician/create" method="post">
											<div class="row">
												<div class="col-md-6">
													<input type="hidden" name="action"
														value="<%=(updateUserEmail != null) ? "update" : "create"%>">
													<div class="form-group">
														<label for="email_address" class="font-weight-500">Email
															Address</label> <input type="email"
															class="form-control form-control-lg" id="email_address"
															name="email_address" placeholder="Email Address"
															<%if (updateUserEmail != null)
	out.print("disabled");%>
															value="<%=email%>">
														<%=(emailError != null) ? "<span style=\"color: red;\">" + emailError + "</span>" : ""%>

													</div>
													<div class="form-group">
														<label for="first_name" class="font-weight-500">First
															Name</label> <input type="text"
															class="form-control form-control-lg" id="first_name"
															name="first_name" placeholder="First Name"
															value="<%=firstName%>">
														<%=(firstNameError != null) ? "<span style=\"color: red;\">" + firstNameError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="last_name" class="font-weight-500">Last
															Name</label> <input type="text"
															class="form-control form-control-lg" id="last_name"
															name="last_name" placeholder="Last Name"
															value="<%=lastName%>">
														<%=(lastNameError != null) ? "<span style=\"color: red;\">" + lastNameError + "</span>" : ""%>
													</div>
													<%
													if (updateUserEmail == null) {
													%>
													<div class="form-group">
														<label for="password" class="font-weight-500">Password</label>
														<input type="text" class="form-control form-control-lg"
															id="password" name="password" placeholder="Password"
															value="<%=password%>">
														<%=(passwordError != null) ? "<span style=\"color: red;\">" + passwordError + "</span>" : ""%>
													</div>
													<%
													}
													%>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<label for="date_of_birth" class="font-weight-500">Date
															of Birth</label> <input type="date"
															class="form-control form-control-lg" id="date_of_birth"
															name="date_of_birth" placeholder="Date of Birth"
															value="<%=dob%>">
														<%=(dobError != null) ? "<span style=\"color: red;\">" + dobError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="telephone_number" class="font-weight-500">Telephone
															Number</label> <input type="tel"
															class="form-control form-control-lg"
															id="telephone_number" name="telephone_number"
															placeholder="Telephone Number"
															value="<%=telephoneNumber%>">
														<%=(telephoneNumberError != null) ? "<span style=\"color: red;\">" + telephoneNumberError + "</span>" : ""%>
													</div>
													<div class="form-group">
														<label for="nic" class="font-weight-500">NIC
															Number</label> <input type="text"
															class="form-control form-control-lg" id="nic" name="nic"
															placeholder="NIC Number" value="<%=nic%>">
														<%=(nicError != null) ? "<span style=\"color: red;\">" + nicError + "</span>" : ""%>
													</div>
													<%
													if (updateUserEmail == null) {
													%>
													<div class="form-group">
														<label for="confirm_password" class="font-weight-500">Confirm
															Password</label> <input type="text"
															class="form-control form-control-lg"
															id="confirm_password" name="confirm_password"
															placeholder="Confirm Password"
															value="<%=confirmPassword%>">
														<%=(confirmPasswordError != null) ? "<span style=\"color: red;\">" + confirmPasswordError + "</span>" : ""%>
													</div>
													<%
													}
													%>
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
			text : "<%=status%>
		",
			icon : "success"
		});
	</script>
	<%
	}
	if (isInvalidUser) {
	%>
	<script type="text/javascript">
		Swal.fire({
			title : "Failed!",
			text : "These credentials do not match our records.",
			icon : "error"
		});
	</script>
	<%
	}
	%>
</body>
</html>