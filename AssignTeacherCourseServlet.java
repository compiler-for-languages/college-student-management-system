package com.sms.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.sms.dao.TeacherCourseDAO;

@WebServlet("/AssignTeacherCourseServlet")
public class AssignTeacherCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int teacherId = Integer.parseInt(request.getParameter("teacher_id"));
        int courseId  = Integer.parseInt(request.getParameter("course_id"));

        TeacherCourseDAO dao = new TeacherCourseDAO();
        boolean ok = dao.assignCourseToTeacher(teacherId, courseId);

        if (ok) {
            response.sendRedirect("manageAssignments.jsp");
        } else {
            response.getWriter().println("Error assigning course to teacher (maybe already assigned)");
        }
    }
}

