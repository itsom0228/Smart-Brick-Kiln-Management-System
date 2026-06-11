// Custom JavaScript for Dipak Sarpane Brick Industries

document.addEventListener('DOMContentLoaded', function() {
    
    // 1. Live Calculator Logic
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

            // Update DOM
            document.getElementById('calc-res-product-cost').innerText = productCost.toFixed(2);
            document.getElementById('calc-res-gst').innerText = gstAmount.toFixed(2);
            document.getElementById('calc-res-transport').innerText = transportCost.toFixed(2);
            document.getElementById('calc-res-total').innerText = grandTotal.toFixed(2);
        }

        // Trigger on click or input changes
        if (btnCalculate) {
            btnCalculate.addEventListener('click', function(e) {
                e.preventDefault();
                calculateEstimates();
            });
        }
        
        calcProductSelect.addEventListener('change', calculateEstimates);
        calcQuantityInput.addEventListener('input', calculateEstimates);
    }

    // 2. Lightbox Gallery Logic
    const galleryItems = document.querySelectorAll('.gallery-item');
    const lightboxModal = document.getElementById('lightbox-modal');
    const lightboxImg = document.getElementById('lightbox-img');

    if (galleryItems && lightboxModal && lightboxImg) {
        galleryItems.forEach(item => {
            item.addEventListener('click', function() {
                const imgUrl = this.getAttribute('data-img-url');
                lightboxImg.src = imgUrl;
                lightboxModal.style.display = 'flex';
            });
        });

        // Close lightbox on click
        lightboxModal.addEventListener('click', function() {
            lightboxModal.style.display = 'none';
            lightboxImg.src = '';
        });
    }

    // 3. Category Filter for Gallery page
    const filterButtons = document.querySelectorAll('.filter-btn');
    const items = document.querySelectorAll('.gallery-card-wrapper');

    if (filterButtons && items.length > 0) {
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all
                filterButtons.forEach(btn => btn.classList.remove('active', 'btn-primary-custom'));
                filterButtons.forEach(btn => btn.classList.add('btn-outline-secondary'));
                
                this.classList.add('active', 'btn-primary-custom');
                this.classList.remove('btn-outline-secondary');

                const filterValue = this.getAttribute('data-filter');

                items.forEach(item => {
                    if (filterValue === 'all' || item.getAttribute('data-category') === filterValue) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });
    }

    // 4. Alert auto-fade out
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 4000);
    });
});
