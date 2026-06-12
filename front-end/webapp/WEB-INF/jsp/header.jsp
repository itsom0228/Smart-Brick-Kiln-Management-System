<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="nav.brand"/></title>
    
    <!-- SEO and OpenGraph Metadata -->
    <meta name="description" content="Premium brick manufacturing. Dipak Sarpane Brick Industries provides high quality Red Bricks, Fly Ash Bricks, Hollow Bricks, and Concrete Blocks.">
    <meta property="og:title" content="Dipak Sarpane Brick Industries - Smart Brick Kiln">
    <meta property="og:description" content="Strong Foundations Begin With Quality Bricks. Standardized and automated brick processing.">
    <meta property="og:type" content="website">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- AOS Animations CSS -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    
    <!-- Custom Application CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
    
    <script>
        // Apply theme immediately on load to prevent light flash
        const savedTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-theme', savedTheme);
    </script>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-secondary-custom navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand text-accent-custom d-flex align-items-center" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="Logo" height="40" class="me-2 rounded shadow-sm" style="max-width: 40px; object-fit: cover;">
            <span><spring:message code="nav.brand"/></span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/"><spring:message code="nav.home"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about"><spring:message code="nav.about"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products"><spring:message code="nav.products"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/gallery"><spring:message code="nav.gallery"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/calculator"><spring:message code="nav.calculator"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact"><spring:message code="nav.contact"/></a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-accent-custom" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-globe me-1"></i> <spring:message code="nav.language"/>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-menu-item dropdown-item" href="?lang=en">English</a></li>
                        <li><a class="dropdown-menu-item dropdown-item" href="?lang=mr">मराठी (Marathi)</a></li>
                        <li><a class="dropdown-menu-item dropdown-item" href="?lang=hi">हिन्दी (Hindi)</a></li>
                    </ul>
                </li>
                <li class="nav-item ms-lg-2 ms-0 my-lg-0 my-2">
                    <button class="theme-toggle-btn" id="theme-toggle" aria-label="Toggle theme">
                        <i class="fa-solid fa-moon"></i>
                    </button>
                </li>
                <li class="nav-item ms-lg-3">
                    <a class="btn btn-outline-custom btn-sm py-2 px-3" href="${pageContext.request.contextPath}/order/track">
                        <i class="fa-solid fa-magnifying-glass me-1"></i> <spring:message code="nav.trackOrder"/>
                    </a>
                </li>
                <li class="nav-item ms-lg-2">
                    <a class="btn btn-primary-custom btn-sm py-2 px-3" href="${pageContext.request.contextPath}/order/now">
                        <i class="fa-solid fa-cart-shopping me-1"></i> <spring:message code="nav.orderNow"/>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
