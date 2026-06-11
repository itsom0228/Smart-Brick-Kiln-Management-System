<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<section class="py-5" data-aos="zoom-in">
    <div class="container my-5 text-center">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card border-0 shadow p-5">
                    <i class="fa-solid fa-file-circle-check fa-5x text-success mb-4"></i>
                    
                    <h2 class="text-secondary-custom font-weight-bold mb-3">Quotation Request Submitted!</h2>
                    <p class="text-muted mb-4"><spring:message code="quote.form.success"/></p>
                    
                    <c:if test="${not empty successQuoteNo or not empty param.quoteNo}">
                        <div class="bg-light p-3 rounded-3 mb-4">
                            <span class="text-muted small text-uppercase font-weight-bold d-block mb-1">Your Quote Request Number</span>
                            <h3 class="text-primary-custom font-weight-bold mb-0">${not empty successQuoteNo ? successQuoteNo : param.quoteNo}</h3>
                        </div>
                    </c:if>

                    <div class="d-flex justify-content-center gap-2">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary-custom">Return to Home</a>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">Products Catalog</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
