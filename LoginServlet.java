package com.sms.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.sms.dao.UserDAO;
import com.sms.model.User;


 @WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { System.out.println("LOGIN SERVLET CALLED");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        UserDAO dao = new UserDAO();
        User user = dao.validateUser(username, password, role);

        if (user == null) {
            request.setAttribute("message", "Invalid login credentials!");
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        } 
        else {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            switch (role) {
                case "ADMIN":
                    response.sendRedirect("adminDashboard.jsp");
                    break;
                case "TEACHER":
                    response.sendRedirect("teacherDashboard.jsp");
                    break;
                case "STUDENT":
                    response.sendRedirect("studentDashboard.jsp");
                    break;
            }
        }
    }
}