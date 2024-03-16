package com.labappointmentsystem.model;

public class MedicalTest {
	private int id;
	private String name;
	private String description;
	private String normalRecordData;
	private double amount;
	private double processingTime;
	private boolean isActive;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNormalRecordData() {
		return normalRecordData;
	}

	public void setNormalRecordData(String normalRecordData) {
		this.normalRecordData = normalRecordData;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getProcessingTime() {
		return processingTime;
	}

	public void setProcessingTime(double processingTime) {
		this.processingTime = processingTime;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

}
