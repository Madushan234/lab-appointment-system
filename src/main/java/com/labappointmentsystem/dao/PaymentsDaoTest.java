package com.labappointmentsystem.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.labappointmentsystem.model.Appointment;
import com.labappointmentsystem.model.Payment;

public class PaymentsDaoTest {
    private Payment testPayment;
    private Appointment appointment;

    @Before
    public void setUp() {
    	appointment = new Appointment();
		appointment.setId(1);
		
        testPayment = new Payment();
        testPayment.setAppointmentId(appointment.getId());
        testPayment.setDescription("Test payment description");
        testPayment.setAmount(5000.00);
        testPayment.setInvoice("test_invoice_url");
    }

    @After
    public void tearDown() {
        testPayment = null;
    }

    @Test
    public void testCreatePayment() {
        Payment createdPayment = PaymentsDao.createPayment(
                String.valueOf(testPayment.getAppointmentId()),
                testPayment.getAmount(),
                testPayment.getDescription(),
                testPayment.getInvoice(),
                "test@example.com");

        assertNotNull("Created Payment should not be null", createdPayment);
        assertEquals("Appointment ID should match", testPayment.getAppointmentId(), createdPayment.getAppointmentId());
        assertEquals("Description should match", testPayment.getDescription(), createdPayment.getDescription());
        assertEquals("Amount should match", testPayment.getAmount(), createdPayment.getAmount(), 0.001);
        assertEquals("Invoice should match", testPayment.getInvoice(), createdPayment.getInvoice());
    }

    @Test
    public void testFindPaymentByAppointmentId() {
        Payment createdPayment = PaymentsDao.createPayment(
                String.valueOf(testPayment.getAppointmentId()),
                testPayment.getAmount(),
                testPayment.getDescription(),
                testPayment.getInvoice(),
                "test@example.com");

        Payment foundPayment = PaymentsDao.findPaymentByAppointmentId(String.valueOf(createdPayment.getAppointmentId()));

        assertNotNull("Found Payment should not be null", foundPayment);
        assertEquals("Appointment ID should match", createdPayment.getAppointmentId(), foundPayment.getAppointmentId());
        assertEquals("Description should match", createdPayment.getDescription(), foundPayment.getDescription());
        assertEquals("Amount should match", createdPayment.getAmount(), foundPayment.getAmount(), 0.001); 
        assertEquals("Invoice should match", createdPayment.getInvoice(), foundPayment.getInvoice());
    }

}
