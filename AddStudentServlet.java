package com.sms.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.sms.dao.StudentDAO;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String usn = request.getParameter("usn");
        int deptId = Integer.parseInt(request.getParameter("department_id"));
        int sem = Integer.parseInt(request.getParameter("semester"));
        String password = request.getParameter("password");

        StudentDAO dao = new StudentDAO();

       
        
        
        
        boolean success = dao.addStudent(name, usn, deptId, sem, password);

        
        
        if (success) {
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.getWriter().println("Error adding student");
        }
    }
}