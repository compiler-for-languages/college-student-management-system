package com.sms.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.sms.dao.StudentCourseDAO;

@WebServlet("/AssignStudentCourseServlet")
public class AssignStudentCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("student_id"));
        int courseId  = Integer.parseInt(request.getParameter("course_id"));

        StudentCourseDAO dao = new StudentCourseDAO();
        boolean ok = dao.assignCourseToStudent(studentId, courseId);

        if (ok) {
            response.sendRedirect("manageAssignments.jsp");
        } else {
            response.getWriter().println("Error assigning course to student (maybe already assigned)");
        }
    }
}