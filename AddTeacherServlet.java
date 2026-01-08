package com.sms.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.sms.dao.TeacherDAO;

@WebServlet("/AddTeacherServlet")
public class AddTeacherServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name     = request.getParameter("name");
        String tid      = request.getParameter("tid");              // teacher_code / login id
        int deptId      = Integer.parseInt(request.getParameter("department_id"));
        String password = request.getParameter("password");

        TeacherDAO dao = new TeacherDAO();
        boolean result = dao.addTeacher(name, tid, deptId, password);

        if (result) {
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
        } else {
            response.getWriter().println("Error adding teacher");
        }
    }
}