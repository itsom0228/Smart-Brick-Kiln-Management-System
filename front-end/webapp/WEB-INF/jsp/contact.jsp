<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Page Title Header -->
<section class="bg-secondary-custom text-white py-5 mb-5" style="background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);">
    <div class="container text-center py-3">
        <h1 class="display-5 font-weight-bold" data-aos="fade-down"><spring:message code="contact.title"/></h1>
        <p class="lead text-white-50" data-aos="fade-up"><spring:message code="contact.subtitle"/></p>
    </div>
</section>

<section class="mb-5">
    <div class="container">
        <div class="row g-4">
            
            <!-- Col 1: Contact Details & Map -->
            <div class="col-lg-6" data-aos="fade-right">
                <div class="card border-0 shadow-sm p-4 mb-4">
                    <h4 class="text-secondary-custom mb-4 border-bottom pb-2">Business Operations Details</h4>
                    
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-primary-custom text-white rounded-circle p-3 me-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-phone"></i>
                        </div>
                        <div>
                            <span class="text-muted small d-block"><spring:message code="contact.phone"/></span>
                            <strong class="text-secondary-custom">+91 95884 30156</strong>
                        </div>
                    </div>
                    
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-success text-white rounded-circle p-3 me-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-brands fa-whatsapp"></i>
                        </div>
                        <div>
                            <span class="text-muted small d-block"><spring:message code="contact.whatsapp"/></span>
                            <strong class="text-secondary-custom">+91 95884 30156</strong>
                        </div>
                    </div>

                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-secondary text-white rounded-circle p-3 me-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-envelope"></i>
                        </div>
                        <div>
                            <span class="text-muted small d-block"><spring:message code="contact.email"/></span>
                            <strong class="text-secondary-custom">dipaksarpane@gmail.com</strong>
                        </div>
                    </div>

                    <div class="d-flex align-items-center mb-0">
                        <div class="bg-secondary-custom text-white rounded-circle p-3 me-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-map-location-dot"></i>
                        </div>
                        <div>
                            <span class="text-muted small d-block"><spring:message code="contact.address"/></span>
                            <strong class="text-secondary-custom">Maharashtra, Osmanabad (Dharashiv), Tq: Paranda, Village: Hingangaon Bk, PIN: 413502</strong>
                        </div>
                    </div>
                </div>

                <!-- Google Map Embed (Paranda/Hingangaon location) -->
                <div class="card border-0 shadow-sm overflow-hidden" style="height: 250px;">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3766.4259837943534!2d75.4475470761184!3d19.26388478697669!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc53759e612c6ab%3A0xc00bb7a79f32371!2sParanda%2C%20Maharashtra!5e0!3m2!1sen!2sin!4v1680000000000!5m2!1sen!2sin" 
                        width="100%" 
                        height="100%" 
                        style="border:0;" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>

            <!-- Col 2: Contact Form -->
            <div class="col-lg-6" data-aos="fade-left">
                <div class="card border-0 shadow-sm p-5 h-100">
                    <h4 class="text-secondary-custom mb-4 border-bottom pb-2"><i class="fa-solid fa-envelope-open-text me-2 text-primary-custom"></i><spring:message code="contact.messageTitle"/></h4>
                    
                    <!-- Flash Message Success -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <spring:message code="${successMessage}"/>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form id="contact-form" action="${pageContext.request.contextPath}/enquiry/submit" method="post">
                        <!-- Include CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="mb-3">
                            <label class="form-label"><spring:message code="contact.form.name"/> <span class="text-danger">*</span></label>
                            <input type="text" name="fullName" required class="form-control" placeholder="Dipak Sarpane">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><spring:message code="contact.form.mobile"/> <span class="text-danger">*</span></label>
                                <input type="tel" name="mobileNumber" pattern="[0-9]{10}" required class="form-control" placeholder="10-digit mobile">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><spring:message code="contact.form.email"/></label>
                                <input type="email" name="email" class="form-control" placeholder="Optional email">
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label"><spring:message code="contact.form.message"/> <span class="text-danger">*</span></label>
                            <textarea name="messageText" rows="4" required class="form-control" placeholder="Describe your construction requirement, brick quantities, or generic inquiries..."></textarea>
                        </div>
                        
                        <button type="submit" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold"><spring:message code="contact.form.submit"/></button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
