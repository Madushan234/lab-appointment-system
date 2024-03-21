<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.labappointmentsystem.util.UserAuthManager"%>	
<%
boolean isAuth = UserAuthManager.getInstance().isAuthenticated(session);
String userFirstName = (String) session.getAttribute("user-first-name"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>ABC Laboratory - Home</title>
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
					href="index.jsp#about-us" class="nav-item nav-link">About Us</a> 
					<a href="index.jsp#our-service" class="nav-item nav-link">Our
					Services</a> <a href="contact.jsp" class="nav-item nav-link">Contact
					Us</a>
			</div>

			<div class="d-flex">
				<a href="dashboard.jsp" class="btn btn-primary py-2 px-4 ms-3">Appointment</a>
				<%
				if (isAuth) {
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
				} else {
				%>
				<a href="login.jsp" class="btn btn-outline-primary py-2 px-4 ms-3">Sign
					In</a> <a href="sign-up.jsp"
					class="btn btn-outline-primary py-2 px-4 ms-3">Sign Up</a>
				<%
				}
				%>
			</div>
		</div>
	</nav>


	<div class="container-fluid p-0">
		<div id="header-carousel" class="carousel slide carousel-fade"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img class="w-100" src="front-assets/image/carousel-1.jpg"
						alt="Image">
					<div
						class="carousel-caption d-flex flex-column align-items-center justify-content-center">
						<div class="p-3" style="max-width: 900px;">
							<h5 class="text-white text-uppercase mb-3 animated slideInDown">Your
								Health, Our Expertise</h5>
							<h1 class="display-1 text-white mb-md-4 animated zoomIn">
								Trusting Your Health to Our Expertise</h1>
							<a href="dashboard.jsp"
								class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Appointment</a>
							<a href="contact.jsp"
								class="btn btn-secondary py-md-3 px-md-5 animated slideInRight">Contact
								Us</a>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<img class="w-100" src="front-assets/image/carousel-2.jpg"
						alt="Image">
					<div
						class="carousel-caption d-flex flex-column align-items-center justify-content-center">
						<div class="p-3" style="max-width: 900px;">
							<h5 class="text-white text-uppercase mb-3 animated slideInDown">Your
								Wellness, Our Priority</h5>
							<h1 class="display-1 text-white mb-md-4 animated zoomIn">Take
								The Best Quality Medical Test</h1>
							<a href="dashboard.jsp"
								class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Appointment</a>
							<a href="contact.jsp"
								class="btn btn-secondary py-md-3 px-md-5 animated slideInRight">Contact
								Us</a>
						</div>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#header-carousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#header-carousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>


	<div class="container-fluid banner mb-5">
		<div class="container">
			<div class="row gx-0">
				<div class="col-lg-4 wow zoomIn" data-wow-delay="0.1s">
					<div class="bg-primary d-flex flex-column p-5"
						style="height: 300px;">
						<h3 class="text-white mb-3">Opening Hours</h3>
						<div class="d-flex justify-content-between text-white mb-3">
							<h6 class="text-white mb-0">Mon - Sat</h6>
							<p class="mb-0">9:00am - 8:00pm</p>
						</div>
						<div class="d-flex justify-content-between text-white mb-3">
							<h6 class="text-white mb-0">Sunday</h6>
							<p class="mb-0">closed</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 wow zoomIn" data-wow-delay="0.3s">
					<div class="bg-dark d-flex flex-column p-5" style="height: 300px;">
						<h3 class="text-white mb-3">Online Appointment</h3>
						<p class="text-white">Take control of your health journey by
							booking your appointment online today.Our streamlined booking
							process ensures convenience and flexibility for our patients.</p>
						<a class="btn btn-light" href="dashboard.jsp">Appointment</a>
					</div>
				</div>
				<div class="col-lg-4 wow zoomIn" data-wow-delay="0.6s">
					<div class="bg-secondary d-flex flex-column p-5"
						style="height: 300px;">
						<h3 class="text-white mb-3">Make Appointment</h3>
						<p class="text-white">For appointments or inquiries, please
							feel free to contact us. Our team is ready to assist you.</p>
						<h2 class="text-white mb-0">(+94) (011)
						2583443</h2>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div
		class="container-fluid bg-primary bg-appointment my-5 wow fadeInUp"
		data-wow-delay="0.1s">
		<div class="container">
			<div class="row gx-5">
				<div class="col-lg-12 py-5">
					<div class="py-5">
						<h1 class="display-5 text-white mb-4">We Are A Certified and
							Award Winning Medical Laboratory You Can Trust</h1>
						<p class="text-white mb-0">Our medical tests are conducted
							with utmost care and precision to ensure accurate results. We
							understand the importance of your health, which is why we offer a
							wide range of tests at fair prices. Whether it's routine
							check-ups or specialized diagnostics, our team is dedicated to
							providing reliable services tailored to your needs.</p>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s" id="about-us">
		<div class="container">
			<div class="row g-5">
				<div class="col-lg-7">
					<div class="section-title mb-4">
						<h5
							class="position-relative d-inline-block text-primary text-uppercase">About
							Us</h5>
						<h1 class="display-5 mb-0">The World's Best Medical
							Laboratory That You Can Trust</h1>
					</div>
					<h4 class="text-body fst-italic mb-4">Providing Exceptional
						Medical Testing Services You Can Rely On</h4>
					<p class="mb-4">At our medical laboratory, we are dedicated to
						offering high-quality testing services with precision and
						accuracy. With a team of experienced professionals and advanced
						equipment, we ensure reliable results for all our patients.
						Whether it's routine check-ups or specialized diagnostics, we
						prioritize your health and well-being.</p>
					<div class="row g-3">
						<div class="col-sm-6 wow zoomIn" data-wow-delay="0.3s">
							<h5 class="mb-3">
								<i class="fa fa-check-circle text-primary me-3"></i>Award
								Winning
							</h5>
							<h5 class="mb-3">
								<i class="fa fa-check-circle text-primary me-3"></i>Experienced
								Staff
							</h5>
						</div>
						<div class="col-sm-6 wow zoomIn" data-wow-delay="0.6s">
							<h5 class="mb-3">
								<i class="fa fa-check-circle text-primary me-3"></i>Accurate
								Results
							</h5>
							<h5 class="mb-3">
								<i class="fa fa-check-circle text-primary me-3"></i>Fair Prices
							</h5>
						</div>
					</div>
					<a href="dashboard.jsp"
						class="btn btn-primary py-3 px-5 mt-4 wow zoomIn"
						data-wow-delay="0.6s">Make Appointment</a>
				</div>
				<div class="col-lg-5" style="min-height: 500px;">
					<div class="position-relative h-100">
						<img class="position-absolute w-100 h-100 rounded wow zoomIn"
							data-wow-delay="0.9s" src="front-assets/image/about.jpg"
							style="object-fit: cover;">
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container-fluid bg-offer my-5 py-5 wow fadeInUp"
		data-wow-delay="0.1s">
		<div class="container py-5">
			<div class="row justify-content-center">
				<div class="col-lg-7 wow zoomIn" data-wow-delay="0.6s">
					<div class="offer-text text-center rounded p-5">
						<h1 class="display-5 text-white">Get 10% Off Your First
							Medical Test</h1>
						<p class="text-white mb-4">We strive to provide accurate and
							reliable medical testing services using state-of-the-art
							equipment and a team of experienced professionals. Your health
							and well-being are our top priorities, and we ensure a
							comfortable and efficient testing experience for all our
							patients.</p>
						<a href="dashboard.jsp" class="btn btn-dark py-3 px-5 me-3">Schedule
							Test</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s"
		id="our-service">
		<div class="container">
			<div class="row g-5">
				<div class="col-lg-5">
					<div class="section-title mb-4">
						<h5
							class="position-relative d-inline-block text-primary text-uppercase">Our
							Services & Pricing Plan</h5>
						<h1 class="display-5 mb-0">We Offer Fair Prices for Medical
							Test</h1>
					</div>
					<p class="mb-4">Our medical tests are conducted with utmost
						care and precision to ensure accurate results. We understand the
						importance of your health, which is why we offer a wide range of
						tests at fair prices. Whether it's routine check-ups or
						specialized diagnostics, our team is dedicated to providing
						reliable services tailored to your needs.</p>
					<h5 class="text-uppercase text-primary wow fadeInUp"
						data-wow-delay="0.3s">Call for Appointment</h5>
					<h1 class="wow fadeInUp" data-wow-delay="0.6s">(+94) (011)
						2583443</h1>
				</div>

				<div class="col-lg-7">
					<div class="owl-carousel price-carousel wow zoomIn"
						data-wow-delay="0.9s">
						<div class="price-item pb-4">
							<div class="position-relative">
								<img class="img-fluid rounded-top"
									src="front-assets/image/price-1.jpg" alt="">
							</div>
							<div
								class="position-relative text-center bg-light border-bottom border-primary py-5 p-4">
								<h4>Blood Test</h4>
								<hr class="text-primary w-50 mx-auto mt-0">
								<div class="d-flex justify-content-between mb-3">
									<span>Accurate Results</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<div class="d-flex justify-content-between mb-3">
									<span>Experienced Lab Technicians</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<div class="d-flex justify-content-between mb-2">
									<span>Fast Turnaround Time</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<a href="dashboard.jsp"
									class="btn btn-primary py-2 px-4 position-absolute top-100 start-50 translate-middle">Appointment</a>
							</div>
						</div>
						<div class="price-item pb-4">
							<div class="position-relative">
								<img class="img-fluid rounded-top"
									src="front-assets/image/price-2.jpg" alt="">
							</div>
							<div
								class="position-relative text-center bg-light border-bottom border-primary py-5 p-4">
								<h4>Urine Analysis</h4>
								<hr class="text-primary w-50 mx-auto mt-0">
								<div class="d-flex justify-content-between mb-3">
									<span>Advanced Testing Methods</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<div class="d-flex justify-content-between mb-3">
									<span>Confidentiality Guaranteed</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<div class="d-flex justify-content-between mb-2">
									<span>Online Results Access</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<a href="dashboard.jsp"
									class="btn btn-primary py-2 px-4 position-absolute top-100 start-50 translate-middle">Appointment</a>
							</div>
						</div>
						<div class="price-item pb-4">
							<div class="position-relative">
								<img class="img-fluid rounded-top"
									src="front-assets/image/price-3.jpg" alt="">
							</div>
							<div
								class="position-relative text-center bg-light border-bottom border-primary py-5 p-4">
								<h4>X-ray Examination</h4>
								<hr class="text-primary w-50 mx-auto mt-0">
								<div class="d-flex justify-content-between mb-3">
									<span>State-of-the-art Imaging Technology</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<div class="d-flex justify-content-between mb-3">
									<span>Board-certified Radiologists</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<div class="d-flex justify-content-between mb-2">
									<span>Emergency Services Available</span><i
										class="fa fa-check text-primary pt-1"></i>
								</div>
								<a href="dashboard.jsp"
									class="btn btn-primary py-2 px-4 position-absolute top-100 start-50 translate-middle">Appointment</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div
		class="container-fluid bg-primary bg-testimonial py-5 mt-5 wow fadeInUp"
		data-wow-delay="0.1s">
		<div class="container py-5">
			<div class="row justify-content-center">
				<div class="col-lg-7">
					<div
						class="owl-carousel testimonial-carousel rounded p-5 wow zoomIn"
						data-wow-delay="0.6s">
						<div class="testimonial-item text-center text-white">
							<img class="img-fluid mx-auto rounded mb-4"
								src="front-assets/image/person1.png" alt="">
							<p class="fs-5">"ABC Medical Laboratory provides outstanding
								services. The staff is knowledgeable, the facility is clean, and
								the results are delivered promptly. I highly recommend their
								services for accurate and reliable testing."</p>
							<p class="fs-5">Rating: 5/5</p>
							<hr class="mx-auto w-25">
							<h4 class="text-white mb-0">Sarah Johnson</h4>
						</div>
						<div class="testimonial-item text-center text-white">
							<img class="img-fluid mx-auto rounded mb-4"
								src="front-assets/image/person2.png" alt="">
							<p class="fs-5">"I had a positive experience with ABC Medical
								Laboratory. The staff was friendly, and the process was
								efficient. The only minor drawback was a slight delay in
								receiving my results. Overall, a good choice for medical
								testing."</p>
							<p class="fs-5">Rating: 4/5</p>
							<hr class="mx-auto w-25">
							<h4 class="text-white mb-0">Alex Rodriguez</h4>
						</div>
						<div class="testimonial-item text-center text-white">
							<img class="img-fluid mx-auto rounded mb-4"
								src="front-assets/image/person3.png" alt="">
							<p class="fs-5">"Impressive professionalism and attention to
								detail at ABC Medical Laboratory. The staff went above and
								beyond to make me feel comfortable during my visit. Quick
								turnaround on results, and the facility adheres to high hygiene
								standards."</p>
							<p class="fs-5">Rating: 3/5</p>
							<hr class="mx-auto w-25">
							<h4 class="text-white mb-0">Emily Davis</h4>
						</div>
						<div class="testimonial-item text-center text-white">
							<img class="img-fluid mx-auto rounded mb-4"
								src="front-assets/image/person4.png" alt="">
							<p class="fs-5">"ABC Medical Laboratory is decent but has
								room for improvement. The service was satisfactory, but the wait
								time was longer than expected. Results accuracy is reliable, but
								faster service would enhance the overall experience."</p>
							<p class="fs-5">Rating: 4/5</p>
							<hr class="mx-auto w-25">
							<h4 class="text-white mb-0">Robert Chang</h4>
						</div>
						<div class="testimonial-item text-center text-white">
							<img class="img-fluid mx-auto rounded mb-4"
								src="front-assets/image/person5.png" alt="">
							<p class="fs-5">"Exceptional service at ABC Medical
								Laboratory! From the moment I walked in, the staff was courteous
								and professional. The facility is well-maintained, and the
								results were delivered promptly. I will definitely return for
								future testing needs."</p>
							<p class="fs-5">Rating: 5/5</p>
							<hr class="mx-auto w-25">
							<h4 class="text-white mb-0">Jennifer Mills</h4>
						</div>
					</div>
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
						<a class="text-light mb-2" href="index.jsp"><i
							class="bi bi-arrow-right text-primary me-2"></i>Home</a> <a
							class="text-light mb-2" href="index.jsp#about-us"><i
							class="bi bi-arrow-right text-primary me-2"></i>About Us</a> <a
							class="text-light mb-2" href="index.jsp#our-service"><i
							class="bi bi-arrow-right text-primary me-2"></i>Our Services</a> <a
							class="text-light" href="contact.jsp"><i
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
</body>
</html>