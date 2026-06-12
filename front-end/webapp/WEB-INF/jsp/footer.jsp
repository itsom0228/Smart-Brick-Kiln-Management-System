<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<footer class="bg-secondary-custom text-white pt-5 pb-4 mt-5">
    <div class="container">
        <div class="row">
            <!-- Col 1: About Brand -->
            <div class="col-md-4 mb-4">
                <h5 class="text-accent-custom mb-3 font-weight-bold"><spring:message code="nav.brand"/></h5>
                <p class="text-white-50"><spring:message code="hero.tagline"/></p>
                <p class="text-white-50">Providing high compressive strength building materials with computerized quality assurance direct from our automated kiln systems.</p>
            </div>
            <!-- Col 2: Quick Links -->
            <div class="col-md-4 mb-4">
                <h5 class="text-accent-custom mb-3 font-weight-bold">Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/" class="text-white-50 text-decoration-none hover-accent mb-2 d-inline-block"><i class="fa-solid fa-angle-right me-1"></i> <spring:message code="nav.home"/></a></li>
                    <li><a href="${pageContext.request.contextPath}/about" class="text-white-50 text-decoration-none hover-accent mb-2 d-inline-block"><i class="fa-solid fa-angle-right me-1"></i> <spring:message code="nav.about"/></a></li>
                    <li><a href="${pageContext.request.contextPath}/products" class="text-white-50 text-decoration-none hover-accent mb-2 d-inline-block"><i class="fa-solid fa-angle-right me-1"></i> <spring:message code="nav.products"/></a></li>
                    <li><a href="${pageContext.request.contextPath}/gallery" class="text-white-50 text-decoration-none hover-accent mb-2 d-inline-block"><i class="fa-solid fa-angle-right me-1"></i> <spring:message code="nav.gallery"/></a></li>
                    <li><a href="${pageContext.request.contextPath}/calculator" class="text-white-50 text-decoration-none hover-accent mb-2 d-inline-block"><i class="fa-solid fa-angle-right me-1"></i> <spring:message code="nav.calculator"/></a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/login" class="text-white-50 text-decoration-none hover-accent mb-2 d-inline-block"><i class="fa-solid fa-lock me-1"></i> <spring:message code="nav.admin"/></a></li>
                </ul>
            </div>
            <!-- Col 3: Contacts -->
            <div class="col-md-4 mb-4">
                <h5 class="text-accent-custom mb-3 font-weight-bold"><spring:message code="nav.contact"/></h5>
                <p class="text-white-50"><i class="fa-solid fa-user me-2 text-primary-custom"></i> Owner: Dipak Sarpane</p>
                <p class="text-white-50"><i class="fa-solid fa-phone me-2 text-primary-custom"></i> +91 95884 30156</p>
                <p class="text-white-50"><i class="fa-solid fa-envelope me-2 text-primary-custom"></i> dipaksarpane@gmail.com</p>
                <p class="text-white-50"><i class="fa-solid fa-location-dot me-2 text-primary-custom"></i> Maharashtra, Osmanabad (Dharashiv), Tq: Paranda, Village: Hingangaon Bk, PIN: 413502</p>
            </div>
        </div>
        
        <hr class="bg-white-50 my-4">
        
        <div class="row align-items-center">
            <div class="col-md-7 text-white-50">
                <p class="mb-0">&copy; 2026 Dipak Sarpane Brick Industries. All Rights Reserved. Powered by Smart Brick Kiln Management System.</p>
            </div>
            <div class="col-md-5 text-md-end text-white-50">
                <a href="https://wa.me/919588430156?text=Hello,%20I%20want%20information%20about%20your%20bricks." target="_blank" class="text-white-50 me-3 text-decoration-none"><i class="fa-brands fa-whatsapp fa-lg hover-accent"></i></a>
                <a href="https://www.instagram.com/dipaksarpane?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==" target="_blank" class="text-white-50 text-decoration-none"><i class="fa-brands fa-instagram fa-lg hover-accent"></i></a>
            </div>
        </div>
    </div>
</footer>

<!-- Floating Call and WhatsApp Buttons -->
<div class="floating-widget-container d-print-none">
    <!-- Call Now Button -->
    <a href="tel:+919588430156" class="floating-btn floating-call" title="Call Us Now">
        <i class="fa-solid fa-phone fa-xl"></i>
    </a>
    <!-- WhatsApp Chat Button -->
    <a href="https://wa.me/919588430156?text=Hello,%20I%20want%20information%20about%20your%20bricks." target="_blank" class="floating-btn floating-whatsapp" title="WhatsApp Chat">
        <i class="fa-brands fa-whatsapp fa-2xl"></i>
    </a>
</div>

<!-- Bootstrap 5 JavaScript CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS Animation JS CDN -->
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>

<!-- Bind system global settings to javascript variables -->
<script>
    window.DSBI_GST_RATE = parseFloat('${not empty settings.GST_RATE ? settings.GST_RATE : "12"}') / 100.0;
    window.DSBI_TRANSPORT_RATE_STANDARD = parseFloat('${not empty settings.TRANSPORT_RATE_STANDARD ? settings.TRANSPORT_RATE_STANDARD : "1.50"}');
    window.DSBI_TRANSPORT_RATE_HOLLOW = parseFloat('${not empty settings.TRANSPORT_RATE_HOLLOW ? settings.TRANSPORT_RATE_HOLLOW : "5.00"}');
</script>

<!-- Custom application script -->
<script src="${pageContext.request.contextPath}/js/custom.js"></script>
<script src="${pageContext.request.contextPath}/js/api-forms.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Initialize AOS animations
        if (typeof AOS !== 'undefined') {
            AOS.init({
                duration: 800,
                once: true,
                easing: 'ease-in-out'
            });
        }

        // iOS Theme Toggle Handler
        const themeToggleBtn = document.getElementById('theme-toggle');
        if (themeToggleBtn) {
            const updateIcon = (theme) => {
                const icon = themeToggleBtn.querySelector('i');
                if (icon) {
                    if (theme === 'dark') {
                        icon.className = 'fa-solid fa-sun';
                    } else {
                        icon.className = 'fa-solid fa-moon';
                    }
                }
            };
            const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
            updateIcon(currentTheme);

            themeToggleBtn.addEventListener('click', () => {
                const current = document.documentElement.getAttribute('data-theme') || 'light';
                const targetTheme = current === 'dark' ? 'light' : 'dark';
                document.documentElement.setAttribute('data-theme', targetTheme);
                localStorage.setItem('theme', targetTheme);
                updateIcon(targetTheme);
            });
        }
    });
</script>

</body>
</html>
