<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Export Reports - Smart Brick Kiln</title>
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
                <a href="${pageContext.request.contextPath}/admin/reports" class="list-group-item active"><i class="fa-solid fa-file-excel me-2"></i>Report Exports</a>
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

    <!-- Main -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-secondary-custom font-weight-bold mb-0">Management Reports Export</h2>
            <div class="text-muted small">Generate Excel spreadsheets for audit and tax analysis</div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-6" data-aos="zoom-in">
                <div class="card border-0 shadow-sm p-5 bg-white text-dark">
                    <div class="text-center mb-4">
                        <i class="fa-solid fa-file-excel fa-4x text-success mb-3"></i>
                        <h4 class="font-weight-bold text-secondary-custom">Export Spreadsheet Reports</h4>
                        <p class="text-muted small">Select criteria to extract and compile database registers</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/reports/export" method="get" target="_blank">
                        <div class="mb-3">
                            <label class="form-label font-weight-bold small text-muted">Report Registry Type</label>
                            <select name="type" required class="form-select">
                                <option value="orders" selected>Sales & Purchase Orders List</option>
                                <option value="inventory">Inventory Transaction Stock Logs</option>
                                <option value="quotations">Quotation Requests List</option>
                            </select>
                        </div>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label font-weight-bold small text-muted">Start Date</label>
                                <input type="date" id="start-date" name="start" required class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label font-weight-bold small text-muted">End Date</label>
                                <input type="date" id="end-date" name="end" required class="form-control">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold"><i class="fa-solid fa-download me-1"></i>Compile & Export Excel</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Set default dates: first day of current month to today
    const today = new Date();
    const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
    
    document.getElementById('start-date').value = firstDay.toISOString().split('T')[0];
    document.getElementById('end-date').value = today.toISOString().split('T')[0];
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
