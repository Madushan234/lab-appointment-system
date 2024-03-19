package com.labappointmentsystem.model;

public class MedicalTestRecord {
    private int id;
    private int appointmentId;
    private int medicalTestId;
    private int technicianId;
    private int statusId;
    private byte[] report;
    private String result;
    private User user;
    private MedicalTest medicalTest;
    private Appointment appointment;
    private Status status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getMedicalTestId() {
        return medicalTestId;
    }

    public void setMedicalTestId(int medicalTestId) {
        this.medicalTestId = medicalTestId;
    }

    public int getTechnicianId() {
        return technicianId;
    }

    public void setTechnicianId(int technicianId) {
        this.technicianId = technicianId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public byte[] getReport() {
        return report;
    }

    public void setReport(byte[] report) {
        this.report = report;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    public MedicalTest getMedicalTest() {
        return medicalTest;
    }

    public void setMedicalTest(MedicalTest medicalTest) {
        this.medicalTest = medicalTest;
    }

    
    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }
    
    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

}
