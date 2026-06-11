<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Detail - Smart Brick Kiln</title>
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
            <h2 class="text-secondary-custom font-weight-bold mb-0">Order: ${order.orderNumber}</h2>
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left me-1"></i>Back to List</a>
        </div>

        <!-- Success/Error alert -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- Col 1: Customer Profile details -->
            <div class="col-lg-8">
                <!-- Customer Specs -->
                <div class="card border-0 shadow-sm p-4 bg-white mb-4">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2"><i class="fa-solid fa-user me-2 text-primary-custom"></i>Customer Details</h5>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <span class="text-muted small d-block">Full Name</span>
                            <strong>${order.fullName}</strong>
                        </div>
                        <div class="col-md-6">
                            <span class="text-muted small d-block">Mobile Number</span>
                            <strong>${order.mobileNumber}</strong>
                        </div>
                        <div class="col-md-6">
                            <span class="text-muted small d-block">Alternate Mobile</span>
                            <strong>${order.alternateMobileNumber != null && !order.alternateMobileNumber.isEmpty() ? order.alternateMobileNumber : 'N/A'}</strong>
                        </div>
                        <div class="col-md-6">
                            <span class="text-muted small d-block">Email Address</span>
                            <strong>${order.emailAddress != null && !order.emailAddress.isEmpty() ? order.emailAddress : 'N/A'}</strong>
                        </div>
                        <div class="col-12">
                            <span class="text-muted small d-block">Delivery Address</span>
                            <strong>${order.fullAddress}</strong>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted small d-block">Village</span>
                            <strong>${order.village}</strong>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted small d-block">Taluka</span>
                            <strong>${order.taluka}</strong>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted small d-block">District</span>
                            <strong>${order.district}</strong>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted small d-block">Pincode</span>
                            <strong>${order.pincode}</strong>
                        </div>
                    </div>
                </div>

                <!-- Products specs and financials (Visual Receipt Design) -->
                <div class="card border shadow-sm p-5 bg-white mb-4 rounded-4" id="visual-receipt">
                    <!-- Receipt Header -->
                    <div class="row align-items-center mb-4 border-bottom pb-4">
                        <div class="col-md-2 text-center text-md-start">
                            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="Logo" class="rounded shadow-sm mb-2 mb-md-0" style="max-height: 80px; width: auto; object-fit: contain;">
                        </div>
                        <div class="col-md-7 text-center text-md-start">
                            <h4 class="text-secondary-custom font-weight-bold mb-1">DIPAK SARPANE BRICK INDUSTRIES</h4>
                            <p class="text-muted small mb-0">
                                <strong>Sarpane Vit Suppliers</strong> | Hingangaon Bk, Tq: Paranda, Osmanabad (Dharashiv) - 413502
                            </p>
                            <p class="text-muted small mb-0">
                                <i class="fa-solid fa-phone text-primary-custom me-1"></i>+91 95884 30156 | <i class="fa-solid fa-envelope text-primary-custom me-1"></i>dipaksarpane@gmail.com
                            </p>
                        </div>
                        <div class="col-md-3 text-center text-md-end mt-3 mt-md-0">
                            <span class="badge bg-dark py-2 px-3 text-uppercase font-weight-bold" style="font-size: 0.9rem;">OFFICIAL RECEIPT</span>
                            <div class="small text-muted mt-2">No: ${order.orderNumber}</div>
                        </div>
                    </div>

                    <!-- Receipt Metadata -->
                    <div class="row g-3 mb-4 small">
                        <div class="col-sm-6 border-end">
                            <h6 class="font-weight-bold text-secondary-custom mb-2 text-uppercase" style="font-size: 0.8rem; letter-spacing: 1px;">Billed To:</h6>
                            <div class="mb-1"><strong>Name:</strong> ${order.fullName}</div>
                            <div class="mb-1"><strong>Phone:</strong> ${order.mobileNumber}</div>
                            <div class="mb-1"><strong>Email:</strong> ${order.emailAddress != null && !order.emailAddress.isEmpty() ? order.emailAddress : 'N/A'}</div>
                            <div><strong>Site Address:</strong> ${order.fullAddress}, ${order.village}, Tq: ${order.taluka}, PIN: ${order.pincode}</div>
                        </div>
                        <div class="col-sm-6 ps-sm-4">
                            <h6 class="font-weight-bold text-secondary-custom mb-2 text-uppercase" style="font-size: 0.8rem; letter-spacing: 1px;">Order Information:</h6>
                            <div class="mb-1"><strong>Date Placed:</strong> ${order.orderDate}</div>
                            <div class="mb-1"><strong>Workflow Status:</strong> <span class="badge bg-secondary-custom py-1">${order.currentStatus}</span></div>
                            <c:if test="${not empty invoice}">
                                <div class="mb-1"><strong>Invoice No:</strong> ${invoice.invoiceNumber}</div>
                                <div><strong>GSTIN:</strong> ${invoice.gstNumber}</div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Itemized Charges -->
                    <div class="table-responsive mb-4">
                        <table class="table table-bordered align-middle small text-center">
                            <thead class="table-light text-secondary-custom">
                                <tr>
                                    <th>Item Description</th>
                                    <th>Quantity</th>
                                    <th>Rate (INR)</th>
                                    <th>Subtotal (INR)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-start">
                                        <strong>${order.productTypeName}</strong><br>
                                        <small class="text-muted">High-density clay bricks direct from kiln</small>
                                    </td>
                                    <td>${order.quantity} Units</td>
                                    <td>${order.productUnitPrice}</td>
                                    <td>${order.productCost}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Receipt Totals -->
                    <div class="row justify-content-end mb-4">
                        <div class="col-md-6">
                            <div class="border p-3 rounded bg-light small">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Product Cost:</span>
                                    <strong>INR ${order.productCost}</strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>GST (${not empty settings.GST_RATE ? settings.GST_RATE : 12}%):</span>
                                    <strong>INR ${order.gstAmount}</strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Transport Charges:</span>
                                    <strong>INR ${order.transportCost}</strong>
                                </div>
                                <hr class="my-2">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="font-weight-bold text-secondary-custom">Grand Total:</span>
                                    <span class="font-weight-bold text-primary-custom" style="font-size: 1.2rem;">INR ${order.totalCost}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Notes if any -->
                    <c:if test="${not empty order.additionalNotes}">
                        <div class="alert alert-light border small py-2 mb-4">
                            <strong>Additional Notes:</strong> ${order.additionalNotes}
                        </div>
                    </c:if>

                    <!-- Receipt Signatures / Footer -->
                    <div class="row align-items-end pt-3 text-center">
                        <div class="col-sm-6 text-sm-start text-muted small">
                            <p class="mb-0"><strong>Thank you for choosing Sarpane Vit Suppliers!</strong></p>
                            <p class="mb-0">This receipt is a computerized ledger entry.</p>
                        </div>
                        <div class="col-sm-6 text-sm-end mt-4 mt-sm-0">
                            <div class="d-inline-block border-top border-secondary pt-2 px-4 text-center" style="min-width: 180px;">
                                <small class="text-muted d-block">Authorized Signatory</small>
                                <strong>Dipak Sarpane</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Col 2: Action Toggles & Invoices -->
            <div class="col-lg-4">
                <!-- Status Change form -->
                <div class="card border-0 shadow-sm p-4 bg-white mb-4">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2"><i class="fa-solid fa-list-check me-2 text-primary-custom"></i>Update Status</h5>
                    
                    <div class="mb-3">
                        <span class="text-muted small d-block mb-1">Current Order Status:</span>
                        <span class="badge py-2 px-3 bg-secondary-custom">${order.currentStatus}</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/orders/update-status/${order.id}" method="post">
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="mb-4">
                            <label class="form-label small font-weight-bold text-muted">Change Workflow State</label>
                            <select name="status" class="form-select">
                                <option value="PENDING" ${order.currentStatus == 'PENDING' ? 'selected' : ''}>PENDING APPROVAL</option>
                                <option value="APPROVED" ${order.currentStatus == 'APPROVED' ? 'selected' : ''}>APPROVED & SCHEDULED</option>
                                <option value="PRODUCTION_STARTED" ${order.currentStatus == 'PRODUCTION_STARTED' ? 'selected' : ''}>PRODUCTION STARTED</option>
                                <option value="READY_FOR_DISPATCH" ${order.currentStatus == 'READY_FOR_DISPATCH' ? 'selected' : ''}>READY FOR DISPATCH</option>
                                <option value="DISPATCHED" ${order.currentStatus == 'DISPATCHED' ? 'selected' : ''}>DISPATCHED / TRANSIT</option>
                                <option value="DELIVERED" ${order.currentStatus == 'DELIVERED' ? 'selected' : ''}>DELIVERED / COMPLETE</option>
                                <option value="REJECTED" ${order.currentStatus == 'REJECTED' ? 'selected' : ''}>REJECTED / CANCELLED</option>
                            </select>
                            <small class="text-muted small mt-1 d-block">Note: Moving to Approved automatically adjusts product inventory stock.</small>
                        </div>
                        <button type="submit" class="btn btn-primary-custom w-100 py-2">Apply Status State</button>
                    </form>
                </div>

                <!-- Invoice generation panel -->
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="text-secondary-custom font-weight-bold mb-3 border-bottom pb-2"><i class="fa-solid fa-file-invoice me-2 text-primary-custom"></i>Invoice Management</h5>
                    
                    <c:if test="${not empty invoice}">
                        <div class="bg-light p-3 rounded small mb-3">
                            <span class="text-muted small d-block">Invoice Number:</span>
                            <strong>${invoice.invoiceNumber}</strong>
                            <span class="text-muted small d-block mt-1">Billing GSTIN:</span>
                            <strong>${invoice.gstNumber}</strong>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/orders/invoice/download/${order.id}" method="get" target="_blank">
                        <div class="mb-3">
                            <label class="form-label small font-weight-bold text-muted">Client GSTIN Number</label>
                            <input type="text" name="gst" value="${invoice != null ? invoice.gstNumber : '27AAACD1234F1Z0'}" class="form-control text-uppercase" placeholder="e.g. 27AAACD1234F1Z0">
                        </div>
                        
                        <!-- Web PDF receipt download (Matches visual screenshot layout) -->
                        <button type="button" onclick="downloadReceiptPDF()" class="btn btn-primary-custom w-100 py-2 mb-2 font-weight-bold"><i class="fa-solid fa-file-pdf me-1"></i>Download PDF Receipt</button>
                        
                        <!-- Server-side standard PDF invoice -->
                        <button type="submit" class="btn btn-dark w-100 py-2 mb-2"><i class="fa-solid fa-file-lines me-1"></i>Download Server Invoice</button>
                        <button type="button" onclick="window.print()" class="btn btn-outline-secondary w-100 py-2"><i class="fa-solid fa-print me-1"></i>Print Page Details</button>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<script>
function downloadReceiptPDF() {
    const element = document.getElementById('visual-receipt');
    
    // Set custom configurations for high quality PDF capture
    const opt = {
        margin:       [0.4, 0.4, 0.4, 0.4],
        filename:     'Receipt-${order.orderNumber}.pdf',
        image:        { type: 'jpeg', quality: 1.0 },
        html2canvas:  { 
            scale: 2, 
            useCORS: true,
            logging: false
        },
        jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
    };
    
    html2pdf().set(opt).from(element).save();
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
