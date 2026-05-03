<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.alumni.model.User" %>
<%
    // Simple session check
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Management - Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Alumni Portal</a>
    <div class="d-flex">
        <span class="navbar-text text-white me-3">
            Welcome, <%= user.getUsername() %> (<%= user.getRole() %>)
        </span>
        <a href="<%= request.getContextPath() %>/login" class="btn btn-outline-light btn-sm">Logout</a>
    </div>
  </div>
</nav>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-4">
            <div class="card text-white bg-success mb-3 shadow">
                <div class="card-header">Events</div>
                <div class="card-body">
                    <h5 class="card-title">Upcoming Meetups</h5>
                    <p class="card-text">View and register for upcoming alumni events and networking sessions.</p>
                    <a href="#" class="btn btn-light btn-sm">View Events</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-info mb-3 shadow">
                <div class="card-header">Directory</div>
                <div class="card-body">
                    <h5 class="card-title">Alumni Network</h5>
                    <p class="card-text">Connect with your fellow alumni and build your professional network.</p>
                    <a href="#" class="btn btn-light btn-sm">Search Network</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-dark bg-warning mb-3 shadow">
                <div class="card-header">Messages</div>
                <div class="card-body">
                    <h5 class="card-title">Inbox</h5>
                    <p class="card-text">Check your messages from other alumni and university staff.</p>
                    <a href="#" class="btn btn-dark btn-sm">Go to Inbox</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-12">
            <div class="card shadow">
                <div class="card-header bg-white">
                    <strong>Recent Activity</strong>
                </div>
                <div class="card-body">
                    <p class="text-muted">A background thread was started by the Servlet to log your access asynchronously. Check the server console.</p>
                    <ul>
                        <li>John Doe updated his current company to Google.</li>
                        <li>Annual Alumni Meet 2026 registration is now open.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
