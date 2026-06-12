<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Smart Brick Kiln</title>
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
                <a href="${pageContext.request.contextPath}/admin/orders" class="list-group-item active"><i class="fa-solid fa-truck-moving me-2"></i>Orders List</a>
                <a href="${pageContext.request.contextPath}/admin/quotations" class="list-group-item"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Quotations</a>
                <a href="${pageContext.request.contextPath}/admin/gallery" class="list-group-item"><i class="fa-solid fa-images me-2"></i>Gallery Images</a>
                <a href="${pageContext.request.contextPath}/admin/weather" class="list-group-item"><i class="fa-solid fa-cloud-sun-rain me-2"></i>Weather Outlook</a>
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

    <!-- Main -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-secondary-custom font-weight-bold mb-0">Customer Purchase Orders</h2>
            <div class="text-muted small">Manage order validations and shipping status</div>
        </div>

        <!-- Filter and Search controls -->
        <div class="card border-0 shadow-sm p-4 bg-white mb-4">
            <form action="${pageContext.request.contextPath}/admin/orders" method="get" class="row g-3">
                <div class="col-md-5">
                    <input type="text" name="search" value="${search}" class="form-control" placeholder="Search Customer Name, Order Number, Mobile...">
                </div>
                <div class="col-md-4">
                    <select name="status" class="form-select">
                        <option value="ALL" ${status == 'ALL' || empty status ? 'selected' : ''}>All Order Statuses</option>
                        <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Pending Validation</option>
                        <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>Approved & Scheduled</option>
                        <option value="PRODUCTION_STARTED" ${status == 'PRODUCTION_STARTED' ? 'selected' : ''}>Production Started</option>
                        <option value="READY_FOR_DISPATCH" ${status == 'READY_FOR_DISPATCH' ? 'selected' : ''}>Ready for Dispatch</option>
                        <option value="DISPATCHED" ${status == 'DISPATCHED' ? 'selected' : ''}>Dispatched / In-Transit</option>
                        <option value="DELIVERED" ${status == 'DELIVERED' ? 'selected' : ''}>Delivered / Completed</option>
                        <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>Rejected / Cancelled</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary-custom w-100"><i class="fa-solid fa-filter me-1"></i>Apply Filters</button>
                </div>
            </form>
        </div>

        <!-- Orders Table -->
        <div class="card border-0 shadow-sm p-4 bg-white">
            <div class="table-responsive">
                <table class="table align-middle table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Order No</th>
                            <th>Order Date</th>
                            <th>Customer Name</th>
                            <th>Mobile</th>
                            <th>Product Type</th>
                            <th>Quantity</th>
                            <th>Total Cost</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td><strong>${o.orderNumber}</strong></td>
                                <td>${o.orderDate.toLocalDate()}</td>
                                <td><strong>${o.fullName}</strong></td>
                                <td>${o.mobileNumber}</td>
                                <td>${o.productTypeName}</td>
                                <td>${o.quantity} Units</td>
                                <td>INR ${o.totalCost}</td>
                                <td>
                                    <span class="badge ${o.currentStatus == 'PENDING' ? 'bg-warning text-dark' : (o.currentStatus == 'APPROVED' ? 'bg-primary' : (o.currentStatus == 'DELIVERED' ? 'bg-success' : (o.currentStatus == 'REJECTED' ? 'bg-danger' : 'bg-info')))}">
                                        ${o.currentStatus}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/orders/view/${o.id}" class="btn btn-light btn-sm text-primary-custom border" title="View Order Details"><i class="fa-solid fa-eye me-1"></i> Manage</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="9" class="text-center text-muted py-5">No purchase orders found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/custom.js"></script>
</body>
</html>
