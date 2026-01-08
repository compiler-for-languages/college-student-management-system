package com.sms.model;

public class FinalGrade {
    private int id;
    private int studentId;
    private String courseCode;
    private int cieScore;   // 0-50
    private int seeScore;   // 0-50
    private int totalScore; // 0-100
    private String gradeLetter;
    private int gradePoints;

    // getters / setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }

    public int getCieScore() { return cieScore; }
    public void setCieScore(int cieScore) { this.cieScore = cieScore; }

    public int getSeeScore() { return seeScore; }
    public void setSeeScore(int seeScore) { this.seeScore = seeScore; }

    public int getTotalScore() { return totalScore; }
    public void setTotalScore(int totalScore) { this.totalScore = totalScore; }

    public String getGradeLetter() { return gradeLetter; }
    public void setGradeLetter(String gradeLetter) { this.gradeLetter = gradeLetter; }

    public int getGradePoints() { return gradePoints; }
    public void setGradePoints(int gradePoints) { this.gradePoints = gradePoints; }
}