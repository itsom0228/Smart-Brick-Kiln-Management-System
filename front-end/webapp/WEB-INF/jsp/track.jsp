<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Page Title Header -->
<section class="bg-secondary-custom text-white py-5 mb-5" style="background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);">
    <div class="container text-center py-3">
        <h1 class="display-5 font-weight-bold" data-aos="fade-down"><spring:message code="track.title"/></h1>
        <p class="lead text-white-50" data-aos="fade-up"><spring:message code="track.subtitle"/></p>
    </div>
</section>

<section class="mb-5">
    <div class="container">
        <div class="row justify-content-center">
            
            <!-- Left Side: Track Form -->
            <div class="col-lg-5 mb-4" data-aos="fade-right">
                <div class="glass-card p-4">
                    <h4 class="text-secondary-custom mb-3"><i class="fa-solid fa-route me-2 text-primary-custom"></i>Track Delivery</h4>
                    
                    <form id="track-form" action="${pageContext.request.contextPath}/order/track/search" method="post">
                        <!-- Include CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="mb-3">
                            <label class="form-label"><spring:message code="track.form.orderNo"/></label>
                            <input type="text" name="orderNumber" value="${orderNumber}" required class="form-control" placeholder="e.g. DSBI-123456">
                        </div>
                        <div class="mb-4">
                            <label class="form-label"><spring:message code="track.form.mobile"/></label>
                            <input type="tel" name="mobileNumber" value="${mobileNumber}" required class="form-control" placeholder="10-digit number">
                        </div>
                        <button type="submit" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold"><spring:message code="track.form.btn"/></button>
                    </form>
                </div>
            </div>

            <!-- Right Side: Tracking results -->
            <div class="col-lg-7" id="tracking-results-column" data-aos="fade-left">
                <c:if test="${found == true}">
                    <div class="glass-card p-4">
                        <h4 class="text-secondary-custom mb-4 border-bottom pb-2">Tracking Results for: <span class="text-primary-custom">${order.orderNumber}</span></h4>
                        
                        <!-- Customer details details -->
                        <div class="row g-3 mb-4">
                            <div class="col-sm-6">
                                <span class="text-muted small d-block"><spring:message code="track.customerLabel"/></span>
                                <strong class="text-secondary-custom">${order.fullName}</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted small d-block"><spring:message code="track.productLabel"/></span>
                                <strong class="text-secondary-custom">${order.productTypeName} (${order.quantity} units)</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted small d-block"><spring:message code="track.dateLabel"/></span>
                                <strong class="text-secondary-custom">${order.orderDate.toLocalDate()}</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted small d-block"><spring:message code="track.addressLabel"/></span>
                                <strong class="text-secondary-custom">${order.fullAddress}, ${order.village}, ${order.taluka}</strong>
                            </div>
                        </div>

                        <!-- Progress Bar percentage -->
                        <div class="mb-4">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small font-weight-bold"><spring:message code="track.statusLabel"/></span>
                                <span class="badge bg-primary-custom">${order.currentStatus}</span>
                            </div>
                            <div class="progress" style="height: 12px; border-radius: 6px; background-color: rgba(0,0,0,0.05);">
                                <div class="progress-bar bg-primary-custom progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${order.statusProgress}%" aria-valuenow="${order.statusProgress}" aria-valuemin="0" aria-valuemax="100">${order.statusProgress}%</div>
                            </div>
                        </div>

                        <!-- Step timeline -->
                        <div class="timeline-container mt-4">
                            <!-- Pending -->
                            <div class="timeline-step ${order.currentStatus == 'PENDING' ? 'active' : 'completed'}">
                                <div class="timeline-icon">
                                    <i class="fa-solid fa-clock"></i>
                                </div>
                                <div class="timeline-content">
                                    <h5><spring:message code="track.timeline.pending"/></h5>
                                    <p class="small text-muted mb-0">We have received your brick order and are validating details.</p>
                                </div>
                            </div>
                            <!-- Approved -->
                            <c:if test="${order.currentStatus != 'REJECTED'}">
                                <div class="timeline-step ${order.currentStatus == 'APPROVED' ? 'active' : (order.currentStatus != 'PENDING' ? 'completed' : '')}">
                                    <div class="timeline-icon">
                                        <i class="fa-solid fa-thumbs-up"></i>
                                    </div>
                                    <div class="timeline-content">
                                        <h5><spring:message code="track.timeline.approved"/></h5>
                                        <p class="small text-muted mb-0">Admin approved. Order transitioned to manufacturing.</p>
                                    </div>
                                </div>
                                <!-- Production -->
                                <div class="timeline-step ${order.currentStatus == 'PRODUCTION_STARTED' ? 'active' : (order.currentStatus != 'PENDING' && order.currentStatus != 'APPROVED' ? 'completed' : '')}">
                                    <div class="timeline-icon">
                                        <i class="fa-solid fa-industry"></i>
                                    </div>
                                    <div class="timeline-content">
                                        <h5><spring:message code="track.timeline.production"/></h5>
                                        <p class="small text-muted mb-0">Bricks are being processed in the automated kiln systems.</p>
                                    </div>
                                </div>
                                <!-- Ready -->
                                <div class="timeline-step ${order.currentStatus == 'READY_FOR_DISPATCH' ? 'active' : (order.currentStatus != 'PENDING' && order.currentStatus != 'APPROVED' && order.currentStatus != 'PRODUCTION_STARTED' ? 'completed' : '')}">
                                    <div class="timeline-icon">
                                        <i class="fa-solid fa-boxes-packing"></i>
                                    </div>
                                    <div class="timeline-content">
                                        <h5><spring:message code="track.timeline.ready"/></h5>
                                        <p class="small text-muted mb-0">Bricks are baked, sorted, and stacked in the stockyard ready for load.</p>
                                    </div>
                                </div>
                                <!-- Dispatched -->
                                <div class="timeline-step ${order.currentStatus == 'DISPATCHED' ? 'active' : (order.currentStatus == 'DELIVERED' ? 'completed' : '')}">
                                    <div class="timeline-icon">
                                        <i class="fa-solid fa-truck-moving"></i>
                                    </div>
                                    <div class="timeline-content">
                                        <h5><spring:message code="track.timeline.dispatched"/></h5>
                                        <p class="small text-muted mb-0">Vehicles loaded and dispatched to your site location.</p>
                                    </div>
                                </div>
                                <!-- Delivered -->
                                <div class="timeline-step ${order.currentStatus == 'DELIVERED' ? 'completed' : ''}">
                                    <div class="timeline-icon">
                                        <i class="fa-solid fa-circle-check"></i>
                                    </div>
                                    <div class="timeline-content">
                                        <h5><spring:message code="track.timeline.delivered"/></h5>
                                        <p class="small text-muted mb-0">Successfully dumped and delivered to your designated location.</p>
                                    </div>
                                </div>
                            </c:if>
                            
                            <!-- Rejected state fallback -->
                            <c:if test="${order.currentStatus == 'REJECTED'}">
                                <div class="timeline-step active">
                                    <div class="timeline-icon bg-danger text-white border-danger">
                                        <i class="fa-solid fa-circle-xmark"></i>
                                    </div>
                                    <div class="timeline-content border-danger bg-danger-subtle">
                                        <h5 class="text-danger font-weight-bold">Order Rejected</h5>
                                        <p class="small text-muted mb-0">This order has been cancelled or rejected by administration. Please contact owner Dipak Sarpane for details.</p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-warning border-0 shadow-sm p-4 text-center">
                        <i class="fa-solid fa-triangle-exclamation fa-3x text-warning mb-3"></i>
                        <h5>${error}</h5>
                        <p class="small text-muted mb-0">Double check the Order ID format (e.g. DSBI-123456) and mobile number matched during checkout.</p>
                    </div>
                </c:if>

                <c:if test="${empty found && empty error}">
                    <div class="glass-card p-5 text-center text-muted">
                        <i class="fa-solid fa-route fa-4x text-light mb-3" style="opacity: 0.5;"></i>
                        <h5>Enter Details to Track Order</h5>
                        <p class="small mb-0">Your unique order ID is printed on the order placement page and success landing page.</p>
                    </div>
                </c:if>
            </div>
            
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
