<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Page Title Header -->
<section class="bg-secondary-custom text-white py-5 mb-5" style="background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);">
    <div class="container text-center py-3">
        <h1 class="display-5 font-weight-bold" data-aos="fade-down"><spring:message code="quote.title"/></h1>
        <p class="lead text-white-50" data-aos="fade-up"><spring:message code="quote.subtitle"/></p>
    </div>
</section>

<section class="mb-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8" data-aos="fade-up">
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="glass-card p-4 p-md-5">
                    <form id="quotation-form" action="${pageContext.request.contextPath}/quotation/submit" method="post">
                        <!-- Include CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="quote.form.name"/> <span class="text-danger">*</span></label>
                                <input type="text" name="fullName" value="${quotation.fullName}" required class="form-control" placeholder="Ramesh Patil">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="quote.form.mobile"/> <span class="text-danger">*</span></label>
                                <input type="tel" name="mobileNumber" pattern="[0-9]{10}" value="${quotation.mobileNumber}" required class="form-control" placeholder="10-digit number">
                            </div>
                            <div class="col-12">
                                <label class="form-label"><spring:message code="quote.form.email"/> <span class="text-danger">*</span></label>
                                <input type="email" name="email" value="${quotation.email}" required class="form-control" placeholder="ramesh@domain.com">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="quote.form.product"/> <span class="text-danger">*</span></label>
                                <select id="calc-product" name="product.id" required class="form-select py-2">
                                    <option value="" disabled selected>-- Choose Product --</option>
                                    <c:forEach var="p" items="${products}">
                                        <option value="${p.id}" data-price="${p.price}" ${quotation.product.id == p.id ? 'selected' : ''}>${p.name} (Rs ${p.price}/unit)</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><spring:message code="quote.form.quantity"/> <span class="text-danger">*</span></label>
                                <input type="number" id="calc-quantity" name="quantity" min="500" value="${quotation.quantity != null ? quotation.quantity : 1000}" required class="form-control" placeholder="Min. order 500 units">
                            </div>
                            <div class="col-12">
                                <label class="form-label"><spring:message code="quote.form.address"/> <span class="text-danger">*</span></label>
                                <textarea name="fullAddress" rows="3" required class="form-control" placeholder="Construction site location address details...">${quotation.fullAddress}</textarea>
                            </div>
                        </div>

                        <!-- Live Estimate panel -->
                        <div class="glass-card p-4 my-4" style="background: rgba(255, 255, 255, 0.3) !important;">
                            <h5 class="text-secondary-custom mb-3 font-weight-bold">Quotation Estimate Preview</h5>
                            <div class="row g-2 text-muted small">
                                <div class="col-sm-6">Product Base Cost: <strong class="text-secondary-custom">INR <span id="calc-res-product-cost">0.00</span></strong></div>
                                <div class="col-sm-6">GST (${not empty settings.GST_RATE ? settings.GST_RATE : 12}%): <strong class="text-secondary-custom">INR <span id="calc-res-gst">0.00</span></strong></div>
                                <div class="col-sm-6">Estimated Transport Cost: <strong class="text-secondary-custom">INR <span id="calc-res-transport">0.00</span></strong></div>
                                <div class="col-sm-6 mt-3 border-top pt-2">
                                    <h5 class="mb-0 text-secondary-custom font-weight-bold">Est. Total: <span class="text-primary-custom font-weight-bold">INR <span id="calc-res-total">0.00</span></span></h5>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold"><spring:message code="quote.form.btn"/></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
