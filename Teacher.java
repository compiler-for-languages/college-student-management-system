package com.sms.model;

public class Teacher {
    private int teacherId;
    private int departmentId;
    private String name;
    private String teacherCode;

    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }

    public String getTeacherCode() { return teacherCode; }
    public void setTeacherCode(String teacherCode) { this.teacherCode = teacherCode; }

    public int getDepartmentId() { return departmentId; }
    public void setDepartmentId(int departmentId) { this.departmentId = departmentId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}