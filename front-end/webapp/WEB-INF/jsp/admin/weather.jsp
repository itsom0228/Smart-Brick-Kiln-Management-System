<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kiln Weather Outlook - Smart Brick Kiln</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
</head>
<body>

<div class="admin-wrapper">
    <!-- Sidebar -->
    <div class="admin-sidebar d-flex flex-column justify-content-between">
        <div>
            <div class="sidebar-heading text-accent-custom text-center">
                <i class="fa-solid fa-fire-burner me-2 text-primary-custom"></i>KILN MANAGEMENT
            </div>
            <div class="list-group list-group-flush">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item"><i class="fa-solid fa-chart-line me-2"></i>Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/products" class="list-group-item"><i class="fa-solid fa-boxes-stacked me-2"></i>Product Catalog</a>
                <a href="${pageContext.request.contextPath}/admin/inventory" class="list-group-item"><i class="fa-solid fa-warehouse me-2"></i>Inventory Logs</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="list-group-item"><i class="fa-solid fa-truck-moving me-2"></i>Orders List</a>
                <a href="${pageContext.request.contextPath}/admin/quotations" class="list-group-item"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Quotations</a>
                <a href="${pageContext.request.contextPath}/admin/gallery" class="list-group-item"><i class="fa-solid fa-images me-2"></i>Gallery Images</a>
                <a href="${pageContext.request.contextPath}/admin/weather" class="list-group-item active"><i class="fa-solid fa-cloud-sun-rain me-2"></i>Weather Outlook</a>
                <a href="${pageContext.request.contextPath}/admin/reviews" class="list-group-item"><i class="fa-solid fa-star-half-stroke me-2"></i>Moderation Reviews</a>
                <a href="${pageContext.request.contextPath}/admin/enquiries" class="list-group-item"><i class="fa-solid fa-envelope-open-text me-2"></i>Enquiries Inbox</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="list-group-item"><i class="fa-solid fa-file-excel me-2"></i>Report Exports</a>
                <a href="${pageContext.request.contextPath}/admin/settings" class="list-group-item"><i class="fa-solid fa-sliders me-2"></i>System Settings</a>
            </div>
        </div>
        <div class="p-3 border-top border-secondary">
            <div class="dropdown mb-2">
                <button class="btn btn-outline-light btn-sm w-100 dropdown-toggle text-accent-custom" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-solid fa-globe me-1"></i> Language
                </button>
                <ul class="dropdown-menu dropdown-menu-dark w-100">
                    <li><a class="dropdown-item" href="?lang=en">English</a></li>
                    <li><a class="dropdown-item" href="?lang=mr">मराठी</a></li>
                    <li><a class="dropdown-item" href="?lang=hi">हिन्दी</a></li>
                </ul>
            </div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-outline-danger w-100 py-2"><i class="fa-solid fa-right-from-bracket me-2"></i>Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-secondary-custom font-weight-bold mb-0">Weather Forecast & Kiln Advisory</h2>
            <div class="text-muted small">Region: Paranda, Dharashiv (Osmanabad)</div>
        </div>

        <!-- Executive Advisory Warning -->
        <div class="card border-0 shadow-sm mb-4 rounded-4 bg-white overflow-hidden">
            <div class="row g-0">
                <div class="col-md-1 bg-warning-custom text-white d-flex align-items-center justify-content-center py-4">
                    <i class="fa-solid fa-triangle-exclamation fa-3x"></i>
                </div>
                <div class="col-md-11">
                    <div class="card-body">
                        <h5 class="card-title text-secondary-custom font-weight-bold">Active Weather Warning Alert</h5>
                        <p class="card-text text-muted mb-0">
                            Bricks in the solar drying stage are highly vulnerable to rainwater dissolution. Please monitor the 15-day forecast grid below. 
                            <strong>Action Plan:</strong> Ensure all tarpaulins are deployed and green brick yards are protected when precipitation probability exceeds 50%.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- 15-Day Grid -->
        <div class="row g-3">
            <c:forEach var="day" items="${forecast}" varStatus="status">
                <div class="col-xl-3 col-lg-4 col-md-6">
                    <div class="card h-100 border-0 shadow-sm bg-white p-3 rounded-4 transition-hover d-flex flex-column justify-content-between">
                        <!-- Date Header -->
                        <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-2">
                            <h6 class="mb-0 text-secondary-custom font-weight-bold">${day.date} (${day.dayOfWeek})</h6>
                            <span class="badge ${day.rainChance >= 60 ? 'bg-danger' : (day.rainChance >= 30 ? 'bg-warning text-dark' : 'bg-success')}">
                                Rain: ${day.rainChance}%
                            </span>
                        </div>

                        <!-- Weather Condition Icon & Temp -->
                        <div class="d-flex align-items-center my-3 justify-content-around">
                            <div class="text-center">
                                <c:choose>
                                    <c:when test="${day.condition == 'Sunny'}">
                                        <i class="fa-solid fa-sun fa-3x text-warning-custom"></i>
                                    </c:when>
                                    <c:when test="${day.condition == 'Mostly Sunny'}">
                                        <i class="fa-solid fa-cloud-sun fa-3x text-warning-custom opacity-75"></i>
                                    </c:when>
                                    <c:when test="${day.condition == 'Partly Cloudy'}">
                                        <i class="fa-solid fa-cloud-sun fa-3x text-secondary"></i>
                                    </c:when>
                                    <c:when test="${day.condition == 'Cloudy'}">
                                        <i class="fa-solid fa-cloud fa-3x text-secondary"></i>
                                    </c:when>
                                    <c:when test="${day.condition == 'Light Rain'}">
                                        <i class="fa-solid fa-cloud-rain fa-3x text-primary-custom"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-solid fa-cloud-showers-heavy fa-3x text-danger"></i>
                                    </c:otherwise>
                                </c:choose>
                                <div class="small text-muted font-weight-bold mt-1">${day.condition}</div>
                            </div>
                            <div class="text-end">
                                <h4 class="mb-0 text-secondary-custom font-weight-bold">${day.tempMax}°C</h4>
                                <span class="small text-muted">Low: ${day.tempMin}°C</span>
                            </div>
                        </div>

                        <!-- Humidity and parameters -->
                        <div class="bg-light p-2 rounded-3 mb-3 small">
                            <div class="d-flex justify-content-between mb-1">
                                <span class="text-muted">Air Humidity:</span>
                                <strong>${day.humidity}%</strong>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Wind Speed:</span>
                                <strong>${10 + (status.index % 12)} km/h</strong>
                            </div>
                        </div>

                        <!-- Advisory message -->
                        <div class="card border-0 bg-secondary-custom text-white p-2 rounded-3 small mt-auto">
                            <div class="d-flex align-items-start">
                                <i class="fa-solid fa-circle-exclamation me-1 mt-1 text-accent-custom"></i>
                                <span>${day.advice}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/custom.js"></script>
</body>
</html>
