<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String userEmail = (String) session.getAttribute("user-email");
String userFirstName = (String) session.getAttribute("user-first-name");
String userRole = (String) session.getAttribute("user-role");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC Laboratory - Contact Us</title>
<script src="assets/js/js/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link
	href="front-assets/package/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="front-assets/package/animate/animate.min.css"
	rel="stylesheet">
<link
	href="front-assets/package/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />
<link href="front-assets/package/twentytwenty/twentytwenty.css"
	rel="stylesheet" />
<link href="front-assets/package/bootstrap.min.css" rel="stylesheet">
<link href="front-assets/package/style.css" rel="stylesheet">
<link rel="shortcut icon" href="assets/image/favicon.png">
</head>
<body>

	<div class="container-fluid bg-light ps-5 pe-0 d-none d-lg-block">
		<div class="row gx-0">
			<div class="col-md-6 text-center text-lg-start mb-2 mb-lg-0">
				<div class="d-inline-flex align-items-center">
					<small class="py-2"><i
						class="far fa-clock text-primary me-2"></i> Opening Hours: Mon -
						Sat : 9.00am - 8.00 pm, Sunday Closed </small>
				</div>
			</div>
			<div class="col-md-6 text-center text-lg-end">
				<div
					class="position-relative d-inline-flex align-items-center bg-primary text-white top-shape px-5">
					<div class="me-3 pe-3 border-end py-2">
						<p class="m-0">
							<i class="fa fa-envelope-open me-2"></i>abclaboratoryuk@gmail.com
						</p>
					</div>
					<div class="py-2">
						<p class="m-0">
							<i class="fa fa-phone-alt me-2"></i>(+94) (011) 2583443
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<nav
		class="navbar navbar-expand-lg bg-white navbar-light shadow-sm px-5 py-3 py-lg-0">
		<a href="index.jsp" class="navbar-brand p-0"> <img
			src="assets/image/logo.png" class="ml-4" alt="logo"
			style="height: 60px; width: 300px;" />
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarCollapse">
			<div class="navbar-nav ms-auto py-0">
				<a href="index.jsp" class="nav-item nav-link active">Home</a> <a
					href="index.jsp#about-us" class="nav-item nav-link">About Us</a> <a
					href="index.jsp#our-service" class="nav-item nav-link">Our
					Services</a> <a href="contact.jsp" class="nav-item nav-link">Contact
					Us</a>
			</div>

			<div class="d-flex">
				<a href="dashboard.jsp" class="btn btn-primary py-2 px-4 ms-3">Appointment</a>
				<%
				if (userFirstName == null || userEmail == null) {
				%>
				<a href="login.jsp" class="btn btn-outline-primary py-2 px-4 ms-3">Sign
					In</a> <a href="sign-up.jsp"
					class="btn btn-outline-primary py-2 px-4 ms-3">Sign Up</a>
				<%
				} else {
				%>
				<a href="dashboard.jsp"
					class="btn btn-outline-primary py-2 px-4 ms-3">Dashboard</a>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle"
						data-bs-toggle="dropdown">Hi, <%=userFirstName%></a>
					<div class="dropdown-menu m-0">
						<a href="logout" class="dropdown-item">Log Out</a>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</nav>


	<div class="container-fluid bg-primary py-5 hero-header mb-5">
		<div class="row py-3">
			<div class="col-12 text-center">
				<h1 class="display-3 text-white animated zoomIn">Contact Us</h1>
				<a href="index.jsp" class="h4 text-white">Home</a> <i
					class="far fa-circle text-white px-2"></i> <a href="contact.jsp"
					class="h4 text-white">Contact</a>
			</div>
		</div>
	</div>


	<div class="container-fluid py-5">
		<div class="container">
			<div class="row g-5">
				<div class="col-xl-4 col-lg-6 wow slideInUp" data-wow-delay="0.1s">
					<div class="bg-light rounded h-100 p-5">
						<div class="section-title">
							<h5
								class="position-relative d-inline-block text-primary text-uppercase">Contact
								Us</h5>
							<h1 class="display-6 mb-4">Feel Free To Contact Us</h1>
						</div>
						<div class="d-flex align-items-center mb-2">
							<i class="bi bi-geo-alt fs-1 text-primary me-3"></i>
							<div class="text-start">
								<h5 class="mb-0">Address</h5>
								<span>43/5 Galle Road, Colombo 2, Sri Lanka</span>
							</div>
						</div>
						<div class="d-flex align-items-center mb-2">
							<i class="bi bi-envelope-open fs-1 text-primary me-3"></i>
							<div class="text-start">
								<h5 class="mb-0">Email Us</h5>
								<span>abclaboratoryuk@gmail.com</span>
							</div>
						</div>
						<div class="d-flex align-items-center">
							<i class="bi bi-phone-vibrate fs-1 text-primary me-3"></i>
							<div class="text-start">
								<h5 class="mb-0">Call Us</h5>
								<span>(+94) (011) 2583443</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xl-4 col-lg-6 wow slideInUp" data-wow-delay="0.3s">
					<form>
						<div class="row g-3">
							<div class="col-12">
								<input type="text" class="form-control border-0 bg-light px-4"
									placeholder="Your Name" style="height: 55px;">
							</div>
							<div class="col-12">
								<input type="email" class="form-control border-0 bg-light px-4"
									placeholder="Your Email" style="height: 55px;">
							</div>
							<div class="col-12">
								<input type="text" class="form-control border-0 bg-light px-4"
									placeholder="Subject" style="height: 55px;">
							</div>
							<div class="col-12">
								<textarea class="form-control border-0 bg-light px-4 py-3"
									rows="5" placeholder="Message"></textarea>
							</div>
							<div class="col-12">
								<button class="btn btn-primary w-100 py-3" type="submit">Send
									Message</button>
							</div>
						</div>
					</form>
				</div>
				<div class="col-xl-4 col-lg-12 wow slideInUp" data-wow-delay="0.6s">
					<iframe class="position-relative rounded w-100 h-100"
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3961.094397783285!2d79.85741797568119!3d6.8792935189250715!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae25bc7057d53ab%3A0x4df2d2250a798876!2s43%2C%205%20Galle%20Rd%2C%20Colombo!5e0!3m2!1sen!2slk!4v1710836249848!5m2!1sen!2slk"
						frameborder="0" style="min-height: 400px; border: 0;"
						allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
				</div>
			</div>
		</div>
	</div>


	<div class="container-fluid bg-dark text-light py-5 wow fadeInUp"
		data-wow-delay="0.3s">
		<div class="container pt-5">
			<div class="row g-5 pt-4">
				<div class="col-lg-4 col-md-6">
					<h3 class="text-white mb-4">Get In Touch</h3>
					<p class="mb-2">
						<i class="bi bi-geo-alt text-primary me-2"></i>43/5 Galle Road,
						Colombo 2, Sri Lanka
					</p>
					<p class="mb-2">
						<i class="bi bi-envelope-open text-primary me-2"></i>abclaboratoryuk@gmail.com
					</p>
					<p class="mb-0">
						<i class="bi bi-telephone text-primary me-2"></i>(+94) (011)
						2583443
					</p>
				</div>
				<div class="col-lg-4 col-md-6">
					<h3 class="text-white mb-4">Quick Links</h3>
					<div class="d-flex flex-column justify-content-start">
						<a class="text-light mb-2" href="#"><i
							class="bi bi-arrow-right text-primary me-2"></i>Home</a> <a
							class="text-light mb-2" href="#"><i
							class="bi bi-arrow-right text-primary me-2"></i>About Us</a> <a
							class="text-light mb-2" href="#"><i
							class="bi bi-arrow-right text-primary me-2"></i>Our Services</a> <a
							class="text-light" href="#"><i
							class="bi bi-arrow-right text-primary me-2"></i>Contact Us</a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<h3 class="text-white mb-4">Follow Us</h3>
					<div class="d-flex">
						<a
							class="btn btn-lg btn-primary btn-lg-square rounded rounded-circle me-2"
							href="https://www.facebook.com"><i
							class="fab fa-facebook-f fw-normal"></i></a> <a
							class="btn btn-lg btn-primary btn-lg-square rounded rounded-circle me-2"
							href="https://www.instagram.com"><i
							class="fab fa-instagram fw-normal"></i></a> <a
							class="btn btn-lg btn-primary btn-lg-square rounded rounded-circle me-2"
							href="https://www.linkedin.com"><i
							class="fab fa-linkedin-in fw-normal"></i></a> <a
							class="btn btn-lg btn-primary btn-lg-square rounded rounded-circle"
							href="https://www.youtube.com"><i
							class="fab fa-youtube fw-normal"></i></a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container-fluid text-light py-4 bg-dark"
		style="background: #051225;">
		<div class="container">
			<div class="row g-0">
				<div class="justify-content-center mb-0 text-center">
					<p>
						&copy; 2024 <a class="text-white border-bottom" href="#">ABC
							Laboratories</a>. All Rights Reserved.
					</p>
				</div>
			</div>
		</div>
	</div>


	<a href="#"
		class="btn btn-lg btn-primary btn-lg-square rounded back-to-top rounded-circle"><i
		class="bi bi-arrow-up"></i></a>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="front-assets/package/wow/wow.min.js"></script>
	<script src="front-assets/package/easing/easing.min.js"></script>
	<script src="front-assets/package/waypoints/waypoints.min.js"></script>
	<script src="front-assets/package/owlcarousel/owl.carousel.min.js"></script>
	<script src="front-assets/package/tempusdominus/js/moment.min.js"></script>
	<script
		src="front-assets/package/tempusdominus/js/moment-timezone.min.js"></script>
	<script
		src="front-assets/package/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
	<script src="front-assets/package/twentytwenty/jquery.event.move.js"></script>
	<script src="front-assets/package/twentytwenty/jquery.twentytwenty.js"></script>
	<script src="front-assets/package/main.js"></script>
	<script src="assets/js/js/todolist.js"></script>
</body>
</html>