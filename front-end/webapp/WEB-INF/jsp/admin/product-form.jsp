<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Form - Smart Brick Kiln</title>
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
                <a href="${pageContext.request.contextPath}/admin/products" class="list-group-item active"><i class="fa-solid fa-boxes-stacked me-2"></i>Product Catalog</a>
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

    <!-- Main Content -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h2 class="text-secondary-custom font-weight-bold mb-0">${product.id == null ? 'Add Product' : 'Edit Product'}</h2>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left me-1"></i>Back to Catalog</a>
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

        <div class="card border-0 shadow-sm p-5 bg-white">
            <form action="${pageContext.request.contextPath}/admin/products/save" method="post">
                <!-- Include CSRF Token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <c:if test="${product.id != null}">
                    <input type="hidden" name="id" value="${product.id}"/>
                </c:if>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Product Name</label>
                        <input type="text" name="name" value="${product.name}" required class="form-control" placeholder="e.g. Red Bricks">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Product Code</label>
                        <input type="text" name="code" value="${product.code}" required class="form-control" placeholder="e.g. RED001" ${product.id != null ? 'readonly' : ''}>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Dimensions (inches/mm)</label>
                        <input type="text" name="dimensions" value="${product.dimensions}" required class="form-control" placeholder="e.g. 9 x 4 x 3 inches">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Weight (kg)</label>
                        <input type="text" name="weight" value="${product.weight}" required class="form-control" placeholder="e.g. 3.0 kg">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Compressive Strength</label>
                        <input type="text" name="strength" value="${product.strength}" required class="form-control" placeholder="e.g. 7.5 N/mm2">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Base Price (INR per unit)</label>
                        <input type="number" step="0.01" name="price" value="${product.price}" required class="form-control" placeholder="e.g. 7.00">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Available Stock</label>
                        <input type="number" name="availableStock" value="${product.availableStock != null ? product.availableStock : 1000}" required class="form-control" placeholder="Available units">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Low Stock Warning Limit</label>
                        <input type="number" name="lowStockThreshold" value="${product.lowStockThreshold != null ? product.lowStockThreshold : 2000}" required class="form-control" placeholder="Threshold units">
                    </div>
                    <div class="col-12">
                        <label class="form-label font-weight-bold">Product Image</label>
                        
                        <!-- File Upload input -->
                        <div id="imageFileInputGroup">
                            <div class="input-group">
                                <input type="file" id="productImageFile" class="form-control" accept="image/*">
                                <button type="button" class="btn btn-outline-danger" id="clearImageBtn" style="${empty product.imageUrl ? 'display:none;' : ''}"><i class="fa-solid fa-trash-can"></i></button>
                            </div>
                            <div class="form-text text-muted d-flex justify-content-between">
                                <span>Upload a new product image (Max 2MB).</span>
                                <a href="javascript:void(0);" id="toggleToUrlBtn" class="text-primary-custom text-decoration-none font-weight-bold">or input image URL path instead</a>
                            </div>
                        </div>

                        <!-- Manual URL input (hidden by default unless they toggle) -->
                        <div id="imageUrlInputGroup" style="display: none;">
                            <input type="text" id="manualImageUrl" class="form-control" placeholder="e.g. /images/custom-brick.jpg">
                            <div class="form-text text-muted d-flex justify-content-between">
                                <span>Enter relative image path or URL.</span>
                                <a href="javascript:void(0);" id="toggleToFileBtn" class="text-primary-custom text-decoration-none font-weight-bold">or upload image file instead</a>
                            </div>
                        </div>

                        <!-- Hidden field holding the actual value submitted to back-end -->
                        <input type="hidden" name="imageUrl" id="productImageUrl" value="${product.imageUrl}">

                        <!-- Preview container -->
                        <div id="imagePreviewContainer" class="mt-3" style="${empty product.imageUrl ? 'display:none;' : ''}">
                            <div class="small text-muted mb-1 font-weight-bold">Image Preview:</div>
                            <img id="imagePreview" src="${product.imageUrl}" alt="Product Image Preview" class="img-thumbnail shadow-sm rounded-3" style="max-height: 160px; max-width: 200px; object-fit: cover;">
                        </div>
                    </div>
                    <div class="col-12">
                        <label class="form-label font-weight-bold">Product Description</label>
                        <textarea name="description" rows="4" class="form-control" placeholder="Enter details about this product...">${product.description}</textarea>
                    </div>
                </div>

                <div class="mt-4 text-end">
                    <button type="submit" class="btn btn-primary-custom px-5 py-2"><i class="fa-solid fa-save me-1"></i>Save Product Details</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/custom.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const fileInput = document.getElementById('productImageFile');
    const manualUrlInput = document.getElementById('manualImageUrl');
    const hiddenInput = document.getElementById('productImageUrl');
    const previewContainer = document.getElementById('imagePreviewContainer');
    const previewImg = document.getElementById('imagePreview');
    const clearImageBtn = document.getElementById('clearImageBtn');

    const fileGroup = document.getElementById('imageFileInputGroup');
    const urlGroup = document.getElementById('imageUrlInputGroup');
    const toggleToUrl = document.getElementById('toggleToUrlBtn');
    const toggleToFile = document.getElementById('toggleToFileBtn');

    // Switch to URL mode
    toggleToUrl.addEventListener('click', function() {
        fileGroup.style.display = 'none';
        urlGroup.style.display = 'block';
        manualUrlInput.value = hiddenInput.value.startsWith('data:') ? '' : hiddenInput.value;
    });

    // Switch to File mode
    toggleToFile.addEventListener('click', function() {
        urlGroup.style.display = 'none';
        fileGroup.style.display = 'block';
    });

    // Synchronize manual URL field to hidden input
    manualUrlInput.addEventListener('input', function() {
        const val = manualUrlInput.value.trim();
        hiddenInput.value = val;
        if (val) {
            previewImg.src = val;
            previewContainer.style.display = 'block';
            clearImageBtn.style.display = 'inline-block';
        } else {
            previewContainer.style.display = 'none';
            clearImageBtn.style.display = 'none';
        }
    });

    // File input changes
    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            if (file.size > 2 * 1024 * 1024) {
                alert("File is too large. Please upload an image smaller than 2MB.");
                fileInput.value = '';
                return;
            }
            const reader = new FileReader();
            reader.onload = function(evt) {
                const base64Data = evt.target.result;
                hiddenInput.value = base64Data;
                previewImg.src = base64Data;
                previewContainer.style.display = 'block';
                clearImageBtn.style.display = 'inline-block';
            };
            reader.readAsDataURL(file);
        }
    });

    // Clear Image
    clearImageBtn.addEventListener('click', function() {
        hiddenInput.value = '';
        fileInput.value = '';
        manualUrlInput.value = '';
        previewImg.src = '';
        previewContainer.style.display = 'none';
        clearImageBtn.style.display = 'none';
    });
});
</script>
</body>
</html>
