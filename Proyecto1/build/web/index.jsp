<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, Modelo.Producto" %>
<%   List<Producto> productos = (List<Producto>) request.getAttribute("productos");
%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>

<%
    // Usuario user = (Usuario) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>CompiRest</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="CSS/header.css" />
        <link rel="stylesheet" href="CSS/footer.css" />
        <link rel="stylesheet" href="CSS/main.css" />
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

      
       
    </head>

    <body>

        <%@ include file="JSP/header.jsp" %>

        <!-- Hero Section -->
        <section class="main-hero">
            <div class="carousel-container">
                <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">
                    <div class="carousel-inner">
                        <% int contador = 0; %>
                        <% for (Producto p : productos) {%>
                        <div class="carousel-item <%= contador == 0 ? "active" : ""%>">
                            <div class="carousel-content">
                                <img src="${pageContext.request.contextPath}/Images/products/<%= p.getImgProducto()%>" 
                                     class="d-block w-100" 
                                     alt="<%= p.getNombreProducto()%>" />
                                <div class="carousel-caption d-none d-md-block">
                                    <h3><%= p.getNombreProducto()%></h3>
                                </div>
                            </div>
                        </div>
                        <% contador++; %>
                        <% } %>
                    </div>

                    <!-- Controles del carrusel -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Anterior</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Siguiente</span>
                    </button>
                </div>
            </div>
        </section>
                    
        <section>
            <div class="container">
                <div class="section-header text-center mb-5">
                    <span class="line"></span>
                    <h2>Marcas</h2>
                    <span class="line"></span>
                </div>
                <div class = "row">
                    <c:forEach var="marca" items="${marcas}">
                        <div class="col-md-2 text-center">
                            <a href="${pageContext.request.contextPath}/ControladorProducto?marca=${marca.id_marca}" class="btn-marca-icono">
                                <img src="${pageContext.request.contextPath}/Images/Restaurantes/${marca.img_marca}"
                                     alt="${marca.nombre_marca}" class="logo-restaurante" width="50"/>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- Recomendaciones -->
        <section class="featured-dishes">
            <div class="container">
                <div class="section-header text-center mb-5">
                    <span class="line"></span>
                    <h2>Recomendaciones</h2>
                    <span class="line"></span>
                </div>
                <div class="row g-4">
                    <%
                        // Productos aleatorios
                        List<Producto> productosAleatorios = new ArrayList<>(productos);
                        Collections.shuffle(productosAleatorios);
                        productosAleatorios = productosAleatorios.subList(0, Math.min(9, productosAleatorios.size()));

                        for (Producto p : productosAleatorios) {
                    %>
                    <div class="col-md-4 col-lg-4 mb-4">
                        <div class="product-card h-100">
                            <div class="product-image">
                                <img src="${pageContext.request.contextPath}/Images/products/<%= p.getImgProducto()%>" 
                                     class="img-fluid" 
                                     alt="<%= p.getNombreProducto()%>" />
                            </div>
                            <div class="product-info p-3">
                                <h3 class="product-title mb-2"><%= p.getNombreProducto()%></h3>
                                <p class="product-description mb-3"><%= p.getDescripcionProducto()%></p>
                                <div class="product-footer d-flex justify-content-between align-items-center">
                                    <span class="price text-danger">S/ <%= p.getPrecioProducto()%></span>
                                     <button class="btn btn-danger btn-sm ordenar-btn" 
                                            data-id="<%= p.getIdProducto()%>">
                                        Ordenar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>

        <!-- Sobre Nosotros -->
        <section class="about-section py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="about-content text-center text-md-start">
                            <h2 class="section-title mb-3">
                                <span class="text-danger">20</span> Años de Tradición
                            </h2>
                            <p class="lead">
                                Desde el 2003, entregando auténticos sabores peruanos con ingredientes
                                frescos y recetas tradicionales.
                            </p>
                            <a href="JSP/aboutus.jsp" class="btn btn-danger btn-lg px-4">
                                Conoce nuestra historia <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="about-image text-center">
                            <img src="${pageContext.request.contextPath}/Images/Varieties/about-us.jpg" 
                                 class="img-fluid rounded-3 shadow-lg" 
                                 alt="Interior del Restaurante" />
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        
        <%@ include file="JSP/footer.jsp" %>
        
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const buttons = document.querySelectorAll('.ordenar-btn');
               
                buttons.forEach(btn => {
                    btn.addEventListener('click', function () {
                        
                        const id_ = this.getAttribute('data-id');
                        const accion = 'agregar';    
                        $.post('CarritoController?accion=agregar', {
                                id: id_
			}, function(responseText) { 
                            var nuevaCantidad = responseText;
                            alert("Producto Agregado");
                           
				//$('#tabla').html(responseText);
                            
                             const cartCount = document.getElementById("cart-count");
                            if (cartCount) {
                                cartCount.textContent = nuevaCantidad;

                                // Si estaba oculto, mostrarlo
                                if (cartCount.classList.contains("d-none")) {
                                    cartCount.classList.remove("d-none");
                                }
                            }
			});
                        
                    });
                });
            });
        </script>
    </body>

</html>