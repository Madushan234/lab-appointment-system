<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.util.SessionMapUtils"%>
<%@ page import="com.labappointmentsystem.dao.MedicalTestDao"%>
<%@ page import="com.labappointmentsystem.model.MedicalTest"%>
<%@ page import="java.util.List"%>
<%@ page import="com.labappointmentsystem.util.UserAuthManager"%>

<%
boolean isAuth = UserAuthManager.getInstance().isAuthenticated(session);
if (isAuth) {
	response.sendRedirect("dashboard.jsp");
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
String bookingDateError = SessionMapUtils.getFiledValue(fieldErrors, "booking_date");
String bookingTimeError = SessionMapUtils.getFiledValue(fieldErrors, "booking_time");
String medicalTestError = SessionMapUtils.getFiledValue(fieldErrors, "medical_test");
String recommendedDoctorError = SessionMapUtils.getFiledValue(fieldErrors, "recommended_doctor");
session.removeAttribute("fieldErrors");

String status = (String) session.getAttribute("user-create-status");
session.removeAttribute("user-create-status");
if (status != null) {
	session.removeAttribute("createUserFileds");
}

String first_name, last_name, email_address, password, confirm_password, telephone_number, nic, date_of_birth,
		booking_date, booking_time, recommended_doctor;
first_name = last_name = email_address = password = confirm_password = telephone_number = nic = date_of_birth = booking_date = booking_time = recommended_doctor = "";
Map<String, String> inputs = (Map<String, String>) session.getAttribute("createUserFileds");
first_name = SessionMapUtils.getFiledValue(inputs, "first_name");
last_name = SessionMapUtils.getFiledValue(inputs, "last_name");
email_address = SessionMapUtils.getFiledValue(inputs, "email_address");
password = SessionMapUtils.getFiledValue(inputs, "password");
confirm_password = SessionMapUtils.getFiledValue(inputs, "confirm_password");
telephone_number = SessionMapUtils.getFiledValue(inputs, "telephone_number");
nic = SessionMapUtils.getFiledValue(inputs, "nic");
date_of_birth = SessionMapUtils.getFiledValue(inputs, "date_of_birth");
booking_date = SessionMapUtils.getFiledValue(inputs, "booking_date");
booking_time = SessionMapUtils.getFiledValue(inputs, "booking_time");
recommended_doctor = SessionMapUtils.getFiledValue(inputs, "recommended_doctor");
session.removeAttribute("createUserFileds");

List<MedicalTest> medicalTestList = MedicalTestDao.getAllActiveMedicalTest();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC - Sign up</title>
<script src="assets/js/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="assets/css/vendors/feather/feather.css">
<link rel="stylesheet"
	href="assets/css/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" href="assets/css/vendors/vendor.bundle.base.css">
<link rel="stylesheet"
	href="assets/css/vendors/vertical-layout-light/style.css">
<link rel="shortcut icon" href="assets/image/favicon.png" />
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />

</head>
<body>
	<div class="container-scroller">
		<div class="container-fluid page-body-wrapper full-page-wrapper">
			<div class="content-wrapper d-flex align-items-center auth px-0">
				<div class="row w-100 mx-0">
					<div class="col-lg-4 mx-auto">
						<div
							class="auth-form-light text-left py-5 px-4 px-sm-5 rounded-xl">
							<div
								class="align-items-center d-flex flex-column justify-content-center text-center">
								<img src="assets/image/logo.png" alt="logo" class="w-50 mb-4">
								<h4 class="mb-2">Sign Up</h4>
								<h6 class="font-weight-normal mb-2">Sign up is easy. It
									only takes a few steps</h6>
							</div>
							<form class="pt-3" action="sign-up" method="post">
								<div class="form-group">
									<label for="first_name" class="font-weight-500">First
										Name</label> <input type="text" class="form-control form-control-lg"
										id="first_name" name="first_name" placeholder="First Name"
										value="<%=first_name%>">
									<%=(firstNameError != null) ? "<span class=\"text-danger\">" + firstNameError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<label for="last_name" class="font-weight-500">Last
										Name</label> <input type="text" class="form-control form-control-lg"
										id="last_name" name="last_name" placeholder="Last Name"
										value="<%=last_name%>">
									<%=(lastNameError != null) ? "<span class=\"text-danger\">" + lastNameError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<label for="email_address" class="font-weight-500">Email
										Address</label> <input type="email"
										class="form-control form-control-lg" id="email_address"
										name="email_address" placeholder="Email Address"
										value="<%=email_address%>">
									<%=(emailError != null) ? "<span class=\"text-danger\">" + emailError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<label for="password" class="font-weight-500">Password</label>
									<input type="password" class="form-control form-control-lg"
										id="password" name="password" placeholder="Password"
										value="<%=password%>">
									<%=(passwordError != null) ? "<span class=\"text-danger\">" + passwordError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<label for="confirm_password" class="font-weight-500">Confirm
										Password</label> <input type="password"
										class="form-control form-control-lg" id="confirm_password"
										name="confirm_password" placeholder="Confirm Password"
										value="<%=confirm_password%>">
									<%=(confirmPasswordError != null) ? "<span class=\"text-danger\">" + confirmPasswordError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<label for="telephone_number" class="font-weight-500">Telephone
										Number</label> <input type="tel" class="form-control form-control-lg"
										id="telephone_number" name="telephone_number"
										placeholder="Telephone Number" value="<%=telephone_number%>">
									<%=(telephoneNumberError != null) ? "<span class=\"text-danger\">" + telephoneNumberError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<label for="nic" class="font-weight-500">NIC Number</label> <input
										type="text" class="form-control form-control-lg" id="nic"
										name="nic" placeholder="NIC Number" value="<%=nic%>">
									<%=(nicError != null) ? "<span class=\"text-danger\">" + nicError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<label for="date_of_birth" class="font-weight-500">Date
										of Birth</label> <input type="date"
										class="form-control form-control-lg" id="date_of_birth"
										name="date_of_birth" placeholder="Date of Birth"
										value="<%=date_of_birth%>">
									<%=(dobError != null) ? "<span class=\"text-danger\">" + dobError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<p
										class="border border-info px-3 py-2 text-center text-info font-weight-bold mt-5">
										If you want to book your first appointment, please fill out
										the fields below</p>
								</div>
								<div class="form-group">
									<label for="booking_date" class="font-weight-500">Booking
										Date</label> <input type="date" class="form-control form-control-lg"
										id="booking_date" name="booking_date"
										placeholder="Booking Date" value="<%=booking_date%>">
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
									<label for="recommended_doctor" class="font-weight-500">Recommended Doctor</label> <input type="text" class="form-control form-control-lg"
										id="recommended_doctor" name="recommended_doctor"
										placeholder="Recommended Doctor" value="<%=recommended_doctor%>">
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

								<div class="mt-3">
									<input type="submit"
										class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn"
										value="SIGN UP">
								</div>
								<div class="text-center mt-4 font-weight-normal">
									Already have an account? <a href="login.jsp"
										class="text-primary"> Sign In Instead</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

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
			text :  "<%= status %>",
			icon : "success"
		});
	</script>
	<%
	}
	%>
</body>
</html>






