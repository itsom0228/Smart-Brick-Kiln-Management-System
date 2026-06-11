<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Hero Banner (About Us) -->
<section class="about-hero-section py-5 bg-dark text-white text-center" style="background: linear-gradient(rgba(33, 37, 41, 0.8), rgba(33, 37, 41, 0.9)), url('${pageContext.request.contextPath}/images/visiting-card.jpg') no-repeat center center; background-size: cover; min-height: 250px; display: flex; align-items: center; justify-content: center;">
    <div class="container" data-aos="fade-up">
        <h1 class="display-4 font-weight-bold text-accent-custom text-uppercase">About Our Journey</h1>
        <p class="lead">Dipak Sarpane Brick Industries &bull; Sarpane Vit Suppliers</p>
    </div>
</section>

<!-- Company Overview & Mission -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-6" data-aos="fade-right">
                <span class="badge bg-primary-custom px-3 py-2 text-uppercase mb-3">WHO WE ARE</span>
                <h2 class="text-secondary-custom font-weight-bold mb-4">Building Strong Foundations Since 2011</h2>
                <p class="text-muted lead">Sarpane Vit Suppliers is a trusted brand in Maharashtra for premium red clay bricks and fly ash bricks, manufacturing over 100,000 high-compressive-strength bricks daily.</p>
                <p class="text-muted">Our automated kiln in Dharashiv (Osmanabad) ensures computerized quality control, uniform dimensions, and maximum durability for home and industrial constructions.</p>
                
                <div class="row g-4 mt-3">
                    <div class="col-sm-6">
                        <div class="card border-0 shadow-sm p-3 bg-white h-100">
                            <h5 class="text-primary-custom mb-2"><i class="fa-solid fa-eye me-2"></i>Our Vision</h5>
                            <p class="small text-muted mb-0">To lead the building materials industry in Maharashtra through eco-friendly brick processing, outstanding service, and reliable deliveries.</p>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="card border-0 shadow-sm p-3 bg-white h-100">
                            <h5 class="text-secondary-custom mb-2"><i class="fa-solid fa-bullseye me-2"></i>Our Mission</h5>
                            <p class="small text-muted mb-0">To offer premium-grade 6-inch and 4-inch bricks directly to customers without middleman margins, securing their home's longevity.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6" data-aos="fade-left">
                <div class="position-relative p-3">
                    <div class="position-absolute top-0 start-0 w-100 h-100 bg-primary-custom rounded-4" style="transform: rotate(-3deg); z-index: 1; opacity: 0.1;"></div>
                    <img src="${pageContext.request.contextPath}/images/visiting-card.jpg" alt="Sarpane Vit Suppliers Business Card" class="img-fluid rounded-4 shadow-lg position-relative" style="z-index: 2; width: 100%;">
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Emotional Success Story: The Empire of Gokul & Dipak Sarpane -->
<section class="py-5 bg-white text-dark">
    <div class="container">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="badge bg-primary-custom px-3 py-2 text-uppercase mb-2"><spring:message code="about.legacyTitle"/></span>
            <h2 class="text-secondary-custom font-weight-bold"><spring:message code="about.legacySubtitle"/></h2>
            <p class="text-muted">The emotional journey behind Dipak Sarpane Brick Industries</p>
        </div>
        
        <div class="row align-items-center g-5">
            <div class="col-lg-5 text-center" data-aos="fade-right">
                <div class="owner-photo-frame shadow-lg p-2 bg-white rounded-4 border border-light mx-auto" style="max-width: 380px;">
                    <img src="${pageContext.request.contextPath}/images/owner.png" alt="Dipak Gokul Sarpane" class="img-fluid rounded-4" style="object-fit: cover; width: 100%; height: auto;">
                    <div class="bg-secondary-custom text-white p-3 rounded-bottom-4 mt-2">
                        <h5 class="mb-0 text-accent-custom">Dipak Gokul Sarpane</h5>
                        <small class="text-white-50"><spring:message code="about.ownerTitle"/></small>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-7" data-aos="fade-left">
                <div class="ps-lg-4">
                    <h4 class="text-primary-custom mb-3 font-weight-bold"><spring:message code="about.fatherStoryTitle"/></h4>
                    <p class="text-muted" style="line-height: 1.8;">
                        <spring:message code="about.fatherStoryText1"/>
                    </p>
                    <p class="text-muted" style="line-height: 1.8;">
                        <spring:message code="about.fatherStoryText2"/>
                    </p>
                    <div class="quote-block border-start border-primary border-4 ps-3 my-4 bg-light py-3 rounded-end">
                        <p class="mb-0 text-dark font-italic" style="font-style: italic; font-size: 1.1rem;">
                            <spring:message code="about.fatherStoryQuote"/>
                        </p>
                        <cite class="d-block mt-2 small text-muted">— Dipak Sarpane</cite>
                    </div>
                    <p class="text-muted" style="line-height: 1.8;">
                        <spring:message code="about.fatherStoryText3"/>
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Interactive Factory Location & Contact Info -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row g-4 justify-content-center text-center mb-5" data-aos="fade-up">
            <div class="col-lg-8">
                <h3 class="text-secondary-custom font-weight-bold">Reach Out to Us</h3>
                <p class="text-muted">For bulk orders, dealer opportunities, or direct factory site visits</p>
            </div>
        </div>
        
        <div class="row g-4">
            <div class="col-md-4" data-aos="zoom-in" data-aos-delay="100">
                <div class="card border-0 shadow-sm p-4 text-center h-100 bg-white">
                    <i class="fa-solid fa-location-dot fa-3x text-primary-custom mb-3"></i>
                    <h5 class="font-weight-bold text-secondary-custom">Factory Address</h5>
                    <p class="text-muted small">Hingangaon Bk, Tq: Paranda,<br>Osmanabad (Dharashiv),<br>Maharashtra - 413502</p>
                    <a href="https://maps.google.com/?q=Hingangaon+Bk+Paranda" target="_blank" class="btn btn-sm btn-outline-dark mt-auto"><i class="fa-solid fa-map-location-dot me-1"></i> Locate on Google Maps</a>
                </div>
            </div>
            
            <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                <div class="card border-0 shadow-sm p-4 text-center h-100 bg-white">
                    <i class="fa-solid fa-phone-volume fa-3x text-secondary-custom mb-3"></i>
                    <h5 class="font-weight-bold text-secondary-custom">Direct Call / WhatsApp</h5>
                    <p class="text-muted small">Talk directly to owner Dipak Sarpane or write on WhatsApp for instant quotes.</p>
                    <h6 class="font-weight-bold mb-3">+91 95884 30156</h6>
                    <div class="d-flex gap-2 justify-content-center mt-auto">
                        <a href="tel:+919588430156" class="btn btn-sm btn-dark"><i class="fa-solid fa-phone me-1"></i> Call Now</a>
                        <a href="https://wa.me/919588430156?text=Hello,%20I%20want%20information%20about%20your%20bricks." target="_blank" class="btn btn-sm btn-success"><i class="fa-brands fa-whatsapp me-1"></i> WhatsApp</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4" data-aos="zoom-in" data-aos-delay="300">
                <div class="card border-0 shadow-sm p-4 text-center h-100 bg-white">
                    <i class="fa-solid fa-envelope-open-text fa-3x text-accent-custom mb-3"></i>
                    <h5 class="font-weight-bold text-secondary-custom">Online Desk</h5>
                    <p class="text-muted small">Send official RFQs or messages to our company email desk.</p>
                    <h6 class="font-weight-bold mb-3">dipaksarpane@gmail.com</h6>
                    <div class="d-flex gap-2 justify-content-center mt-auto">
                        <a href="mailto:dipaksarpane@gmail.com" class="btn btn-sm btn-outline-dark"><i class="fa-solid fa-envelope me-1"></i> Email Us</a>
                        <a href="https://www.instagram.com/dipaksarpane?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==" target="_blank" class="btn btn-sm btn-outline-danger"><i class="fa-brands fa-instagram me-1"></i> Instagram</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
