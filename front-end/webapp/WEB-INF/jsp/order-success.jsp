<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<section class="py-5" data-aos="zoom-in">
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 text-center">
                <!-- Success Card -->
                <div class="card border-0 shadow p-5">
                    <i class="fa-solid fa-circle-check fa-5x text-success mb-4"></i>
                    
                    <h2 class="text-secondary-custom font-weight-bold mb-3"><spring:message code="success.title"/></h2>
                    <p class="text-muted mb-4"><spring:message code="success.message"/></p>
                    
                    <!-- Order Number Block -->
                    <div class="bg-light p-4 rounded-3 mb-4">
                        <span class="text-muted small text-uppercase font-weight-bold d-block mb-1"><spring:message code="success.orderNo"/></span>
                        <h1 class="text-primary-custom font-weight-bold mb-2">${order.orderNumber}</h1>
                        <p class="small text-muted mb-0"><spring:message code="success.trackPrompt"/></p>
                    </div>

                    <!-- Summary details -->
                    <div class="text-start border p-4 rounded-3 mb-4">
                        <h5 class="text-secondary-custom mb-3 border-bottom pb-2">Order Summary</h5>
                        <div class="row g-2">
                            <div class="col-sm-6">
                                <span class="text-muted">Customer Name:</span>
                                <strong class="d-block text-secondary-custom">${order.fullName}</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted">Mobile Number:</span>
                                <strong class="d-block text-secondary-custom">${order.mobileNumber}</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted">Product Ordered:</span>
                                <strong class="d-block text-secondary-custom">${order.productTypeName}</strong>
                            </div>
                            <div class="col-sm-6">
                                <span class="text-muted">Quantity:</span>
                                <strong class="d-block text-secondary-custom">${order.quantity} Units</strong>
                            </div>
                            <div class="col-12 mt-2">
                                <span class="text-muted">Estimated Total Cost:</span>
                                <h5 class="text-primary-custom font-weight-bold mb-0">INR ${order.totalCost}</h5>
                            </div>
                        </div>
                    </div>

                    <!-- Redirection actions -->
                    <div class="d-flex flex-wrap justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/order/track/search?orderNumber=${order.orderNumber}&mobileNumber=${order.mobileNumber}" class="btn btn-primary-custom btn-lg">
                            <i class="fa-solid fa-route me-2"></i><spring:message code="success.trackBtn"/>
                        </a>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-lg">
                            <spring:message code="nav.products"/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
