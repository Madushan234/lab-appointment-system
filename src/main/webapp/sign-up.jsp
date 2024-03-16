<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%
if (session.getAttribute("user-email") != null) {
	response.sendRedirect("dashboard.jsp");
}

Map<String, String> fieldErrors = (Map<String, String>) request.getAttribute("fieldErrors");
String firstNameError = (fieldErrors != null && fieldErrors.containsKey("first_name")) ? fieldErrors.get("first_name")
		: null;
String lastNameError = (fieldErrors != null && fieldErrors.containsKey("last_name")) ? fieldErrors.get("last_name")
		: null;
String emailError = (fieldErrors != null && fieldErrors.containsKey("email_address")) ? fieldErrors.get("email_address")
		: null;
String passwordError = (fieldErrors != null && fieldErrors.containsKey("password")) ? fieldErrors.get("password")
		: null;
String confirmPasswordError = (fieldErrors != null && fieldErrors.containsKey("confirm_password"))
		? fieldErrors.get("confirm_password")
		: null;
String telephoneNumberError = (fieldErrors != null && fieldErrors.containsKey("telephone_number"))
		? fieldErrors.get("telephone_number")
		: null;
String nicError = (fieldErrors != null && fieldErrors.containsKey("nic"))
		? fieldErrors.get("nic")
		: null;
String dobError = (fieldErrors != null && fieldErrors.containsKey("date_of_birth"))
? fieldErrors.get("date_of_birth")
: null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC - Login</title>
<script src="assets/js/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="assets/css/vendors/sweetalert2.min.css">
<link rel="stylesheet" href="assets/css/vendors/feather/feather.css">
<link rel="stylesheet"
	href="assets/css/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" href="assets/css/vendors/vendor.bundle.base.css">
<link rel="stylesheet"
	href="assets/css/vendors/vertical-layout-light/style.css">
<link rel="shortcut icon" href="assets/image/favicon.png" />
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
								<img src="assets/image/logo.svg" alt="logo" class="w-30 mb-4">
								<h4 class="mb-2">Sign Up</h4>
								<h6 class="font-weight-normal mb-2">Sign up is easy. It
									only takes a few steps</h6>
							</div>
							<form class="pt-3" action="sign-up" method="post">
								<div class="form-group">
									<label for="first_name" class="font-weight-500">First Name</label>
									<input type="text" class="form-control form-control-lg"
										id="first_name" name="first_name" placeholder="First Name">
									<%
									if (firstNameError != null) {
									%>
									<span style="color: red;"><%=firstNameError%></span>
									<%
									}
									%>
								</div>
								<div class="form-group">
									<label for="last_name" class="font-weight-500">Last Name</label>
									<input type="text" class="form-control form-control-lg"
										id="last_name" name="last_name" placeholder="Last Name">
									<%
									if (lastNameError != null) {
									%>
									<span style="color: red;"><%=lastNameError%></span>
									<%
									}
									%>
								</div>
								<div class="form-group">
									<label for="email_address" class="font-weight-500">Email Address</label>
									<input type="email" class="form-control form-control-lg"
										id="email_address" name="email_address"
										placeholder="Email Address">
									<%
									if (emailError != null) {
									%>
									<span style="color: red;"><%=emailError%></span>
									<%
									}
									%>
								</div>
								<div class="form-group">
									<label for="password" class="font-weight-500">Password</label>
									<input type="password" class="form-control form-control-lg"
										id="password" name="password" placeholder="Password">
									<%
									if (passwordError != null) {
									%>
									<span style="color: red;"><%=passwordError%></span>
									<%
									}
									%>
								</div>
								<div class="form-group">
									<label for="confirm_password" class="font-weight-500">Confirm Password</label>
									<input type="password" class="form-control form-control-lg"
										id="confirm_password" name="confirm_password"
										placeholder="Confirm Password">
									<%
									if (confirmPasswordError != null) {
									%>
									<span style="color: red;"><%=confirmPasswordError%></span>
									<%
									}
									%>
								</div>
								<div class="form-group">
									<label for="telephone_number" class="font-weight-500">Telephone Number</label>
									<input type="tel" class="form-control form-control-lg"
										id="telephone_number" name="telephone_number"
										placeholder="Telephone Number">
									<%
									if (telephoneNumberError != null) {
									%>
									<span style="color: red;"><%=telephoneNumberError%></span>
									<%
									}
									%>
								</div>
								<div class="form-group">
									<label for="nic" class="font-weight-500">NIC Number</label>
									<input type="text" class="form-control form-control-lg"
										id="nic" name="nic" placeholder="NIC Number">
									<%
									if (nicError != null) {
									%>
									<span style="color: red;"><%=nicError%></span>
									<%
									}
									%>
								</div>
								<div class="form-group">
									<label for="date_of_birth" class="font-weight-500">Date of Birth</label>
									<input type="date" class="form-control form-control-lg"
										id="date_of_birth" name="date_of_birth"
										placeholder="Date of Birth">
									<%
									if (dobError != null) {
									%>
									<span style="color: red;"><%=dobError%></span>
									<%
									}
									%>
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
</body>
</html>