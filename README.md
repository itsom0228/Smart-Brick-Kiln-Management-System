# Smart Brick Kiln Management System

## DIPAK SARPANE BRICK INDUSTRIES
**Founder & Managing Director:** Dipak Sarpane  
**Website Style:** Modern, Industrial, Premium

---

## Technical Stack & Architecture

### Backend:
* **Java 21**
* **Spring Boot 3.2.5** (Spring MVC, Security, Data JPA, Hibernate, Validation)
* **OpenPDF** (for PDF invoice and quotation generations)
* **Apache POI** (for Excel reports)
* **Maven**

### Frontend:
* **JSP (JavaServer Pages)** served from `/WEB-INF/jsp/` using standard view mapping.
* **i18n (Internationalization)**: Supports English (`en`), Hindi (`hi`), and Marathi (`mr`) language toggles via cookie mapping and parameter interceptors.
* **Bootstrap 5**, FontAwesome Icons, AOS Animations, Chart.js.

### Database:
* **MySQL 8** (Auto-creates the schema `dipak_sarpane_kiln`).

---

## Folder Structure

```text
vit bhatti/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── dipaksarpane/
        │           └── kiln/
        │               ├── KilnApplication.java
        │               ├── config/
        │               │   ├── SecurityConfig.java
        │               │   └── WebConfig.java
        │               ├── entity/
        │               │   ├── Admin.java
        │               │   ├── Product.java
        │               │   ├── Order.java
        │               │   ├── Quotation.java
        │               │   ├── Review.java
        │               │   ├── ContactMessage.java
        │               │   ├── InventoryTransaction.java
        │               │   └── Invoice.java
        │               ├── repository/
        │               │   ├── AdminRepository.java
        │               │   ├── ProductRepository.java
        │               │   ├── OrderRepository.java
        │               │   ├── QuotationRepository.java
        │               │   ├── ReviewRepository.java
        │               │   ├── ContactMessageRepository.java
        │               │   ├── InventoryTransactionRepository.java
        │               │   └── InvoiceRepository.java
        │               └── service/
        │                   ├── CustomUserDetailsService.java
        │                   ├── ProductService.java
        │                   ├── InventoryService.java
        │                   ├── OrderService.java
        │                   ├── QuotationService.java
        │                   ├── InvoiceService.java
        │                   ├── ReportService.java
        │                   └── DatabaseSeeder.java
        ├── resources/
        │   ├── application.properties
        │   ├── i18n/
        │   │   ├── messages.properties (English Default)
        │   │   ├── messages_mr.properties (Marathi)
        │   │   └── messages_hi.properties (Hindi)
        │   └── static/
        │       ├── css/
        │       │   └── custom.css
        │       ├── js/
        │       │   └── custom.js
        │       ├── robots.txt
        │       └── sitemap.xml
        └── webapp/
            └── WEB-INF/
                └── jsp/
                    ├── header.jsp
                    ├── footer.jsp
                    ├── index.jsp
                    ├── products.jsp
                    ├── gallery.jsp
                    ├── order-now.jsp
                    ├── order-success.jsp
                    ├── track.jsp
                    ├── quotation.jsp
                    ├── quotation-success.jsp
                    ├── contact.jsp
                    └── admin/
                        ├── login.jsp
                        ├── dashboard.jsp
                        ├── products.jsp
                        ├── product-form.jsp
                        ├── orders.jsp
                        ├── order-detail.jsp
                        ├── quotations.jsp
                        ├── inventory.jsp
                        ├── reviews.jsp
                        ├── enquiries.jsp
                        └── reports.jsp
```

---

## Setup & Running Guide

### 1. Database Setup
Ensure you have MySQL 8 running on port `3306`.
Create a database schema manually or let Spring Boot automatically create it:
```sql
CREATE DATABASE IF NOT EXISTS dipak_sarpane_kiln;
```
The database connection credentials configured in `src/main/resources/application.properties` are:
* **Username:** `root`
* **Password:** `Python@123`

### 2. Build the Project
In the root directory, compile and package the WAR file:
```bash
mvn clean package
```
This generates the packaged war file: `target/kiln-1.0.0.war`.

### 3. Run the Application
Start the embedded Tomcat application:
```bash
java -jar target/kiln-1.0.0.war
```
Alternatively, deploy the generated `.war` file directly into an external Tomcat 10+ servlet container.

### 4. Admin Credentials
The system programmatically seeds the database with the administrator details on first boot:
* **Username:** `admin`
* **Password:** `Admin@123`

---

## URL Map

* **Public Homepage:** `http://localhost:8080/`
* **Price Calculator:** `http://localhost:8080/calculator`
* **Products Catalog:** `http://localhost:8080/products`
* **Photo Gallery:** `http://localhost:8080/gallery`
* **Order Placement:** `http://localhost:8080/order/now`
* **Order Tracking:** `http://localhost:8080/order/track`
* **Admin Login Panel:** `http://localhost:8080/admin/login`
* **Admin Console:** `http://localhost:8080/admin/dashboard`
