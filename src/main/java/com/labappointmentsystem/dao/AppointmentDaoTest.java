package com.labappointmentsystem.dao;
import static org.junit.Assert.*;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.labappointmentsystem.dao.AppointmentDao;
import com.labappointmentsystem.model.Appointment;
import com.labappointmentsystem.model.MedicalTest;
import com.labappointmentsystem.model.Payment;

public class AppointmentDaoTest {
    private MedicalTest medicalTest;
    private MedicalTest medicalTest2;
    
    @Before
    public void setUp() {
    	medicalTest = new MedicalTest();
    	medicalTest.setId(1);
    	medicalTest2 = new MedicalTest();
    	medicalTest2.setId(2);
    }

    @Test
    public void testFindAppointmentById() {
        Appointment appointment = AppointmentDao.findAppointmentById("1");
        assertNotNull(appointment);
    }

    @Test
    public void testGetAllAppointments() {
        List<Appointment> appointments = AppointmentDao.getAllAppointments();
        assertNotNull(appointments);
        assertFalse(appointments.isEmpty());
    }

    @Test
    public void testGetAppointmentsByUserEmail() {
        List<Appointment> appointments = AppointmentDao.getAppointmentsByUserEmail("test@example.com");
        assertNotNull(appointments);
        assertFalse(appointments.isEmpty());
    }

    @Test
    public void testCreateAppointment() {
    	int medicalTestId1 = medicalTest.getId();
        int medicalTestId2 = medicalTest2.getId();
        String[] medicalTests = {String.valueOf(medicalTestId1), String.valueOf(medicalTestId2)};        
        Appointment appointment = AppointmentDao.createAppointment(1, "test@example.com", "Dr. Smith", "2024-03-25", "10:00", medicalTests);
        assertNotNull(appointment);
    }

}
