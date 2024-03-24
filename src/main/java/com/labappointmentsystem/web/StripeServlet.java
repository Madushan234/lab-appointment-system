package com.labappointmentsystem.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.labappointmentsystem.dao.PaymentsDao;
import com.labappointmentsystem.dao.UserDao;
import com.labappointmentsystem.model.Payment;
import com.labappointmentsystem.util.Constants;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
/**
 * Servlet implementation class StripeServlet
 */
@WebServlet("/backend-my-appointment/charge")
public class StripeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StripeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
        Stripe.apiKey = Constants.STRIPE_SECRET_KEY;

        String token = request.getParameter("stripeToken");
        double amount = (request.getParameter("amount") != null) ? Double.parseDouble(request.getParameter("amount")) : 0.0;
        String appointmentId = request.getParameter("appointment_id");
        String email = request.getParameter("email");

        Map<String, Object> params = new HashMap<>();
        params.put("amount", (int)(amount));
        params.put("currency", "usd");
        params.put("description", "ABC laboratory appoiment charge");
        params.put("source", token);

        try {
            Charge charge = Charge.create(params);
            String invoice = charge.getReceiptUrl();
            String description = "ABC laboratory appoiment charge. Charge Id: "+charge.getId();

            Payment payment = PaymentsDao.createPayment(appointmentId, amount, description, invoice, email);
			if (payment != null) {
				session.setAttribute("create-status", "success");
			}else {
				session.setAttribute("create-status", "failed.");
			}
        
        } catch (StripeException e) {
			e.printStackTrace();
        }

		response.sendRedirect("manage.jsp?appoiment="+appointmentId);
	}

}
