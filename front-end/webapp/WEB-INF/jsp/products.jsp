<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Page Title Header -->
<section class="bg-secondary-custom text-white py-5 mb-5" style="background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);">
    <div class="container text-center py-3">
        <h1 class="display-5 font-weight-bold" data-aos="fade-down"><spring:message code="nav.products"/></h1>
        <p class="lead text-white-50" data-aos="fade-up">Premium Quality Bricks & Building Blocks Engineered for Superior Structural Integrity</p>
    </div>
</section>

<!-- Filter & Search Controls -->
<section class="mb-5">
    <div class="container">
        <div class="glass-card p-4" data-aos="fade-up">
            <form action="${pageContext.request.contextPath}/products" method="get" class="row g-3">
                <div class="col-lg-4 col-md-6">
                    <label class="form-label small font-weight-bold">Search Products</label>
                    <div class="input-group">
                        <span class="input-group-text border-0" style="background: transparent; color: var(--text-secondary);"><i class="fa-solid fa-magnifying-glass"></i></span>
                        <input type="text" name="search" value="${search}" class="form-control" placeholder="e.g. Red, Fly Ash...">
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <label class="form-label small font-weight-bold">Category Filter</label>
                    <select name="filter" class="form-select">
                        <option value="all" ${filter == 'all' ? 'selected' : ''}>All Categories</option>
                        <option value="red" ${filter == 'red' ? 'selected' : ''}>Red Bricks</option>
                        <option value="fly ash" ${filter == 'fly ash' ? 'selected' : ''}>Fly Ash Bricks</option>
                        <option value="hollow" ${filter == 'hollow' ? 'selected' : ''}>Hollow Blocks</option>
                        <option value="concrete" ${filter == 'concrete' ? 'selected' : ''}>Concrete Blocks</option>
                        <option value="paver" ${filter == 'paver' ? 'selected' : ''}>Paver Blocks</option>
                    </select>
                </div>
                <div class="col-lg-3 col-md-6">
                    <label class="form-label small font-weight-bold">Sort By</label>
                    <select name="sort" class="form-select">
                        <option value="name_asc" ${sort == 'name_asc' ? 'selected' : ''}>Product Name (A-Z)</option>
                        <option value="price_asc" ${sort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                        <option value="price_desc" ${sort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary-custom w-100 py-2">Apply Filters</button>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- Product Grid -->
<section class="mb-5">
    <div class="container">
        <div class="row g-4">
            <c:forEach var="p" items="${products}" varStatus="status">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                    <div class="product-card d-flex flex-column h-100">
                        <div class="product-image-wrapper">
                            <!-- Image fallbacks using Unsplash URLs in case local images do not exist -->
                            <img src="${p.imageUrl}" alt="${p.name}" 
                                 onerror="this.onerror=null; 
                                          if('${p.code}' === 'RED001') this.src='https://images.unsplash.com/photo-1590069261209-f8e9b8642343?auto=format&fit=crop&w=600&q=80';
                                          else if('${p.code}' === 'FLY001') this.src='https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=600&q=80';
                                          else if('${p.code}' === 'HOL001') this.src='https://images.unsplash.com/photo-1595841696660-1d85de34fc90?auto=format&fit=crop&w=600&q=80';
                                          else if('${p.code}' === 'CON001') this.src='https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=600&q=80';
                                          else this.src='https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=600&q=80';">
                            <span class="product-badge">Code: ${p.code}</span>
                        </div>
                        
                        <div class="product-info">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h4 class="text-secondary-custom font-weight-bold mb-0">${p.name}</h4>
                                <span class="badge ${p.stockStatus == 'IN_STOCK' ? 'bg-success' : (p.stockStatus == 'LOW_STOCK' ? 'bg-warning text-dark' : 'bg-danger')}">
                                    ${p.stockStatus == 'IN_STOCK' ? 'In Stock' : (p.stockStatus == 'LOW_STOCK' ? 'Low Stock' : 'Out Of Stock')}
                                </span>
                            </div>
                            
                            <p class="text-muted small flex-grow-1">${p.description}</p>
                            
                            <!-- Specifications -->
                            <div class="glass-card p-3 mb-3" style="border-radius: 12px !important; background: rgba(255, 255, 255, 0.3) !important;">
                                <div class="product-meta">
                                    <span><i class="fa-solid fa-ruler-combined me-1"></i> Size:</span>
                                    <strong>${p.dimensions}</strong>
                                </div>
                                <div class="product-meta">
                                    <span><i class="fa-solid fa-weight-hanging me-1"></i> Weight:</span>
                                    <strong>${p.weight}</strong>
                                </div>
                                <div class="product-meta mb-0">
                                    <span><i class="fa-solid fa-shield-halved me-1"></i> Strength:</span>
                                    <strong>${p.strength}</strong>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted small">Wholesale Price:</span>
                                <span class="product-price">INR ${p.price} <small class="text-muted" style="font-size:0.75rem">/ unit</small></span>
                            </div>
                            
                            <!-- CTAs -->
                            <div class="row g-2">
                                <div class="col-6">
                                    <a href="${pageContext.request.contextPath}/order/now?productId=${p.id}" class="btn btn-primary-custom w-100"><i class="fa-solid fa-bag-shopping me-1"></i> Buy</a>
                                </div>
                                <div class="col-6">
                                    <a href="${pageContext.request.contextPath}/quotation/request?productId=${p.id}" class="btn btn-outline-custom w-100"><i class="fa-solid fa-file-invoice-dollar me-1"></i> Quote</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty products}">
                <div class="col-12 text-center py-5">
                    <i class="fa-solid fa-circle-exclamation fa-4x text-muted mb-3"></i>
                    <h4 class="text-secondary-custom font-weight-bold">No products match your search.</h4>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary-custom mt-3">Reset Filters</a>
                </div>
            </c:if>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
