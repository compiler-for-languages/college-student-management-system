package com.sms.model;

public class Course {

    private int courseId;
    private String courseCode;
    private String courseName;
    private int credits;
    private int semester;
    private String department;

    public int getCourseId() { return courseId; }
    public void setCourseId(int id) { this.courseId = id; }

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String code) { this.courseCode = code; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String name) { this.courseName = name; }

    public int getCredits() { return credits; }
    public void setCredits(int c) { this.credits = c; }

    public int getSemester() { return semester; }
    public void setSemester(int sem) { this.semester = sem; }

    public String getDepartment() { return department; }
    public void setDepartment(String dept) { this.department = dept; }
}