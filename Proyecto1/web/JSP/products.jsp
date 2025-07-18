<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Productos por Marca</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productsMarcasCategorias.css" />
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    </head>

    <body>
        <!-- Header -->
        <%@ include file="header.jsp" %>
        <div class="container">
            <div class="row">
                 <c:forEach var="marca" items="${categorias}">
                
           
                <div class ="col-md-2">
                    <a href="${pageContext.request.contextPath}/ControladorProducto?categoria=${categoria.id_categoria}" class="btn-marca-icono">
                     ${categoria.nombre_categoria}
                    </a>
                </div> 
                 </c:forEach>
            </div>
        </div>
        <div class="barra-restaurantes">
            <c:forEach var="marca" items="${marcas}">
                <a href="${pageContext.request.contextPath}/ControladorProducto?marca=${marca.id_marca}" class="btn-marca-icono">
                    <img src="${pageContext.request.contextPath}/Images/Restaurantes/${marca.img_marca}"
                         alt="${marca.nombre_marca}" class="logo-restaurante" />
                </a>
            </c:forEach>
        </div>

        <section class="marcas-section">
            <c:if test="${marcaSeleccionada == null}">
                <div class="seleccionar-marca">
                    <div class="flecha-arriba">↑ ↑ ↑ ↑</div>
                    <div class="mensaje-seleccion">
                        <h2>Seleccione el Ícono de la Marca de su Preferencia</h2>
                    </div>
                </div>
            </c:if>
            <c:forEach var="marca" items="${marcas}">
                <c:if test="${marca.id_marca == marcaSeleccionada}">
                    <div class="marca-container">
                        <div class="marca-header" id="marca-${marca.id_marca}">
                            <img src="${pageContext.request.contextPath}/Images/Restaurantes/${marca.img_marca}"
                                 alt="${marca.nombre_marca}" class="logo-restaurante" />
                            <h1 class="marca-nombre">${marca.nombre_marca}</h1>
                        </div>
                        <div class="categorias-section">
                            <c:forEach var="categoria" items="${categorias}" varStatus="status">
                                <div class="menu-category">
                                    <h2 class="category-title">${categoria.nombre_categoria}</h2>
                                    <div class="promo-container">
                                        <c:forEach var="producto" items="${listaDeListas[status.index]}">
                                            <c:if test="${producto.idMarca == marca.id_marca}">
                                                <div class="promo-item">
                                                    <img src="${pageContext.request.contextPath}/Images/products/${producto.imgProducto}"
                                                         alt="${producto.nombreProducto}" />
                                                    <div class="promo-info">
                                                        <h3>${producto.nombreProducto}</h3>
                                                        <p>${producto.descripcionProducto}</p>
                                                        <div class="promo-footer">
                                                            <span class="price">S/ ${producto.precioProducto}</span>
                                                             <button class="btn btn-primary btn-sm ordenar-btn" 
                                                                    data-id="${producto.idProducto}">
                                                                Ordenar
                                                            </button>
                                                           
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </section>

        <section class="page-header">
            <div class="container">
                <a href="${pageContext.request.contextPath}/controladorPrincipal" class="back-btn">← Volver</a>
                <div class="title-line">
                    <span class="line"></span>
                    <h1 class="page-title">Retroceder a la Pantalla Princial</h1>
                    <span class="line"></span>
                </div>
            </div>
        </section>

        <%@ include file="footer.jsp" %>
           <script>
            document.addEventListener('DOMContentLoaded', function () {
    const buttons = document.querySelectorAll('.ordenar-btn');

    buttons.forEach(btn => {
        btn.addEventListener('click', function () {

            const id_ = this.getAttribute('data-id');

            $.ajax({
                url: '/Proyecto1/api/generic/agregar',
                type: 'POST',
                data: JSON.stringify({ id: id_ }), // Enviar JSON
                contentType: 'application/json',    // Indicar JSON
                success: function (responseText) {
                    var nuevaCantidad = responseText;
                    alert("Producto Agregado");

                    const cartCount = document.getElementById("cart-count");
                    if (cartCount) {
                        cartCount.textContent = nuevaCantidad;

                        if (cartCount.classList.contains("d-none")) {
                            cartCount.classList.remove("d-none");
                        }
                    }
                },
                error: function () {
                    alert("Error al agregar producto");
                }
            });
        });
    });
});
        </script>
    </body>

</html>