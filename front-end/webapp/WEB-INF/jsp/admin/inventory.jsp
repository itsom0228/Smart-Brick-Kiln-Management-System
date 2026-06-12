<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management - Smart Brick Kiln</title>
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
                <a href="${pageContext.request.contextPath}/admin/inventory" class="list-group-item active"><i class="fa-solid fa-warehouse me-2"></i>Inventory Logs</a>
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

    <!-- Main -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-secondary-custom font-weight-bold mb-0">Inventory & Stock Adjustment</h2>
            <div class="text-muted small">Manage available warehouse logs</div>
        </div>

        <!-- Success/Error Messages -->
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

        <div class="row g-4">
            <!-- Col 1: Manual Stock adjustment -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-4 bg-white mb-4">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2">Manual Stock Entry/Exit</h5>
                    
                    <form action="${pageContext.request.contextPath}/admin/inventory/adjust" method="post">
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="mb-3">
                            <label class="form-label small font-weight-bold">Select Product</label>
                            <select name="productId" required class="form-select">
                                <option value="" disabled selected>-- Choose Product --</option>
                                <c:forEach var="p" items="${products}">
                                    <option value="${p.id}">${p.name} (Current: ${p.availableStock} Units)</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small font-weight-bold">Adjustment Action</label>
                            <select name="action" required class="form-select">
                                <option value="ADD" selected>Add Stock (Kiln entry / Purchase)</option>
                                <option value="REMOVE">Remove Stock (Exit / Waste / Scrap)</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small font-weight-bold">Quantity (Units)</label>
                            <input type="number" name="quantity" min="1" required class="form-control" placeholder="Quantity units">
                        </div>
                        <div class="mb-4">
                            <label class="form-label small font-weight-bold">Remarks / Notes</label>
                            <textarea name="remarks" rows="2" required class="form-control" placeholder="e.g. Kiln batch #25 completed, or Damage replacement..."></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary-custom w-100 py-2">Apply Adjustment</button>
                    </form>
                </div>
            </div>

            <!-- Col 2: Stocks Table & Log -->
            <div class="col-lg-8">
                <!-- Stock Summary -->
                <div class="card border-0 shadow-sm p-4 bg-white mb-4">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2">Current Stock Balances</h5>
                    <div class="table-responsive">
                        <table class="table align-middle table-hover small">
                            <thead class="table-light">
                                <tr>
                                    <th>Code</th>
                                    <th>Product Name</th>
                                    <th>Available Stock</th>
                                    <th>Low Limit</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${products}">
                                    <tr>
                                        <td><strong>${p.code}</strong></td>
                                        <td>${p.name}</td>
                                        <td><strong>${p.availableStock} Units</strong></td>
                                        <td>${p.lowStockThreshold} Units</td>
                                        <td>
                                            <span class="badge ${p.availableStock <= p.lowStockThreshold ? 'bg-danger' : 'bg-success'}">
                                                ${p.availableStock <= p.lowStockThreshold ? 'Low Stock' : 'In Stock'}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Stock Audit Logs -->
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2">Transaction History Logs</h5>
                    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                        <table class="table align-middle table-hover small">
                            <thead class="table-light sticky-top">
                                <tr>
                                    <th>Date</th>
                                    <th>Product</th>
                                    <th>Type</th>
                                    <th>Qty Change</th>
                                    <th>Remarks</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tx" items="${transactions}">
                                    <tr>
                                        <td>${tx.formattedDate}</td>
                                        <td><strong>${tx.product.name}</strong></td>
                                        <td>
                                            <span class="badge ${tx.transactionType == 'ENTRY' ? 'bg-success' : (tx.transactionType == 'EXIT' ? 'bg-danger' : 'bg-dark')}">
                                                ${tx.transactionType}
                                            </span>
                                        </td>
                                        <td><strong>${tx.quantity}</strong></td>
                                        <td>${tx.remarks}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty transactions}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted">No inventory transactions logged yet.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/custom.js"></script>
</body>
</html>
