<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Management - Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh; padding: 2rem 0;">
    <div class="card shadow p-4" style="width: 100%; max-width: 500px;">
        <h3 class="text-center mb-4">Alumni Registration</h3>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/register" method="post">
            <h5 class="mb-3">Account Details</h5>
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            
            <hr>
            <h5 class="mb-3">Profile Details</h5>
            <div class="row mb-3">
                <div class="col">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                </div>
                <div class="col">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                </div>
            </div>
            <div class="mb-3">
                <label for="graduationYear" class="form-label">Graduation Year</label>
                <input type="number" class="form-control" id="graduationYear" name="graduationYear" required>
            </div>
            <div class="mb-4">
                <label for="degree" class="form-label">Degree</label>
                <input type="text" class="form-control" id="degree" name="degree" placeholder="e.g. B.Tech Computer Science" required>
            </div>
            
            <button type="submit" class="btn btn-success w-100">Register</button>
        </form>
        
        <div class="text-center mt-3">
            <p>Already have an account? <a href="<%= request.getContextPath() %>/login">Login here</a></p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
