<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings - Smart Brick Kiln</title>
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
                <a href="${pageContext.request.contextPath}/admin/weather" class="list-group-item"><i class="fa-solid fa-cloud-sun-rain me-2"></i>Weather Outlook</a>
                <a href="${pageContext.request.contextPath}/admin/reviews" class="list-group-item"><i class="fa-solid fa-star-half-stroke me-2"></i>Moderation Reviews</a>
                <a href="${pageContext.request.contextPath}/admin/enquiries" class="list-group-item"><i class="fa-solid fa-envelope-open-text me-2"></i>Enquiries Inbox</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="list-group-item"><i class="fa-solid fa-file-excel me-2"></i>Report Exports</a>
                <a href="${pageContext.request.contextPath}/admin/settings" class="list-group-item active"><i class="fa-solid fa-sliders me-2"></i>System Settings</a>
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
            <h2 class="text-secondary-custom font-weight-bold mb-0">System Global Settings</h2>
            <div class="text-muted small">Configure rates for orders and cost calculations</div>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="card border-0 shadow-sm p-5 bg-white rounded-4">
            <form action="${pageContext.request.contextPath}/admin/settings/save" method="post">
                <!-- Include CSRF Token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="row g-4">
                    <!-- Tax Configurations -->
                    <div class="col-12">
                        <h5 class="text-primary-custom border-bottom pb-2 font-weight-bold"><i class="fa-solid fa-percent me-2"></i>Taxation Settings</h5>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Standard GST Rate (%)</label>
                        <div class="input-group">
                            <input type="number" name="GST_RATE" value="${settings.GST_RATE}" required min="0" max="100" class="form-control" placeholder="12">
                            <span class="input-group-text bg-light">%</span>
                        </div>
                        <div class="form-text text-muted">Applied globally to all order product totals.</div>
                    </div>

                    <!-- Transport Rates per Unit -->
                    <div class="col-12 mt-5">
                        <h5 class="text-primary-custom border-bottom pb-2 font-weight-bold"><i class="fa-solid fa-truck me-2"></i>Transport Cost per Brick Unit</h5>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Standard Bricks Transport Rate (INR / unit)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">Rs.</span>
                            <input type="number" step="0.01" name="TRANSPORT_RATE_STANDARD" value="${settings.TRANSPORT_RATE_STANDARD}" required class="form-control" placeholder="1.50">
                        </div>
                        <div class="form-text text-muted">Transport charge per unit for Red, Fly Ash, and Paver Bricks.</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Hollow Blocks Transport Rate (INR / unit)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">Rs.</span>
                            <input type="number" step="0.01" name="TRANSPORT_RATE_HOLLOW" value="${settings.TRANSPORT_RATE_HOLLOW}" required class="form-control" placeholder="5.00">
                        </div>
                        <div class="form-text text-muted">Transport charge per unit for Hollow bricks and heavy Concrete blocks.</div>
                    </div>

                    <!-- Delivery Flat Zone Charges -->
                    <div class="col-12 mt-5">
                        <h5 class="text-primary-custom border-bottom pb-2 font-weight-bold"><i class="fa-solid fa-map-location-dot me-2"></i>Delivery Flat Zone Surcharges (For Calculator)</h5>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Local Hingangaon Village Delivery (INR)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">Rs.</span>
                            <input type="number" step="1" name="TRANSPORT_LOCAL" value="${settings.TRANSPORT_LOCAL}" required class="form-control" placeholder="0">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Paranda Town Delivery (INR)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">Rs.</span>
                            <input type="number" step="1" name="TRANSPORT_PARANDA" value="${settings.TRANSPORT_PARANDA}" required class="form-control" placeholder="1500">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Dharashiv / Osmanabad District Delivery (INR)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">Rs.</span>
                            <input type="number" step="1" name="TRANSPORT_DHARASHIV" value="${settings.TRANSPORT_DHARASHIV}" required class="form-control" placeholder="3500">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Other Districts / Long Distance (INR)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">Rs.</span>
                            <input type="number" step="1" name="TRANSPORT_LONG" value="${settings.TRANSPORT_LONG}" required class="form-control" placeholder="5000">
                        </div>
                    </div>
                </div>

                <div class="mt-5 text-end">
                    <button type="submit" class="btn btn-primary-custom px-5 py-3 text-uppercase font-weight-bold"><i class="fa-solid fa-floppy-disk me-1"></i> Save Global Configurations</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
