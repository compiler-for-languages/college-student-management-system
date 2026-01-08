package com.sms.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.sms.dao.CourseDAO;

@WebServlet("/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Receive form fields from manageCourses.jsp
        String courseCode = request.getParameter("course_code");
        String courseName = request.getParameter("course_name");
        int credits = Integer.parseInt(request.getParameter("credits"));
        int semester = Integer.parseInt(request.getParameter("semester"));
        String department = request.getParameter("department");

        CourseDAO dao = new CourseDAO();
        boolean success = dao.addCourse(courseCode, courseName, semester, credits, department);

        if (success) {
            // Redirect back to manageCourses page
            response.sendRedirect("manageCourses.jsp");
        } else {
            response.getWriter().println("Error adding course");
        }
    }
}