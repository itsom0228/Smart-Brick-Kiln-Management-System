<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Smart Brick Kiln</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
</head>
<body class="d-flex align-items-center justify-content-center" style="min-height: 100vh;">

<!-- Background dynamic injector fallback script if custom.js runs late -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const theme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-theme', theme);
    });
</script>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <!-- Login Card -->
            <div class="glass-card border-0 p-4 p-md-5">
                <div class="text-center mb-4">
                    <div class="bg-primary-custom text-white rounded-circle p-3 d-inline-flex align-items-center justify-content-center mb-3" style="width: 70px; height: 70px;">
                        <i class="fa-solid fa-lock-open fa-2xl"></i>
                    </div>
                    <h3 class="font-weight-bold">KILN CONSOLE</h3>
                    <p class="text-muted small">Dipak Sarpane Brick Industries Admin Panel</p>
                </div>

                <!-- Error Alert -->
                <c:if test="${param.error == 'true'}">
                    <div class="alert alert-danger border-0 small text-center" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> Invalid username or password!
                    </div>
                </c:if>
                <c:if test="${param.logout == 'true'}">
                    <div class="alert alert-success border-0 small text-center" role="alert">
                        <i class="fa-solid fa-check-circle me-1"></i> Logged out successfully.
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/login/process" method="post">
                    <!-- CSRF Token -->
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold small text-muted">Admin Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" name="username" required class="form-control" placeholder="Username" autofocus>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label font-weight-bold small text-muted">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-key"></i></span>
                            <input type="password" name="password" required class="form-control" placeholder="••••••••">
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold">Authenticate</button>
                </form>

                <div class="text-center mt-4 border-top pt-3" style="border-color: var(--glass-border) !important;">
                    <a href="${pageContext.request.contextPath}/" class="text-decoration-none small text-muted"><i class="fa-solid fa-arrow-left me-1"></i> Return to Public Site</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
