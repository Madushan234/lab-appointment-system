package com.labappointmentsystem.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.labappointmentsystem.model.MedicalTest;

public class MedicalTestDaoTest {
    private MedicalTest testMedicalTest;

    @Before
    public void setUp() {
        testMedicalTest = new MedicalTest();
        testMedicalTest.setName("Test Medical Test");
        testMedicalTest.setDescription("This is a test medical test");
        testMedicalTest.setNormalRecordData("Test data");
        testMedicalTest.setAmount(100.00);
        testMedicalTest.setProcessingTime(2.5);
        testMedicalTest.setActive(true);
    }

    @After
    public void tearDown() {
        testMedicalTest = null;
    }

    @Test
    public void testCreateMedicalTest() {
        MedicalTest createdMedicalTest = MedicalTestDao.createMedicalTest(
                testMedicalTest.getName(),
                testMedicalTest.getDescription(),
                testMedicalTest.getNormalRecordData(),
                testMedicalTest.getAmount(),
                testMedicalTest.getProcessingTime());

        assertNotNull("Created MedicalTest should not be null", createdMedicalTest);
        assertEquals("Name should match", testMedicalTest.getName(), createdMedicalTest.getName());
        assertEquals("Description should match", testMedicalTest.getDescription(), createdMedicalTest.getDescription());
        assertEquals("Normal Record Data should match", testMedicalTest.getNormalRecordData(), createdMedicalTest.getNormalRecordData());
        assertEquals("Amount should match", testMedicalTest.getAmount(), createdMedicalTest.getAmount(), 0.001); 
        assertEquals("Processing Time should match", testMedicalTest.getProcessingTime(), createdMedicalTest.getProcessingTime(), 0.001); 
    }

    @Test
    public void testFindMedicalTestById() {
        MedicalTest createdMedicalTest = MedicalTestDao.createMedicalTest(
                testMedicalTest.getName(),
                testMedicalTest.getDescription(),
                testMedicalTest.getNormalRecordData(),
                testMedicalTest.getAmount(),
                testMedicalTest.getProcessingTime());

        MedicalTest foundMedicalTest = MedicalTestDao.findMedicalTestById(String.valueOf(createdMedicalTest.getId()));

        assertNotNull("Found MedicalTest should not be null", foundMedicalTest);
        assertEquals("ID should match", createdMedicalTest.getId(), foundMedicalTest.getId());
        assertEquals("Name should match", createdMedicalTest.getName(), foundMedicalTest.getName());
        assertEquals("Description should match", createdMedicalTest.getDescription(), foundMedicalTest.getDescription());
        assertEquals("Normal Record Data should match", createdMedicalTest.getNormalRecordData(), foundMedicalTest.getNormalRecordData());
        assertEquals("Amount should match", createdMedicalTest.getAmount(), foundMedicalTest.getAmount(), 0.001); 
        assertEquals("Processing Time should match", createdMedicalTest.getProcessingTime(), foundMedicalTest.getProcessingTime(), 0.001);
    }
}
