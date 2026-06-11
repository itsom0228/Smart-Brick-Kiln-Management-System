// API Form Handlers for client-side REST interactions

document.addEventListener('DOMContentLoaded', function() {
    console.log("API Forms JS initialized");

    // Helper to get CSRF token and header name from the page
    function getCsrfConfig() {
        const csrfTokenInput = document.querySelector('input[name="_csrf"]');
        const token = csrfTokenInput ? csrfTokenInput.value : '';
        // If not found in input, check metadata
        return {
            token: token,
            header: 'X-CSRF-TOKEN'
        };
    }

    // Helper to display alerts inside a card/container
    function showAlert(form, type, message) {
        // Remove existing alerts first
        const existingAlert = form.querySelector('.api-alert');
        if (existingAlert) existingAlert.remove();

        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} alert-dismissible fade show api-alert mt-3`;
        alertDiv.role = 'alert';
        alertDiv.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        `;
        // Insert alert at the beginning of the form
        form.insertBefore(alertDiv, form.firstChild);
        
        // Auto-remove alert after 5 seconds
        setTimeout(() => {
            alertDiv.style.opacity = '0';
            setTimeout(() => alertDiv.remove(), 500);
        }, 5000);
    }

    // 1. Review Form Handler
    const reviewForm = document.getElementById('review-form');
    if (reviewForm) {
        reviewForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const csrf = getCsrfConfig();
            
            const payload = {
                fullName: reviewForm.querySelector('input[name="fullName"]').value,
                rating: parseInt(reviewForm.querySelector('select[name="rating"]').value),
                reviewText: reviewForm.querySelector('textarea[name="reviewText"]').value
            };

            fetch('/api/reviews', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    [csrf.header]: csrf.token
                },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    showAlert(reviewForm, 'success', data.message);
                    reviewForm.reset();
                } else {
                    showAlert(reviewForm, 'danger', data.message || 'Failed to submit review.');
                }
            })
            .catch(err => {
                console.error(err);
                showAlert(reviewForm, 'danger', 'An error occurred. Please try again.');
            });
        });
    }

    // 2. Contact / Enquiry Form Handler
    const contactForm = document.getElementById('contact-form');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const csrf = getCsrfConfig();

            const payload = {
                fullName: contactForm.querySelector('input[name="fullName"]').value,
                mobileNumber: contactForm.querySelector('input[name="mobileNumber"]').value,
                email: contactForm.querySelector('input[name="email"]').value,
                messageText: contactForm.querySelector('textarea[name="messageText"]').value
            };

            fetch('/api/enquiries', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    [csrf.header]: csrf.token
                },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    showAlert(contactForm, 'success', data.message);
                    contactForm.reset();
                } else {
                    showAlert(contactForm, 'danger', data.message || 'Failed to submit enquiry.');
                }
            })
            .catch(err => {
                console.error(err);
                showAlert(contactForm, 'danger', 'An error occurred. Please try again.');
            });
        });
    }

    // 3. Order Placement Form Handler
    const orderForm = document.getElementById('order-form');
    if (orderForm) {
        orderForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Trigger native bootstrap styling
            if (!orderForm.checkValidity()) {
                e.stopPropagation();
                orderForm.classList.add('was-validated');
                return;
            }

            const csrf = getCsrfConfig();
            
            const payload = {
                fullName: orderForm.querySelector('input[name="fullName"]').value,
                mobileNumber: orderForm.querySelector('input[name="mobileNumber"]').value,
                alternateMobileNumber: orderForm.querySelector('input[name="alternateMobileNumber"]').value,
                emailAddress: orderForm.querySelector('input[name="emailAddress"]').value,
                fullAddress: orderForm.querySelector('textarea[name="fullAddress"]').value,
                village: orderForm.querySelector('input[name="village"]').value,
                taluka: orderForm.querySelector('input[name="taluka"]').value,
                district: orderForm.querySelector('input[name="district"]').value,
                state: orderForm.querySelector('input[name="state"]').value,
                pincode: orderForm.querySelector('input[name="pincode"]').value,
                product: {
                    id: parseInt(orderForm.querySelector('select[name="product.id"]').value)
                },
                quantity: parseInt(orderForm.querySelector('input[name="quantity"]').value),
                deliveryDate: orderForm.querySelector('input[name="deliveryDate"]').value,
                additionalNotes: orderForm.querySelector('textarea[name="additionalNotes"]').value
            };

            fetch('/api/orders', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    [csrf.header]: csrf.token
                },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    // Redirect to success page
                    window.location.href = `/order/success/${data.orderNumber}`;
                } else {
                    showAlert(orderForm, 'danger', data.message || 'Failed to place order.');
                }
            })
            .catch(err => {
                console.error(err);
                showAlert(orderForm, 'danger', 'An error occurred during order submission.');
            });
        });
    }

    // 4. Quotation Request Form Handler
    const quotationForm = document.getElementById('quotation-form');
    if (quotationForm) {
        quotationForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const csrf = getCsrfConfig();

            const payload = {
                fullName: quotationForm.querySelector('input[name="fullName"]').value,
                mobileNumber: quotationForm.querySelector('input[name="mobileNumber"]').value,
                email: quotationForm.querySelector('input[name="email"]').value,
                product: {
                    id: parseInt(quotationForm.querySelector('select[name="product.id"]').value)
                },
                quantity: parseInt(quotationForm.querySelector('input[name="quantity"]').value),
                fullAddress: quotationForm.querySelector('textarea[name="fullAddress"]').value
            };

            fetch('/api/quotations', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    [csrf.header]: csrf.token
                },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    // Redirect to success page
                    window.location.href = `/quotation/success?quoteNo=${data.quotationNumber}`;
                } else {
                    showAlert(quotationForm, 'danger', data.message || 'Failed to request quotation.');
                }
            })
            .catch(err => {
                console.error(err);
                showAlert(quotationForm, 'danger', 'An error occurred during quotation request.');
            });
        });
    }

    // 5. Order Tracking Form Handler
    const trackForm = document.getElementById('track-form');
    const trackingResultsColumn = document.getElementById('tracking-results-column');

    if (trackForm && trackingResultsColumn) {
        trackForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const orderNumber = trackForm.querySelector('input[name="orderNumber"]').value.trim();
            const mobileNumber = trackForm.querySelector('input[name="mobileNumber"]').value.trim();

            fetch(`/api/orders/track?orderNumber=${encodeURIComponent(orderNumber)}&mobileNumber=${encodeURIComponent(mobileNumber)}`)
            .then(res => {
                if (!res.ok) {
                    throw new Error('Order not found');
                }
                return res.json();
            })
            .then(order => {
                // Render success timeline dynamically
                const progressWidth = order.statusProgress;
                const status = order.currentStatus;
                
                // Helper to check classes
                const getStepClass = (stepName) => {
                    if (status === 'REJECTED') return 'rejected';
                    
                    const steps = ['PENDING', 'APPROVED', 'PRODUCTION_STARTED', 'READY_FOR_DISPATCH', 'DISPATCHED', 'DELIVERED'];
                    const currentIdx = steps.indexOf(status);
                    const stepIdx = steps.indexOf(stepName);
                    
                    if (stepIdx === currentIdx) return 'active';
                    if (stepIdx < currentIdx) return 'completed';
                    return '';
                };

                let timelineHtml = '';
                if (status === 'REJECTED') {
                    timelineHtml = `
                        <div class="timeline-step active">
                            <div class="timeline-icon bg-danger text-white border-danger">
                                <i class="fa-solid fa-circle-xmark"></i>
                            </div>
                            <div class="timeline-content border-danger bg-danger-subtle">
                                <h5 class="text-danger font-weight-bold">Order Rejected</h5>
                                <p class="small text-muted mb-0">This order has been cancelled or rejected by administration. Please contact owner Dipak Sarpane for details.</p>
                            </div>
                        </div>
                    `;
                } else {
                    timelineHtml = `
                        <!-- Pending -->
                        <div class="timeline-step ${getStepClass('PENDING')}">
                            <div class="timeline-icon">
                                <i class="fa-solid fa-clock"></i>
                            </div>
                            <div class="timeline-content">
                                <h5>Pending</h5>
                                <p class="small text-muted mb-0">We have received your brick order and are validating details.</p>
                            </div>
                        </div>
                        <!-- Approved -->
                        <div class="timeline-step ${getStepClass('APPROVED')}">
                            <div class="timeline-icon">
                                <i class="fa-solid fa-thumbs-up"></i>
                            </div>
                            <div class="timeline-content">
                                <h5>Approved</h5>
                                <p class="small text-muted mb-0">Admin approved. Order transitioned to manufacturing.</p>
                            </div>
                        </div>
                        <!-- Production -->
                        <div class="timeline-step ${getStepClass('PRODUCTION_STARTED')}">
                            <div class="timeline-icon">
                                <i class="fa-solid fa-industry"></i>
                            </div>
                            <div class="timeline-content">
                                <h5>Production Started</h5>
                                <p class="small text-muted mb-0">Bricks are being processed in the automated kiln systems.</p>
                            </div>
                        </div>
                        <!-- Ready -->
                        <div class="timeline-step ${getStepClass('READY_FOR_DISPATCH')}">
                            <div class="timeline-icon">
                                <i class="fa-solid fa-boxes-packing"></i>
                            </div>
                            <div class="timeline-content">
                                <h5>Ready For Dispatch</h5>
                                <p class="small text-muted mb-0">Bricks are baked, sorted, and stacked in the stockyard ready for load.</p>
                            </div>
                        </div>
                        <!-- Dispatched -->
                        <div class="timeline-step ${getStepClass('DISPATCHED')}">
                            <div class="timeline-icon">
                                <i class="fa-solid fa-truck-moving"></i>
                            </div>
                            <div class="timeline-content">
                                <h5>Dispatched</h5>
                                <p class="small text-muted mb-0">Vehicles loaded and dispatched to your site location.</p>
                            </div>
                        </div>
                        <!-- Delivered -->
                        <div class="timeline-step ${getStepClass('DELIVERED')}">
                            <div class="timeline-icon">
                                <i class="fa-solid fa-circle-check"></i>
                            </div>
                            <div class="timeline-content">
                                <h5>Delivered</h5>
                                <p class="small text-muted mb-0">Successfully dumped and delivered to your designated location.</p>
                            </div>
                        </div>
                    `;
                }

                trackingResultsColumn.innerHTML = `
                    <div class="card border-0 shadow-sm p-4">
                        <h4 class="text-secondary-custom mb-4 border-bottom pb-2">Tracking Results for: <span class="text-primary-custom">${order.orderNumber}</span></h4>
                        
                        <div class="row g-3 mb-4">
                            <div class="col-sm-6">
                                <span class="text-muted small d-block">Customer</span>
                                <strong class="text-secondary-custom">${order.fullName}</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted small d-block">Product Details</span>
                                <strong class="text-secondary-custom">${order.productTypeName} (${order.quantity} units)</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted small d-block">Expected Delivery Date</span>
                                <strong class="text-secondary-custom">${order.deliveryDate}</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted small d-block">Total Cost</span>
                                <strong class="text-secondary-custom">INR ${order.totalCost.toFixed(2)}</strong>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small font-weight-bold">Current Status</span>
                                <span class="badge bg-primary-custom">${status}</span>
                            </div>
                            <div class="progress" style="height: 12px;">
                                <div class="progress-bar bg-primary-custom progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${progressWidth}%" aria-valuenow="${progressWidth}" aria-valuemin="0" aria-valuemax="100">${progressWidth}%</div>
                            </div>
                        </div>

                        <div class="timeline-container mt-4">
                            ${timelineHtml}
                        </div>
                    </div>
                `;
            })
            .catch(err => {
                console.error(err);
                trackingResultsColumn.innerHTML = `
                    <div class="alert alert-warning border-0 shadow-sm p-4 text-center">
                        <i class="fa-solid fa-triangle-exclamation fa-3x text-warning mb-3"></i>
                        <h5>Order Not Found</h5>
                        <p class="small text-muted mb-0">Double check the Order ID format (e.g. DSBI-123456) and mobile number matched during checkout.</p>
                    </div>
                `;
            });
        });
    }
});
