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

Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
String emailError = SessionMapUtils.getFiledValue(fieldErrors, "email_address");
session.removeAttribute("fieldErrors");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC - Forgot Password</title>
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
								<h4 class="mb-2">Forgot Password</h4>
								<h6 class="font-weight-normal mb-2">Enter your email
									address to recover your account</h6>
							</div>
							<form class="pt-3" action="forgot-password" method="post">
								<div class="form-group">
									<input type="email" class="form-control form-control-lg"
										id="email_address" name="email_address"
										placeholder="Email Address">
									<%=(emailError != null) ? "<span class=\"text-danger\">" + emailError + "</span>" : ""%>
								</div>
								<div class="mt-3">
									<input type="submit"
										class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn"
										value="Forgot Password">
								</div>
								<div class="my-3 text-center">
									<a href="login.jsp" class="auth-link text-black">Back to
										Sign In</a>
								</div>
								<div class="text-center mt-3 font-weight-normal">
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