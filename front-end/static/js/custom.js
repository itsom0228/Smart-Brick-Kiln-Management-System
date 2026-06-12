// Custom JavaScript for Dipak Sarpane Brick Industries
// Enhanced with premium micro-interactions, liquid-glass effects, and iOS-style responsiveness.

document.addEventListener('DOMContentLoaded', function() {
    
    // ==========================================
    // 1. Injected Liquid Gradient Background Blobs
    // ==========================================
    const injectBackgroundBlobs = () => {
        if (document.querySelector('.liquid-bg-container')) return; // Already exists
        
        const container = document.createElement('div');
        container.className = 'liquid-bg-container';
        
        const blob1 = document.createElement('div');
        blob1.className = 'liquid-blob blob-1';
        
        const blob2 = document.createElement('div');
        blob2.className = 'liquid-blob blob-2';
        
        const blob3 = document.createElement('div');
        blob3.className = 'liquid-blob blob-3';
        
        container.appendChild(blob1);
        container.appendChild(blob2);
        container.appendChild(blob3);
        
        document.body.appendChild(container);
    };
    injectBackgroundBlobs();

    // ==========================================
    // 2. Click Ripple Effect for Buttons
    // ==========================================
    const addRippleEffect = (e) => {
        const btn = e.currentTarget;
        const circle = document.createElement('span');
        const diameter = Math.max(btn.clientWidth, btn.clientHeight);
        const radius = diameter / 2;
        
        // Find click position relative to button
        const rect = btn.getBoundingClientRect();
        const x = e.clientX - rect.left - radius;
        const y = e.clientY - rect.top - radius;
        
        circle.style.width = circle.style.height = `${diameter}px`;
        circle.style.left = `${x}px`;
        circle.style.top = `${y}px`;
        circle.classList.add('ripple');
        
        // Remove existing ripples if any
        const ripple = btn.querySelector('.ripple');
        if (ripple) {
            ripple.remove();
        }
        
        btn.appendChild(circle);
    };

    const buttons = document.querySelectorAll('.btn-primary-custom, .btn-primary, .btn-outline-custom, .btn-outline-light, .theme-toggle-btn');
    buttons.forEach(button => {
        button.addEventListener('click', addRippleEffect);
    });

    // ==========================================
    // 3. Card Hover-Tilt Parallax Effect (Desktop)
    // ==========================================
    const cards = document.querySelectorAll('.glass-card, .stats-card, .product-card, .card-custom');
    if (window.innerWidth > 991) {
        cards.forEach(card => {
            card.addEventListener('mousemove', (e) => {
                const rect = card.getBoundingClientRect();
                const x = e.clientX - rect.left; // x position inside element
                const y = e.clientY - rect.top;  // y position inside element
                
                // Calculate rotation based on cursor position relative to center
                const centerX = rect.width / 2;
                const centerY = rect.height / 2;
                const rotateX = -(y - centerY) / (rect.height / 10); // Max 10 deg
                const rotateY = (x - centerX) / (rect.width / 10);
                
                // Update transformation
                card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-6px)`;
                
                // Dynamic border glow highlight direction tracking
                const percentX = (x / rect.width) * 100;
                const percentY = (y / rect.height) * 100;
                card.style.setProperty('--glow-x', `${percentX}%`);
                card.style.setProperty('--glow-y', `${percentY}%`);
            });
            
            card.addEventListener('mouseleave', () => {
                // Reset styling smoothly
                card.style.transform = '';
                card.style.setProperty('--glow-x', '50%');
                card.style.setProperty('--glow-y', '50%');
            });
        });
    }

    // ==========================================
    // 4. Live Calculator Logic
    // ==========================================
    const calcProductSelect = document.getElementById('calc-product');
    const calcQuantityInput = document.getElementById('calc-quantity');
    const btnCalculate = document.getElementById('btn-calculate');

    if (calcProductSelect && calcQuantityInput) {
        function calculateEstimates() {
            const selectedOption = calcProductSelect.options[calcProductSelect.selectedIndex];
            if (!selectedOption || !selectedOption.value) return;

            const unitPrice = parseFloat(selectedOption.getAttribute('data-price') || 0);
            const prodName = selectedOption.text.toLowerCase();
            const quantity = parseInt(calcQuantityInput.value || 0);

            if (quantity <= 0) {
                document.getElementById('calc-res-product-cost').innerText = '0.00';
                document.getElementById('calc-res-gst').innerText = '0.00';
                document.getElementById('calc-res-transport').innerText = '0.00';
                document.getElementById('calc-res-total').innerText = '0.00';
                return;
            }

            // Calculations
            const productCost = unitPrice * quantity;
            const gstRate = (window.DSBI_GST_RATE !== undefined && window.DSBI_GST_RATE !== null) ? window.DSBI_GST_RATE : 0.12;
            const gstAmount = productCost * gstRate;
            
            // Transport Cost rules from global configurations
            let transportRate = (window.DSBI_TRANSPORT_RATE_STANDARD !== undefined && window.DSBI_TRANSPORT_RATE_STANDARD !== null) ? window.DSBI_TRANSPORT_RATE_STANDARD : 1.50;
            if (prodName.includes('hollow')) {
                transportRate = (window.DSBI_TRANSPORT_RATE_HOLLOW !== undefined && window.DSBI_TRANSPORT_RATE_HOLLOW !== null) ? window.DSBI_TRANSPORT_RATE_HOLLOW : 5.00;
            }
            const transportCost = transportRate * quantity;
            const grandTotal = productCost + gstAmount + transportCost;

            // Update DOM with smooth count-up simulation or direct formatting
            document.getElementById('calc-res-product-cost').innerText = productCost.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            document.getElementById('calc-res-gst').innerText = gstAmount.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            document.getElementById('calc-res-transport').innerText = transportCost.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            document.getElementById('calc-res-total').innerText = grandTotal.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        if (btnCalculate) {
            btnCalculate.addEventListener('click', function(e) {
                e.preventDefault();
                calculateEstimates();
            });
        }
        
        calcProductSelect.addEventListener('change', calculateEstimates);
        calcQuantityInput.addEventListener('input', calculateEstimates);
    }

    // ==========================================
    // 5. Lightbox Gallery Logic
    // ==========================================
    const galleryItems = document.querySelectorAll('.gallery-item');
    const lightboxModal = document.getElementById('lightbox-modal');
    const lightboxImg = document.getElementById('lightbox-img');

    if (galleryItems && lightboxModal && lightboxImg) {
        galleryItems.forEach(item => {
            item.addEventListener('click', function() {
                const imgUrl = this.getAttribute('data-img-url');
                lightboxImg.src = imgUrl;
                lightboxModal.style.display = 'flex';
                lightboxModal.style.opacity = '0';
                setTimeout(() => {
                    lightboxModal.style.transition = 'opacity 0.4s ease';
                    lightboxModal.style.opacity = '1';
                }, 10);
            });
        });

        // Close lightbox on click
        lightboxModal.addEventListener('click', function() {
            lightboxModal.style.opacity = '0';
            setTimeout(() => {
                lightboxModal.style.display = 'none';
                lightboxImg.src = '';
            }, 400);
        });
    }

    // ==========================================
    // 6. Category Filter for Gallery page
    // ==========================================
    const filterButtons = document.querySelectorAll('.filter-btn');
    const items = document.querySelectorAll('.gallery-card-wrapper');

    if (filterButtons && items.length > 0) {
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all
                filterButtons.forEach(btn => {
                    btn.classList.remove('active', 'btn-primary-custom');
                    btn.classList.add('btn-outline-custom');
                });
                
                this.classList.add('active', 'btn-primary-custom');
                this.classList.remove('btn-outline-custom');

                const filterValue = this.getAttribute('data-filter');

                items.forEach(item => {
                    if (filterValue === 'all' || item.getAttribute('data-category') === filterValue) {
                        item.style.display = 'block';
                        item.style.opacity = '0';
                        setTimeout(() => {
                            item.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                            item.style.opacity = '1';
                        }, 50);
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });
    }

    // ==========================================
    // 7. Alert auto-fade out
    // ==========================================
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            setTimeout(() => alert.remove(), 600);
        }, 4000);
    });

    // ==========================================
    // 8. Admin Sidebar Toggle Logic (Mobile)
    // ==========================================
    const adminWrapper = document.querySelector('.admin-wrapper');
    if (adminWrapper) {
        const sidebar = document.querySelector('.admin-sidebar');
        
        // 1. Create and inject overlay backdrop
        const overlay = document.createElement('div');
        overlay.className = 'sidebar-overlay';
        document.body.appendChild(overlay);
        
        // 2. Create and inject mobile top navigation bar
        const mobileHeader = document.createElement('div');
        mobileHeader.className = 'admin-mobile-header justify-content-between align-items-center px-4 py-2';
        
        // Hamburger toggle button
        const toggleBtn = document.createElement('button');
        toggleBtn.className = 'btn btn-outline-custom p-2 border-0';
        toggleBtn.innerHTML = '<i class="fa-solid fa-bars fa-lg"></i>';
        toggleBtn.setAttribute('aria-label', 'Toggle Menu');
        
        // Mobile Brand title
        const brand = document.createElement('div');
        brand.className = 'admin-mobile-brand';
        brand.innerHTML = '<i class="fa-solid fa-fire-burner me-2 text-primary-custom"></i>KILN CONSOLE';
        
        // Right side placeholder to keep it balanced
        const rightPlaceholder = document.createElement('div');
        rightPlaceholder.style.width = '35px'; // Matches toggle button width roughly
        
        mobileHeader.appendChild(toggleBtn);
        mobileHeader.appendChild(brand);
        mobileHeader.appendChild(rightPlaceholder);
        
        // Insert mobile header at the top of admin wrapper
        adminWrapper.insertBefore(mobileHeader, adminWrapper.firstChild);
        
        // Helper function to toggle classes
        const toggleSidebar = () => {
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
            
            // Toggle hamburger icon to X and back
            const icon = toggleBtn.querySelector('i');
            if (sidebar.classList.contains('active')) {
                icon.className = 'fa-solid fa-xmark fa-lg';
            } else {
                icon.className = 'fa-solid fa-bars fa-lg';
            }
        };
        
        // Click handlers
        toggleBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            toggleSidebar();
        });
        
        overlay.addEventListener('click', () => {
            if (sidebar.classList.contains('active')) {
                toggleSidebar();
            }
        });
        
        // Add click listeners to sidebar links to close sidebar on link click (useful on mobile)
        const sidebarLinks = sidebar.querySelectorAll('.list-group-item');
        sidebarLinks.forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth <= 991 && sidebar.classList.contains('active')) {
                    toggleSidebar();
                }
            });
        });
    }
});
