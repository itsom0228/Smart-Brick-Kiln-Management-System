<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="header.jsp" />

<!-- Hero Banner (Calculator) -->
<section class="calc-hero-section py-5 bg-dark text-white text-center" style="background: linear-gradient(rgba(33, 37, 41, 0.8), rgba(33, 37, 41, 0.9)), url('${pageContext.request.contextPath}/images/visiting-card.jpg') no-repeat center center; background-size: cover; min-height: 200px; display: flex; align-items: center; justify-content: center;">
    <div class="container" data-aos="fade-up">
        <h1 class="display-4 font-weight-bold text-accent-custom text-uppercase">Instant Cost Calculator</h1>
        <p class="lead">Get immediate cost estimations for your building projects</p>
    </div>
</section>

<!-- Calculator Interface -->
<section class="py-5">
    <div class="container">
        <div class="row g-5 align-items-stretch">
            <!-- Col 1: Calculator Input Form -->
            <div class="col-lg-6" data-aos="fade-right">
                <div class="glass-card p-4 p-md-5 h-100 d-flex flex-column justify-content-between">
                    <div>
                        <h3 class="mb-4 text-primary-custom border-bottom pb-2"><i class="fa-solid fa-calculator me-2"></i>Pricing Estimator</h3>
                        
                        <form id="standalone-calc-form" onsubmit="return false;">
                            <div class="mb-3">
                                <label class="form-label font-weight-bold small">Select Product</label>
                                <select id="std-calc-product" class="form-select py-2" required>
                                    <option value="" disabled selected>-- Choose Brick/Block --</option>
                                    <c:forEach var="p" items="${products}">
                                        <option value="${p.id}" data-price="${p.price}">${p.name} (Rs ${p.price}/unit)</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label font-weight-bold small">Quantity (Units)</label>
                                <input type="number" id="std-calc-quantity" min="100" step="50" placeholder="e.g. 5000" class="form-control py-2" required>
                                <div class="form-text text-muted small">Minimum recommended order: 100 units.</div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label font-weight-bold small">Delivery Destination / Distance</label>
                                <select id="std-calc-delivery" class="form-select py-2" required>
                                    <option value="${settings.TRANSPORT_LOCAL != null ? settings.TRANSPORT_LOCAL : 0}" selected>Local Hingangaon Village (Rs. ${settings.TRANSPORT_LOCAL != null ? settings.TRANSPORT_LOCAL : 0})</option>
                                    <option value="${settings.TRANSPORT_PARANDA != null ? settings.TRANSPORT_PARANDA : 1500}">Paranda Town (Flat Rs ${settings.TRANSPORT_PARANDA != null ? settings.TRANSPORT_PARANDA : 1500})</option>
                                    <option value="${settings.TRANSPORT_DHARASHIV != null ? settings.TRANSPORT_DHARASHIV : 3500}">Dharashiv / Osmanabad District (Flat Rs ${settings.TRANSPORT_DHARASHIV != null ? settings.TRANSPORT_DHARASHIV : 3500})</option>
                                    <option value="${settings.TRANSPORT_LONG != null ? settings.TRANSPORT_LONG : 5000}">Other Districts / Long Distance (Flat Rs ${settings.TRANSPORT_LONG != null ? settings.TRANSPORT_LONG : 5000})</option>
                                </select>
                            </div>
                        </form>
                    </div>

                    <button type="button" id="std-btn-calculate" class="btn btn-primary-custom w-100 py-3 text-uppercase font-weight-bold mt-4"><i class="fa-solid fa-circle-check me-2"></i>Calculate Total Cost</button>
                </div>
            </div>

            <!-- Col 2: Calculation Results Output -->
            <div class="col-lg-6" data-aos="fade-left">
                <div class="glass-card p-4 p-md-5 h-100 d-flex flex-column justify-content-between">
                    <div>
                        <h4 class="text-secondary-custom border-bottom pb-3 mb-4 font-weight-bold">Cost Estimation Summary</h4>
                        
                        <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                            <span class="text-muted"><i class="fa-solid fa-boxes-stacked me-2"></i>Base Brick Cost:</span>
                            <strong class="text-secondary-custom">INR <span id="std-res-base-cost">0.00</span></strong>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                            <span class="text-muted"><i class="fa-solid fa-percent me-2"></i>GST Amount (${not empty settings.GST_RATE ? settings.GST_RATE : 12}%):</span>
                            <strong class="text-secondary-custom">INR <span id="std-res-gst">0.00</span></strong>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-4 border-bottom pb-2">
                            <span class="text-muted"><i class="fa-solid fa-truck me-2"></i>Transport / Freight charges:</span>
                            <strong class="text-secondary-custom">INR <span id="std-res-transport">0.00</span></strong>
                        </div>

                        <div class="glass-card p-4 mb-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <h4 class="text-secondary-custom font-weight-bold mb-0">Total Estimated Cost:</h4>
                                <h3 class="text-primary-custom font-weight-bold mb-0">INR <span id="std-res-total">0.00</span></h3>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <div class="alert alert-warning border-0 small py-2 mb-3 d-flex align-items-center">
                            <i class="fa-solid fa-circle-info me-2 fa-lg text-primary-custom"></i>
                            <span class="text-dark-50">Estimations exclude loading/unloading labor charges at the site.</span>
                        </div>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/order/now" class="btn btn-primary-custom flex-grow-1 py-3 text-uppercase font-weight-bold"><i class="fa-solid fa-cart-shopping me-2"></i>Place Order Now</a>
                            <a href="${pageContext.request.contextPath}/quotation/request" class="btn btn-dark py-3 px-4 text-uppercase font-weight-bold" title="Request Official Quote"><i class="fa-solid fa-file-invoice-dollar"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Cost Estimator JS logic -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    const btnCalc = document.getElementById("std-btn-calculate");
    
    if (btnCalc) {
        btnCalc.addEventListener("click", function() {
            const selectProd = document.getElementById("std-calc-product");
            const inputQty = document.getElementById("std-calc-quantity");
            const selectDel = document.getElementById("std-calc-delivery");

            if (!selectProd.value) {
                alert("Please select a brick or block product.");
                selectProd.focus();
                return;
            }

            const qty = parseInt(inputQty.value);
            if (!qty || qty < 1) {
                alert("Please enter a valid quantity.");
                inputQty.focus();
                return;
            }

            const selectedOption = selectProd.options[selectProd.selectedIndex];
            const price = parseFloat(selectedOption.getAttribute("data-price"));
            const prodName = selectedOption.text.toLowerCase();
            const baseCost = price * qty;
            const gstRatePercent = parseFloat('${not empty settings.GST_RATE ? settings.GST_RATE : 12}');
            const gst = baseCost * (gstRatePercent / 100.0);
            
            // Transport Cost: (transportRate * qty) + flat_zone_surcharge
            let transportRate = parseFloat('${not empty settings.TRANSPORT_RATE_STANDARD ? settings.TRANSPORT_RATE_STANDARD : "1.50"}');
            if (prodName.includes('hollow')) {
                transportRate = parseFloat('${not empty settings.TRANSPORT_RATE_HOLLOW ? settings.TRANSPORT_RATE_HOLLOW : "5.00"}');
            }
            const zoneSurcharge = parseFloat(selectDel.value);
            const transport = (transportRate * qty) + zoneSurcharge;
            
            const total = baseCost + gst + transport;

            // Update UI elements
            document.getElementById("std-res-base-cost").innerText = baseCost.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            document.getElementById("std-res-gst").innerText = gst.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            document.getElementById("std-res-transport").innerText = transport.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            document.getElementById("std-res-total").innerText = total.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        });
    }
});
</script>

<jsp:include page="footer.jsp" />
