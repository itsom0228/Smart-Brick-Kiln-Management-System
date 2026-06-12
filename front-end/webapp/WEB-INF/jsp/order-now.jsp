<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Page Title Header -->
<section class="bg-secondary-custom text-white py-5 mb-5" style="background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);">
    <div class="container text-center py-3">
        <h1 class="display-5 font-weight-bold" data-aos="fade-down"><spring:message code="order.title"/></h1>
        <p class="lead text-white-50" data-aos="fade-up"><spring:message code="order.subtitle"/></p>
    </div>
</section>

<section class="mb-5">
    <div class="container">
        <!-- Error alert -->
        <c:if var="hasError" test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form id="order-form" action="${pageContext.request.contextPath}/order/submit" method="post" class="needs-validation" novalidate>
            <!-- Include CSRF Token -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="row g-4">
                <!-- Left Column: Customer details -->
                <div class="col-lg-7" data-aos="fade-right">
                    <div class="glass-card p-4 h-100">
                        <h4 class="text-secondary-custom mb-4 border-bottom pb-2"><i class="fa-solid fa-user-circle me-2 text-primary-custom"></i><spring:message code="order.detailsHeader"/></h4>
                        
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label"><spring:message code="order.form.name"/> <span class="text-danger">*</span></label>
                                <input type="text" name="fullName" value="${order.fullName}" required class="form-control" placeholder="Dipak Sarpane">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="order.form.mobile"/> <span class="text-danger">*</span></label>
                                <input type="tel" name="mobileNumber" pattern="[0-9]{10}" value="${order.mobileNumber}" required class="form-control" placeholder="10-digit number">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="order.form.altMobile"/></label>
                                <input type="tel" name="alternateMobileNumber" pattern="[0-9]{10}" value="${order.alternateMobileNumber}" class="form-control" placeholder="Optional number">
                            </div>
                            <div class="col-12">
                                <label class="form-label"><spring:message code="order.form.email"/></label>
                                <input type="email" name="emailAddress" value="${order.emailAddress}" class="form-control" placeholder="customer@domain.com">
                            </div>
                            <div class="col-12">
                                <label class="form-label"><spring:message code="order.form.address"/> <span class="text-danger">*</span></label>
                                <textarea name="fullAddress" rows="3" required class="form-control" placeholder="Flat/House No, Building Name, Landmark...">${order.fullAddress}</textarea>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label"><spring:message code="order.form.village"/> <span class="text-danger">*</span></label>
                                <input type="text" name="village" value="${order.village}" required class="form-control" placeholder="Village name">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label"><spring:message code="order.form.taluka"/> <span class="text-danger">*</span></label>
                                <input type="text" name="taluka" value="${order.taluka}" required class="form-control" placeholder="Taluka">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label"><spring:message code="order.form.district"/> <span class="text-danger">*</span></label>
                                <input type="text" name="district" value="${order.district}" required class="form-control" placeholder="District">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="order.form.state"/> <span class="text-danger">*</span></label>
                                <input type="text" name="state" value="Maharashtra" required class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="order.form.pincode"/> <span class="text-danger">*</span></label>
                                <input type="text" name="pincode" pattern="[0-9]{6}" value="${order.pincode}" required class="form-control" placeholder="6-digit code">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Order Details -->
                <div class="col-lg-5" data-aos="fade-left">
                    <div class="glass-card p-4 mb-4">
                        <h4 class="text-secondary-custom mb-4 border-bottom pb-2"><i class="fa-solid fa-cart-flatbed me-2 text-primary-custom"></i><spring:message code="order.prodHeader"/></h4>
                        
                        <div class="mb-3">
                            <label class="form-label"><spring:message code="order.form.product"/> <span class="text-danger">*</span></label>
                            <select id="calc-product" name="product.id" required class="form-select py-2">
                                <option value="" disabled selected>-- Choose Product --</option>
                                <c:forEach var="p" items="${products}">
                                    <option value="${p.id}" data-price="${p.price}" ${order.product.id == p.id ? 'selected' : ''}>${p.name} (Rs ${p.price}/unit)</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><spring:message code="order.form.quantity"/> <span class="text-danger">*</span></label>
                            <input type="number" id="calc-quantity" name="quantity" min="500" value="${order.quantity != null ? order.quantity : 1000}" required class="form-control" placeholder="Min. order 500 units">
                            <small class="text-muted">Minimum order capacity is 500 units.</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><spring:message code="order.form.deliveryDate"/> <span class="text-danger">*</span></label>
                            <!-- Date minimum tomorrow -->
                            <input type="date" name="deliveryDate" required class="form-control" id="deliveryDate">
                        </div>
                        <div class="mb-4">
                            <label class="form-label"><spring:message code="order.form.notes"/></label>
                            <textarea name="additionalNotes" rows="2" class="form-control" placeholder="Any specific instructions for delivery vehicles...">${order.additionalNotes}</textarea>
                        </div>
                    </div>

                    <!-- Instant Pricing Preview -->
                    <div class="glass-card p-4 mb-4">
                        <h5 class="text-primary-custom mb-3 font-weight-bold">Live Checkout Estimate</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted"><spring:message code="calc.prodCost"/>:</span>
                            <strong>INR <span id="calc-res-product-cost">0.00</span></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted"><spring:message code="calc.gst" arguments="${not empty settings.GST_RATE ? settings.GST_RATE : 12}"/>:</span>
                            <strong>INR <span id="calc-res-gst">0.00</span></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-3 pb-2 border-bottom">
                            <span class="text-muted"><spring:message code="calc.transport"/>:</span>
                            <strong>INR <span id="calc-res-transport">0.00</span></strong>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="font-weight-bold mb-0 text-secondary-custom">Grand Total:</h5>
                            <h4 class="text-primary-custom mb-0 font-weight-bold">INR <span id="calc-res-total">0.00</span></h4>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold"><i class="fa-solid fa-check-circle me-1"></i><spring:message code="order.form.submit"/></button>
                </div>
            </div>
        </form>
    </div>
</section>

<script>
    // Set min date to tomorrow
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    const minDate = tomorrow.toISOString().split('T')[0];
    document.getElementById('deliveryDate').min = minDate;
</script>

<jsp:include page="footer.jsp" />
