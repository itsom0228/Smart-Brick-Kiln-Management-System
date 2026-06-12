<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

            <jsp:include page="header.jsp" />

            <!-- Hero Banner -->
            <section class="hero-section">
                <div class="container">
                    <div class="row align-items-center g-5">
                        <div class="col-lg-6 hero-content text-start">
                            <span class="badge bg-primary-custom px-3 py-2 text-uppercase mb-3" data-aos="fade-right">
                                <spring:message code="nav.brand" />
                            </span>
                            <h1 class="hero-title" data-aos="fade-right" data-aos-delay="100">
                                <spring:message code="hero.title" />
                            </h1>
                            <p class="hero-tagline" data-aos="fade-right" data-aos-delay="200">
                                <spring:message code="hero.tagline" />
                            </p>
                            <div class="d-flex flex-wrap gap-3" data-aos="fade-up" data-aos-delay="300">
                                <a href="${pageContext.request.contextPath}/order/now"
                                    class="btn btn-primary-custom btn-lg"><i class="fa-solid fa-cart-shopping me-2"></i>
                                    <spring:message code="hero.orderBtn" />
                                </a>
                                <a href="${pageContext.request.contextPath}/quotation/request"
                                    class="btn btn-outline-light btn-lg border-2"><i
                                        class="fa-solid fa-file-invoice-dollar me-2"></i>
                                    <spring:message code="hero.quoteBtn" />
                                </a>
                                <a href="tel:+919588430156" class="btn btn-dark btn-lg border border-secondary"><i
                                        class="fa-solid fa-phone me-2 text-accent-custom"></i>
                                    <spring:message code="hero.callBtn" />
                                </a>
                                <a href="https://wa.me/919588430156?text=Hello,%20I%20want%20information%20about%20your%20bricks."
                                    target="_blank" class="btn btn-success btn-lg"><i
                                        class="fa-brands fa-whatsapp me-2"></i>
                                    <spring:message code="hero.whatsappBtn" />
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6 text-center" data-aos="fade-left" data-aos-delay="200">
                            <div class="p-2 glass-card d-inline-block shadow-lg" style="border-radius: 20px;">
                                <img src="${pageContext.request.contextPath}/images/visiting-card.jpg" alt="Sarpane Vit Suppliers Banner" class="hero-banner-img img-fluid" style="border-radius: 16px; max-height: 360px; object-fit: cover;">
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Stats Cards -->
            <section class="py-5">
                <div class="container">
                    <div class="row g-4 text-center">
                        <div class="col-md-3 col-6" data-aos="zoom-in" data-aos-delay="100">
                            <div class="stats-card p-4">
                                <div class="stats-number">2,000+</div>
                                <div class="stats-label text-uppercase">
                                    <spring:message code="stats.happyCustomers" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-6" data-aos="zoom-in" data-aos-delay="200">
                            <div class="stats-card p-4">
                                <div class="stats-number">12,000+</div>
                                <div class="stats-label text-uppercase">
                                    <spring:message code="stats.ordersDelivered" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-6" data-aos="zoom-in" data-aos-delay="300">
                            <div class="stats-card p-4">
                                <div class="stats-number">17,000+</div>
                                <div class="stats-label text-uppercase">
                                    <spring:message code="stats.dailyProduction" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-6" data-aos="zoom-in" data-aos-delay="400">
                            <div class="stats-card p-4">
                                <div class="stats-number">15+</div>
                                <div class="stats-label text-uppercase">
                                    <spring:message code="stats.yearsExp" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- About Company Section -->
            <section class="py-5">
                <div class="container">
                    <div class="row align-items-center g-5">
                        <div class="col-lg-6" data-aos="fade-right">
                            <h2 class="text-secondary-custom font-weight-bold mb-4">
                                <spring:message code="about.title" />
                            </h2>
                            <h4 class="text-primary-custom mb-3">
                                <spring:message code="about.history" />
                            </h4>
                            <p class="text-muted">
                                <spring:message code="about.historyText" />
                            </p>
                            <div class="row g-4 mt-2">
                                <div class="col-sm-6">
                                    <div class="d-flex align-items-center">
                                        <i class="fa-solid fa-eye fa-2x text-accent-custom me-3"></i>
                                        <div>
                                            <h5 class="mb-1 text-secondary-custom">
                                                <spring:message code="about.vision" />
                                            </h5>
                                            <p class="small text-muted mb-0">
                                                <spring:message code="about.visionText" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="d-flex align-items-center">
                                        <i class="fa-solid fa-bullseye fa-2x text-primary-custom me-3"></i>
                                        <div>
                                            <h5 class="mb-1 text-secondary-custom">
                                                <spring:message code="about.mission" />
                                            </h5>
                                            <p class="small text-muted mb-0">
                                                <spring:message code="about.missionText" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6" data-aos="fade-left">
                            <div class="glass-card overflow-hidden">
                                <div class="row g-0">
                                   <div class="col-md-5 bg-secondary-custom d-flex flex-column align-items-center justify-content-center text-white py-4" style="background-color: var(--secondary-color) !important;">
                                        <img src="${pageContext.request.contextPath}/images/owner.png"
                                             alt="Dipak Sarpane"
                                             class="rounded-circle shadow mb-3"
                                             style="width: 120px; height: 120px; object-fit: cover; border: 3px solid var(--border-color);">
                                        <h5 class="mb-0 text-white">Dipak Sarpane</h5>
                                        <small class="text-white-50 text-center px-2 mt-1">
                                            <spring:message code="about.ownerTitle" />
                                        </small>
                                    </div>
                                    <div class="col-md-7">
                                        <div class="card-body p-4">
                                            <h5 class="card-title text-primary-custom">
                                                <spring:message code="about.ownerMessage" />
                                            </h5>
                                            <p class="card-text text-muted" style="font-style: italic;">
                                                <spring:message code="about.ownerText" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Why Choose Us Section -->
            <section class="py-5">
                <div class="container">
                    <div class="text-center mb-5" data-aos="fade-up">
                        <h2 class="text-secondary-custom font-weight-bold">
                            <spring:message code="wcu.title" />
                        </h2>
                        <p class="text-muted">
                            <spring:message code="wcu.subtitle" />
                        </p>
                    </div>
                    <div class="row g-4">
                        <!-- 8 Cards -->
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-gem fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card1.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card1.desc" />
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-gears fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card2.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card2.desc" />
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-truck-fast fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card3.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card3.desc" />
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-tags fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card4.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card4.desc" />
                                </p>
                            </div>
                        </div>
                        <!-- Row 2 -->
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-circle-check fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card5.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card5.desc" />
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-face-smile fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card6.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card6.desc" />
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-industry fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card7.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card7.desc" />
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                            <div class="glass-card h-100 p-4 text-center">
                                <i class="fa-solid fa-headset fa-3x text-primary-custom mb-3"></i>
                                <h5>
                                    <spring:message code="wcu.card8.title" />
                                </h5>
                                <p class="small text-muted mb-0">
                                    <spring:message code="wcu.card8.desc" />
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Price Calculator Module -->
            <section id="estimator-calculator" class="py-5">
                <div class="container">
                    <div class="row align-items-stretch g-5">
                        <div class="col-lg-6" data-aos="fade-right">
                            <div class="glass-card p-4 p-md-5 h-100 d-flex flex-column justify-content-between">
                                <div>
                                    <h3 class="mb-4 text-primary-custom"><i class="fa-solid fa-calculator me-2"></i>
                                        <spring:message code="calc.title" />
                                    </h3>

                                    <form id="calc-form">
                                        <div class="mb-3">
                                            <label class="form-label">
                                                <spring:message code="calc.product" />
                                            </label>
                                            <select id="calc-product" class="form-select py-2" required>
                                                <option value="" disabled selected>-- Choose Product --</option>
                                                <c:forEach var="p" items="${products}">
                                                    <option value="${p.id}" data-price="${p.price}">${p.name} (Rs ${p.price}/unit)</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-4">
                                            <label class="form-label">
                                                <spring:message code="calc.quantity" />
                                            </label>
                                            <input type="number" id="calc-quantity" min="1" placeholder="e.g. 5000" class="form-control py-2">
                                        </div>
                                    </form>
                                </div>
                                <button id="btn-calculate" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold mt-3">
                                    <spring:message code="calc.btn" />
                                </button>
                            </div>
                        </div>
                        <div class="col-lg-6" data-aos="fade-left">
                            <div class="glass-card p-4 p-md-5 h-100 d-flex flex-column justify-content-between">
                                <div>
                                    <h4 class="text-secondary-custom border-bottom pb-3 mb-4 font-weight-bold">Cost Estimation Summary</h4>

                                    <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                                        <span class="text-muted">
                                            <spring:message code="calc.prodCost" />:
                                        </span>
                                        <strong class="text-secondary-custom">INR <span id="calc-res-product-cost">0.00</span></strong>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                                        <span class="text-muted">
                                            <spring:message code="calc.gst" arguments="${not empty settings.GST_RATE ? settings.GST_RATE : 12}" />:
                                        </span>
                                        <strong class="text-secondary-custom">INR <span id="calc-res-gst">0.00</span></strong>
                                    </div>
                                    <div class="d-flex justify-content-between mb-4 border-bottom pb-2">
                                        <span class="text-muted">
                                            <spring:message code="calc.transport" />:
                                        </span>
                                        <strong class="text-secondary-custom">INR <span id="calc-res-transport">0.00</span></strong>
                                    </div>
                                    <div class="d-flex justify-content-between mb-4">
                                        <h4 class="text-secondary-custom font-weight-bold">
                                            <spring:message code="calc.total" />:
                                        </h4>
                                        <h4 class="text-primary-custom font-weight-bold">INR <span id="calc-res-total">0.00</span></h4>
                                    </div>
                                </div>

                                <p class="small text-muted mb-0" style="font-style: italic;">
                                    <spring:message code="calc.disclaimer" />
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Customer Reviews Slider -->
            <section class="py-5">
                <div class="container">
                    <div class="text-center mb-5" data-aos="fade-up">
                        <h2 class="text-secondary-custom font-weight-bold">
                            <spring:message code="review.title" />
                        </h2>
                        <p class="text-muted">
                            <spring:message code="review.subtitle" />
                        </p>
                    </div>

                    <!-- Review Display -->
                    <div class="row g-4 justify-content-center mb-5">
                        <c:forEach var="rev" items="${reviews}" varStatus="status">
                            <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                                <div class="glass-card h-100 p-4">
                                    <div class="d-flex text-warning mb-3">
                                        <c:forEach begin="1" end="${rev.rating}">
                                            <i class="fa-solid fa-star me-1"></i>
                                        </c:forEach>
                                        <c:forEach begin="1" end="${5 - rev.rating}">
                                            <i class="fa-regular fa-star me-1"></i>
                                        </c:forEach>
                                    </div>
                                    <p class="card-text text-muted" style="font-style: italic;">"${rev.reviewText}"</p>
                                    <h6 class="mt-3 text-secondary-custom font-weight-bold mb-0">- ${rev.fullName}</h6>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty reviews}">
                            <div class="col-12 text-center text-muted">No reviews approved yet. Be the first to submit a review below!</div>
                        </c:if>
                    </div>

                    <!-- Review Submit Form -->
                    <div class="row justify-content-center">
                        <div class="col-lg-8" data-aos="fade-up">
                            <div class="glass-card p-4 p-md-5">
                                <h4 class="text-secondary-custom text-center mb-4 font-weight-bold">
                                    <spring:message code="review.submitTitle" />
                                </h4>

                                <!-- Flash Message Success -->
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <spring:message code="${successMessage}" />
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <form id="review-form" action="${pageContext.request.contextPath}/review/submit" method="post">
                                    <!-- Include CSRF Token -->
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <spring:message code="review.nameLabel" />
                                            </label>
                                            <input type="text" name="fullName" required class="form-control" placeholder="Ramesh Kumar">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <spring:message code="review.ratingLabel" />
                                            </label>
                                            <select name="rating" required class="form-select">
                                                <option value="5" selected>5 Stars - Excellent</option>
                                                <option value="4">4 Stars - Good</option>
                                                <option value="3">3 Stars - Average</option>
                                                <option value="2">2 Stars - Poor</option>
                                                <option value="1">1 Star - Horrible</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-4">
                                        <label class="form-label">
                                            <spring:message code="review.textLabel" />
                                        </label>
                                        <textarea name="reviewText" rows="4" required class="form-control" placeholder="Share your experience with our quality and service..."></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold">
                                        <spring:message code="review.btn" />
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <jsp:include page="footer.jsp" />