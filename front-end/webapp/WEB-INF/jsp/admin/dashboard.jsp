<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Smart Brick Kiln</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
</head>
<body>

<div class="admin-wrapper">
    <!-- Left Sidebar -->
    <div class="admin-sidebar d-flex flex-column justify-content-between">
        <div>
            <div class="sidebar-heading text-accent-custom text-center">
                <i class="fa-solid fa-fire-burner me-2 text-primary-custom"></i>KILN MANAGEMENT
            </div>
            <div class="list-group list-group-flush">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item active"><i class="fa-solid fa-chart-line me-2"></i>Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/products" class="list-group-item"><i class="fa-solid fa-boxes-stacked me-2"></i>Product Catalog</a>
                <a href="${pageContext.request.contextPath}/admin/inventory" class="list-group-item"><i class="fa-solid fa-warehouse me-2"></i>Inventory Logs</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="list-group-item"><i class="fa-solid fa-truck-moving me-2"></i>Orders List</a>
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

    <!-- Main Content Area -->
    <div class="admin-main">
        <!-- Top Bar -->
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-secondary-custom font-weight-bold mb-0">Dashboard Administration</h2>
            <div class="text-muted small">
                <i class="fa-regular fa-calendar me-1"></i> Current Date: <strong>11 June 2026</strong>
            </div>
        </div>

        <!-- Warning low stock alerts -->
        <c:if test="${not empty lowStockAlerts}">
            <div class="alert alert-warning border-0 shadow-sm p-4 mb-4" role="alert">
                <h5 class="alert-heading text-warning-emphasis font-weight-bold mb-2"><i class="fa-solid fa-triangle-exclamation me-2"></i>Low Stock Warnings!</h5>
                <p class="small mb-2">The following products have fallen below their configured minimum safety stock levels:</p>
                <div class="row g-2">
                    <c:forEach var="lsp" items="${lowStockAlerts}">
                        <div class="col-md-4">
                            <div class="bg-white p-2 border rounded small d-flex justify-content-between align-items-center">
                                <span><strong>${lsp.name}</strong> (Code: ${lsp.code})</span>
                                <span class="badge bg-danger">${lsp.availableStock} Units</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- KPI Grid Cards (8 cards) -->
        <div class="row g-3 mb-4">
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-primary-custom text-white p-3 rounded-3 me-3"><i class="fa-solid fa-truck-fast fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Total Orders</span>
                            <h4 class="mb-0 font-weight-bold">${totalOrders}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-warning text-dark p-3 rounded-3 me-3"><i class="fa-solid fa-clock-rotate-left fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Pending Orders</span>
                            <h4 class="mb-0 font-weight-bold">${pendingOrders}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-success text-white p-3 rounded-3 me-3"><i class="fa-solid fa-circle-check fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Delivered Orders</span>
                            <h4 class="mb-0 font-weight-bold">${deliveredOrders}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-info text-white p-3 rounded-3 me-3"><i class="fa-solid fa-indian-rupee-sign fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Delivered Revenue</span>
                            <h4 class="mb-0 font-weight-bold">${totalRevenue}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-dark text-white p-3 rounded-3 me-3"><i class="fa-solid fa-cubes fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Total Products</span>
                            <h4 class="mb-0 font-weight-bold">${totalProducts}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-info text-white p-3 rounded-3 me-3"><i class="fa-solid fa-receipt fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Quotations</span>
                            <h4 class="mb-0 font-weight-bold">${totalQuotations}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-secondary text-white p-3 rounded-3 me-3"><i class="fa-solid fa-star fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Reviews</span>
                            <h4 class="mb-0 font-weight-bold">${totalReviews}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm p-3 bg-white h-100">
                    <div class="d-flex align-items-center">
                        <div class="bg-danger text-white p-3 rounded-3 me-3"><i class="fa-solid fa-message fa-xl"></i></div>
                        <div>
                            <span class="text-muted small d-block">Enquiries</span>
                            <h4 class="mb-0 font-weight-bold">${totalEnquiries}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Dashboard (Chart.js) -->
        <div class="row g-4 mb-4">
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2">Sales Metrics Trend (Monthly)</h5>
                    <canvas id="salesChart" height="220"></canvas>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2">Revenue Growth (INR)</h5>
                    <canvas id="revenueChart" height="220"></canvas>
                </div>
            </div>
        </div>

        <!-- Recent Activities Panels -->
        <div class="row g-4">
            <!-- Col 1: Recent Orders -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm p-4 bg-white h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h5 class="text-secondary-custom font-weight-bold mb-0">Recent Order Activity</h5>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-primary btn-sm">View All Orders</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-middle table-hover small">
                            <thead class="table-light">
                                <tr>
                                    <th>Order No</th>
                                    <th>Customer</th>
                                    <th>Product</th>
                                    <th>Qty</th>
                                    <th>Total Cost</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${recentOrders}">
                                    <tr>
                                        <td><strong>${o.orderNumber}</strong></td>
                                        <td>${o.fullName}</td>
                                        <td>${o.productTypeName}</td>
                                        <td>${o.quantity}</td>
                                        <td>INR ${o.totalCost}</td>
                                        <td>
                                            <span class="badge ${o.currentStatus == 'PENDING' ? 'bg-warning text-dark' : (o.currentStatus == 'DELIVERED' ? 'bg-success' : 'bg-info')}">
                                                ${o.currentStatus}
                                            </span>
                                        </td>
                                        <td><a href="${pageContext.request.contextPath}/admin/orders/view/${o.id}" class="btn btn-light btn-sm text-primary-custom"><i class="fa-solid fa-eye"></i></a></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentOrders}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted">No recent orders registered in the system.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Col 2: Recent Enquiries -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-4 bg-white h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h5 class="text-secondary-custom font-weight-bold mb-0">New Enquiries</h5>
                        <a href="${pageContext.request.contextPath}/admin/enquiries" class="btn btn-outline-primary btn-sm">All Messages</a>
                    </div>
                    <div class="list-group list-group-flush">
                        <c:forEach var="msg" items="${recentEnquiries}">
                            <div class="list-group-item p-3 border-bottom-0 bg-light rounded-3 mb-2 small">
                                <div class="d-flex justify-content-between mb-1">
                                    <strong class="text-secondary-custom">${msg.fullName}</strong>
                                    <span class="text-muted small">${msg.mobileNumber}</span>
                                </div>
                                <p class="text-muted mb-1 text-truncate">${msg.messageText}</p>
                                <div class="text-end">
                                    <span class="badge ${msg.replied ? 'bg-success' : 'bg-danger'}">${msg.replied ? 'Responded' : 'Unanswered'}</span>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty recentEnquiries}">
                            <div class="text-center text-muted py-4 small">No enquiries received yet.</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // 1. Sales Chart
    const salesCtx = document.getElementById('salesChart').getContext('2d');
    new Chart(salesCtx, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Monthly Orders Count',
                data: ${chartSales},
                backgroundColor: 'rgba(178, 34, 34, 0.75)',
                borderColor: 'rgba(178, 34, 34, 1)',
                borderWidth: 1,
                borderRadius: 4
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });

    // 2. Revenue Chart
    const revCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Revenue Trend (INR)',
                data: ${chartRevenue},
                backgroundColor: 'rgba(44, 44, 44, 0.1)',
                borderColor: 'rgba(44, 44, 44, 1)',
                borderWidth: 2.5,
                fill: true,
                tension: 0.35
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>
</body>
</html>
