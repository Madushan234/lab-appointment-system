<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.util.SessionMapUtils"%>
<%@ page import="com.labappointmentsystem.util.UserAuthManager"%>
<%
boolean isAuth = UserAuthManager.getInstance().isAuthenticated(session);
if (isAuth) {
	response.sendRedirect("dashboard.jsp");
}

String successMessage = (String) session.getAttribute("forgot-password-success");
if (successMessage != null) {
	session.removeAttribute("forgot-password-success");
}

Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
String emailError = SessionMapUtils.getFiledValue(fieldErrors, "email_address");
String passwordError = SessionMapUtils.getFiledValue(fieldErrors, "password");
session.removeAttribute("fieldErrors");

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
								<img src="assets/image/logo.png" alt="logo" class="w-50 mb-4">
								<h4 class="mb-2">Welcome to the ABC Laboratories</h4>
								<h6 class="font-weight-normal mb-2">Sign in to continue</h6>
							</div>
							<% if (successMessage != null) { %>
							<div
								class="align-items-center justify-content-center text-center border border-success py-2 my-3">
								<span class="text-success font-weight-bold"><%=successMessage%></span>
							</div>
							<% } %>
							<form class="pt-3" action="login" method="post">
								<div class="form-group">
									<input type="email" class="form-control form-control-lg"
										id="email_address" name="email_address"
										placeholder="Email Address">
									<%=(emailError != null) ? "<span class=\"text-danger\">" + emailError + "</span>" : ""%>
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-lg"
										id="password" name="password" placeholder="Password">
									<%=(passwordError != null) ? "<span class=\"text-danger\">" + passwordError + "</span>" : ""%>
								</div>
								<div class="mt-3">
									<input type="submit"
										class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn"
										value="SIGN IN">
								</div>
								<div
									class="my-2 d-flex justify-content-between align-items-center">
									<div class="form-check">
										<label class="form-check-label text-muted font-weight-normal">
											<input type="checkbox" class="form-check-input ml-2 mt-1"
											name="remember"> Keep me signed in
										</label>
									</div>
									<a href="forgot-password.jsp" class="auth-link text-black">Forgot
										password?</a>
								</div>
								<div class="text-center mt-4 font-weight-normal">
									Don't have an account? <a href="sign-up.jsp"
										class="text-primary">Sign Up Instead</a>
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