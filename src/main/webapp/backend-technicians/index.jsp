<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.labappointmentsystem.dao.UserDao"%>
<%@ page import="com.labappointmentsystem.model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.labappointmentsystem.util.UserAuthManager"%>
<%
boolean isAuth = UserAuthManager.getInstance().isAuthenticated(session);
if (!isAuth) {
	response.sendRedirect("../login.jsp");
}

String userEmail = (String) session.getAttribute("user-email");
String userFirstName = (String) session.getAttribute("user-first-name");
String userLastName = (String) session.getAttribute("user-last-name");
String userRole = (String) session.getAttribute("user-role");
if (!("admin".equals(userRole) || "technician".equals(userRole))) {
    response.sendRedirect("../dashboard.jsp");
}

List<User> techniciansList = UserDao.getAllTechnicians();
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
<link rel="shortcut icon" href="../assets/image/favicon.png" />
</head>
<body>
	<div class="container-scroller">

		<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
			<div
				class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
				<a class="navbar-brand brand-logo mr-5" href="dashboard.jsp"><img
					src="../assets/image/logo.png" class="ml-4" alt="logo"
					style="height: 40px; width: 200px;" /></a> <a
					class="navbar-brand brand-logo-mini" href="dashboard.jsp"><img
					src="../assets/image/logo-mini.png" alt="logo"
					style="height: 40px; width: 40px;" /></a>
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
					if ("patient".equals(userRole)) {
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
										<p class="card-title mb-0">Technicians</p>
										<a href="create.jsp" class="btn btn-primary"> Create a New
											Technician</a>
									</div>
									<div class="row">
										<div class="col-md-12 grid-margin stretch-card">
											<div class="card">
												<div class="card-body">
													<div class="table-responsive rounded-xl">
														<table class="table table-striped table-borderless">
															<thead class="bg-info text-white">
																<tr>
																	<th>Email</th>
																	<th>First Name</th>
																	<th>Last Name</th>
																	<th>Telephone Number</th>
																	<th>NIC</th>
																	<th>DOB</th>
																	<th>Action</th>
																</tr>
															</thead>
															<tbody>
																<%
																for (User technician : techniciansList) {
																%>
																<tr>
																	<td><%=technician.getEmail()%></td>
																	<td><%=technician.getFirstName()%></td>
																	<td><%=technician.getLastName()%></td>
																	<td><%=technician.getTelNumber()%></td>
																	<td><%=technician.getNic()%></td>
																	<td><%=technician.getDob()%></td>
																	<td><a
																		href="create.jsp?email-address=<%=technician.getEmail()%>">EDIT</a></td>
																</tr>
																<%
																}
																%>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
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
	<script src="../assets/js/js/datatables.net/jquery.dataTables.js"></script>
	<script
		src="../assets/js/js/datatables.net-bs4/dataTables.bootstrap4.js"></script>
	<script src="../assets/js/js/dataTables.select.min.js"></script>
	<script src="../assets/js/js/off-canvas.js"></script>
	<script src="../assets/js/js/hoverable-collapse.js"></script>
	<script src="../assets/js/js/template.js"></script>
	<script src="../assets/js/js/settings.js"></script>
</body>
</html>