package com.alumni.controller;

import com.alumni.dao.UserDAO;
import com.alumni.model.Alumni;
import com.alumni.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String username = request.getParameter("username");
        String password =  request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        int graduationYear = Integer.parseInt(request.getParameter("graduationYear"));
        String degree = request.getParameter("degree");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        Alumni alumni = new Alumni();
        alumni.setFirstName(firstName);
        alumni.setLastName(lastName);
        alumni.setGraduationYear(graduationYear);
        alumni.setDegree(degree);

        boolean success = userDAO.registerUser(user, alumni);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/login?success=true");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
