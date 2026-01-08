package com.sms.model;

public class IaMark {

    private String courseCode;
    private int studentId;
    private String studentName;
    private String usn;
    private int ia1, ia2, ia3, cta;

    // getters and setters

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String c) { this.courseCode = c; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int id) { this.studentId = id; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String name) { this.studentName = name; }

    public String getUsn() { return usn; }
    public void setUsn(String usn) { this.usn = usn; }

    public int getIa1() { return ia1; }
    public void setIa1(int ia1) { this.ia1 = ia1; }

    public int getIa2() { return ia2; }
    public void setIa2(int ia2) { this.ia2 = ia2; }

    public int getIa3() { return ia3; }
    public void setIa3(int ia3) { this.ia3 = ia3; }

    public int getCta() { return cta; }
    public void setCta(int cta) { this.cta = cta; }

    public int getBestTwoTotal() {
        int[] arr = { ia1, ia2, ia3 };
        java.util.Arrays.sort(arr);
        return arr[1] + arr[2]; // best 2 of 3
    }
}