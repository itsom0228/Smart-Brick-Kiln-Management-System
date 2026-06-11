<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Page Title Header -->
<section class="bg-secondary-custom text-white py-5 mb-5" style="background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);">
    <div class="container text-center py-3">
        <h1 class="display-5 font-weight-bold" data-aos="fade-down"><spring:message code="nav.gallery"/></h1>
        <p class="lead text-white-50" data-aos="fade-up">Our Manufacturing Infrastructure, Automation Processes, and Dispatch Operations</p>
    </div>
</section>

<!-- Category Filter Buttons -->
<section class="mb-5">
    <div class="container text-center">
        <div class="d-flex flex-wrap justify-content-center gap-2 mb-4" data-aos="fade-up">
            <button class="btn btn-primary-custom filter-btn active" data-filter="all">All Photos</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="factory">Factory & Infrastructure</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="kiln">Kiln Manufacturing</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="process">Production Process</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="products">Products Inventory</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="delivery">Logistics & Delivery</button>
        </div>

        <!-- Gallery Grid -->
        <div class="row g-4 gallery-grid" data-aos="fade-up" data-aos-delay="100">
            <!-- Dynamic Uploaded Images -->
            <c:forEach var="img" items="${dynamicImages}">
                <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="factory">
                    <div class="gallery-item" data-img-url="${img.base64Data}">
                        <img src="${img.base64Data}" alt="${img.title}" style="height: 250px; object-fit: cover; width: 100%;">
                        <div class="gallery-overlay">
                            <h5>${img.title}</h5>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <!-- Item 1 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="factory">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1518640467707-6811f4a6ab73?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1518640467707-6811f4a6ab73?auto=format&fit=crop&w=400&q=80" alt="Factory Infrastructure">
                    <div class="gallery-overlay">
                        <h5>Factory Infrastructure</h5>
                    </div>
                </div>
            </div>
            <!-- Item 2 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="kiln">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1590069261209-f8e9b8642343?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1590069261209-f8e9b8642343?auto=format&fit=crop&w=400&q=80" alt="Kiln Combustion">
                    <div class="gallery-overlay">
                        <h5>Kiln Combustion</h5>
                    </div>
                </div>
            </div>
            <!-- Item 3 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="process">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?auto=format&fit=crop&w=400&q=80" alt="Raw Clay Refining">
                    <div class="gallery-overlay">
                        <h5>Clay Refining</h5>
                    </div>
                </div>
            </div>
            <!-- Item 4 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="products">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1595841696660-1d85de34fc90?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1595841696660-1d85de34fc90?auto=format&fit=crop&w=400&q=80" alt="Red Clay Bricks Stockyard">
                    <div class="gallery-overlay">
                        <h5>Red Clay Bricks</h5>
                    </div>
                </div>
            </div>
            <!-- Item 5 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="delivery">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&w=400&q=80" alt="Logistics Fleet">
                    <div class="gallery-overlay">
                        <h5>Logistics Fleet</h5>
                    </div>
                </div>
            </div>
            <!-- Item 6 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="factory">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=400&q=80" alt="Automated Production Plant">
                    <div class="gallery-overlay">
                        <h5>Automated Plant</h5>
                    </div>
                </div>
            </div>
            <!-- Item 7 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="products">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80" alt="Fly Ash Bricks Stockyard">
                    <div class="gallery-overlay">
                        <h5>Fly Ash Bricks</h5>
                    </div>
                </div>
            </div>
            <!-- Item 8 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="process">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=400&q=80" alt="Quality Standard Inspection">
                    <div class="gallery-overlay">
                        <h5>Quality Inspection</h5>
                    </div>
                </div>
            </div>
            <!-- Item 9 -->
            <div class="col-lg-4 col-md-6 gallery-card-wrapper" data-category="delivery">
                <div class="gallery-item" data-img-url="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=400&q=80" alt="Construction Site Unloading">
                    <div class="gallery-overlay">
                        <h5>Site Delivery</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Lightbox Modal Container -->
<div id="lightbox-modal" class="lightbox-modal d-print-none">
    <div class="lightbox-content">
        <img id="lightbox-img" src="" alt="Zoom Photo">
    </div>
</div>

<jsp:include page="footer.jsp" />
