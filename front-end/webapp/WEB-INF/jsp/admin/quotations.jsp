<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quotations - Smart Brick Kiln</title>
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
                <a href="${pageContext.request.contextPath}/admin/quotations" class="list-group-item active"><i class="fa-solid fa-file-invoice-dollar me-2"></i>Quotations</a>
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
            <h2 class="text-secondary-custom font-weight-bold mb-0">Quotation Enquiries Management</h2>
            <div class="text-muted small">Update and convert client quote requests</div>
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

        <div class="card border-0 shadow-sm p-4 bg-white">
            <div class="table-responsive">
                <table class="table align-middle table-hover small">
                    <thead class="table-light">
                        <tr>
                            <th>Quote No</th>
                            <th>Date</th>
                            <th>Customer Name</th>
                            <th>Mobile</th>
                            <th>Product</th>
                            <th>Qty</th>
                            <th>Cost Estimates (INR)</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="q" items="${quotations}">
                            <tr>
                                <td><strong>${q.quotationNumber}</strong></td>
                                <td>${q.requestDate.toLocalDate()}</td>
                                <td>${q.fullName}</td>
                                <td>${q.mobileNumber}</td>
                                <td>${q.productTypeName}</td>
                                <td>${q.quantity}</td>
                                <td>
                                    <div class="small text-muted">
                                        Base: ${q.estimatedProductCost}<br>
                                        GST: ${q.estimatedGstAmount}<br>
                                        Transport: ${q.estimatedTransportCost}<br>
                                        <strong>Total: ${q.totalEstimatedCost}</strong>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge ${q.status == 'PENDING' ? 'bg-warning text-dark' : (q.status == 'CONVERTED_TO_ORDER' ? 'bg-success' : 'bg-info')}">
                                        ${q.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex flex-column gap-1">
                                        <!-- Download PDF -->
                                        <a href="${pageContext.request.contextPath}/admin/quotations/download/${q.id}" target="_blank" class="btn btn-sm btn-dark text-start"><i class="fa-solid fa-file-pdf me-1"></i> PDF</a>
                                        
                                        <c:if test="${q.status != 'CONVERTED_TO_ORDER'}">
                                            <!-- Edit Estimates trigger -->
                                            <button class="btn btn-sm btn-light border text-start" data-bs-toggle="collapse" data-bs-target="#editEstimateCollapse-${q.id}"><i class="fa-solid fa-edit me-1"></i> Edit Cost</button>
                                            
                                            <!-- Convert to Order trigger -->
                                            <button class="btn btn-sm btn-primary-custom text-start" data-bs-toggle="collapse" data-bs-target="#convertCollapse-${q.id}"><i class="fa-solid fa-cart-shopping me-1"></i> Convert</button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                            
                            <!-- Collapsible forms -->
                            <c:if test="${q.status != 'CONVERTED_TO_ORDER'}">
                                <!-- Collapse Edit Cost -->
                                <tr class="collapse bg-light" id="editEstimateCollapse-${q.id}">
                                    <td colspan="9" class="p-3 border">
                                        <form action="${pageContext.request.contextPath}/admin/quotations/update-estimates/${q.id}" method="post" class="row g-3 align-items-end">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <div class="col-md-3">
                                                <label class="form-label small">Product Cost (INR)</label>
                                                <input type="number" step="0.01" name="productCost" value="${q.estimatedProductCost}" required class="form-control form-control-sm">
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small">GST (${not empty settings.GST_RATE ? settings.GST_RATE : 12}%)</label>
                                                <input type="number" step="0.01" name="gstAmount" value="${q.estimatedGstAmount}" required class="form-control form-control-sm">
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small">Transport Cost (INR)</label>
                                                <input type="number" step="0.01" name="transportCost" value="${q.estimatedTransportCost}" required class="form-control form-control-sm">
                                            </div>
                                            <div class="col-md-3">
                                                <button type="submit" class="btn btn-sm btn-dark w-100"><i class="fa-solid fa-save me-1"></i> Update Costings</button>
                                            </div>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Collapse Convert to Order -->
                                <tr class="collapse bg-light" id="convertCollapse-${q.id}">
                                    <td colspan="9" class="p-3 border">
                                        <form action="${pageContext.request.contextPath}/admin/quotations/convert/${q.id}" method="post" class="row g-3 align-items-end">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <div class="col-md-6">
                                                <label class="form-label small">Configure Target Delivery Date</label>
                                                <input type="date" name="deliveryDate" required class="form-control form-control-sm">
                                            </div>
                                            <div class="col-md-6">
                                                <button type="submit" class="btn btn-sm btn-primary-custom w-100"><i class="fa-solid fa-truck-moving me-1"></i> Approve & Place Order</button>
                                            </div>
                                        </form>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty quotations}">
                            <tr>
                                <td colspan="9" class="text-center text-muted py-5">No quotation requests found.</td>
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
