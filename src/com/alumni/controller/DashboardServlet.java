package com.alumni.controller;

import com.alumni.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    
    // Step 5: Explicit Multithreading using ExecutorService
    // A thread pool to handle background tasks like logging or async emails
    private ExecutorService executorService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Create a fixed thread pool with 5 threads
        executorService = Executors.newFixedThreadPool(5);
        System.out.println("DashboardServlet initialized. Thread pool created.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Submit a background task to the ExecutorService
        executorService.submit(() -> {
            try {
                // Simulate some time-consuming background logging or analytics task
                Thread.sleep(2000);
                System.out.println("[ASYNC LOG] User accessed dashboard: " + user.getUsername() + 
                                   " | Thread: " + Thread.currentThread().getName());
                
                // This is where you would normally do async message sending or complex analytics
                // without blocking the main Servlet thread that responds to the HTTP request.
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                System.err.println("Background task interrupted.");
            }
        });

        // Continue rendering the page immediately while the background thread runs
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        // Always shut down the executor service when the servlet is destroyed to prevent memory leaks
        if (executorService != null && !executorService.isShutdown()) {
            executorService.shutdown();
            System.out.println("DashboardServlet destroyed. Thread pool shutdown.");
        }
        super.destroy();
    }
}
