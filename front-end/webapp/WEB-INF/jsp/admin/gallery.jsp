<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery Manager - Smart Brick Kiln</title>
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
                <a href="${pageContext.request.contextPath}/admin/gallery" class="list-group-item active"><i class="fa-solid fa-images me-2"></i>Gallery Images</a>
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

    <!-- Main Content -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-secondary-custom font-weight-bold mb-0">Gallery Images Manager</h2>
            <div class="text-muted small">Upload and delete dynamic homepage gallery images</div>
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

        <div class="row g-4">
            <!-- Left: Add New Image -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2">Upload New Photo</h5>
                    
                    <form action="${pageContext.request.contextPath}/admin/gallery/upload" method="post" enctype="multipart/form-data">
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="mb-3">
                            <label class="form-label small font-weight-bold">Photo Title / Caption</label>
                            <input type="text" name="title" required class="form-control" placeholder="e.g. Clay stockyard, New Kiln batch">
                        </div>

                        <div class="mb-4">
                            <label class="form-label small font-weight-bold">Select Image File</label>
                            <input type="file" name="imageFile" accept="image/png, image/jpeg, image/jpg" required class="form-control">
                            <div class="form-text small text-muted">Supports JPG, JPEG, and PNG. Max size: 5MB.</div>
                        </div>

                        <button type="submit" class="btn btn-primary-custom w-100 py-2"><i class="fa-solid fa-cloud-arrow-up me-1"></i> Upload Image</button>
                    </form>
                </div>
            </div>

            <!-- Right: Grid of uploaded images -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2">Active Uploads</h5>
                    
                    <div class="row g-3">
                        <c:forEach var="img" items="${images}">
                            <div class="col-md-4 col-sm-6">
                                <div class="card h-100 border-0 shadow-sm bg-light overflow-hidden position-relative group-hover-actions">
                                    <img src="${img.base64Data}" class="card-img-top" alt="${img.title}" style="height: 140px; object-fit: cover;">
                                    <div class="card-body p-2 d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-secondary-custom font-weight-bold text-truncate small mb-2" title="${img.title}">${img.title}</h6>
                                        <form action="${pageContext.request.contextPath}/admin/gallery/delete/${img.id}" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn btn-sm btn-outline-danger w-100 py-1" onclick="return confirm('Are you sure you want to delete this gallery image?');"><i class="fa-solid fa-trash-can me-1"></i> Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${empty images}">
                            <div class="col-12 text-center py-5 text-muted">
                                <i class="fa-regular fa-image fa-3x mb-3 text-secondary-custom opacity-50"></i>
                                <p class="mb-0">No dynamic images uploaded yet. Upload your first photo on the left!</p>
                            </div>
                        </c:if>
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
