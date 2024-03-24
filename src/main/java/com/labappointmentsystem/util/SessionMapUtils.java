package com.labappointmentsystem.util;
import java.util.Map;

public class SessionMapUtils {

    public static String getFiledValue(Map<String, String> fieldErrors, String fieldName) {
        return (fieldErrors != null && fieldErrors.containsKey(fieldName)) ? fieldErrors.get(fieldName) : "";
    }
}
