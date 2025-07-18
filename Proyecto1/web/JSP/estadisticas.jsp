<%--
    Document     : estadisticas
    Created on : 3 jul. 2025
    Author       : Huguiño
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Administración - Dashboard de Estadísticas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/estilo_estadisticas.css" />
    
</head>
<body>
    <%-- Incluir el header --%>
    <jsp:include page="headeradmin.jsp"/>

    <div class="main-container">
        <div class="sidebar">
            <h3>Panel de Administración</h3>
            <ul class="nav-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/ControladorEstadisticas" class="active">
                        <i class="fas fa-chart-bar"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/ControladorProductoAdm">
                        <i class="fas fa-box"></i> Productos
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/ControladorMarca">
                        <i class="fas fa-tags"></i> Marcas
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/ControladorPedido">
                        <i class="fas fa-shopping-cart"></i> Pedidos
                    </a>
                </li>
                
            </ul>
        </div>

        <div class="main-content">
            <div class="py-4">
                <%-- Mensajes de éxito y error --%>
                <% if (request.getSession().getAttribute("mensajeExito") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.mensajeExito}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    <% request.getSession().removeAttribute("mensajeExito"); %>
                </div>
                <% } %>
                <% if (request.getSession().getAttribute("mensajeError") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.mensajeError}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    <% request.getSession().removeAttribute("mensajeError"); %>
                </div>
                <% } %>

                <div class="contenedor-principal-estadisticas">
                    <h1 class="titulo-principal-estadisticas">Dashboard</h1>

                    <div class="seccion-estadistica" id="indiceEstadisticas">
                        <h2 class="subtitulo-seccion">Índice de Estadísticas</h2>
                        <ul class="lista-detalles">
                            <li><a href="#totalPedidosSection">Total de Pedidos Realizados</a></li>
                            <li><a href="#productosMasCompradosSection">Productos Más Comprados</a></li>
                            <li><a href="#metodosPagoPreferidosSection">Métodos de Pago Preferidos</a></li>
                            <li><a href="#productosMenosCompradosSection">Productos Menos Comprados</a></li>
                            <li><a href="#ventasPorProductoSection">Detalle de Ventas por Producto</a></li>
                            <li><a href="#ingresosTotalesSection">Ingresos Totales Generados</a></li>
                        </ul>
                    </div>

                    <div class="resumen-total" id="totalPedidosSection">
                        <h3>Total de Pedidos Realizados: ${totalPedidos}</h3>
                    </div>

                    <div class="seccion-estadistica" id="productosMasCompradosSection">
                        <h2 class="subtitulo-seccion">Productos Más Comprados</h2>
                        <p class="parrafo-descripcion">Estos son los productos que más éxito han tenido en ventas:</p>
                        <div class="contenedor-grafico">
                            <canvas id="productosMasCompradosChart"></canvas>
                        </div>
                        <div id="productosMasCompradosListContainer">
                            <ul class="lista-detalles">
                                <c:forEach var="producto" items="${productosMasComprados}" varStatus="loop">
                                    <li class="${loop.index >= 10 ? 'hidden-list-item' : ''}">${producto}</li>
                                </c:forEach>
                            </ul>
                            <c:if test="${fn:length(productosMasComprados) > 10}">
                                <button class="show-more-btn" data-target="productosMasCompradosListContainer">Ver más</button>
                            </c:if>
                        </div>
                    </div>

                    <div class="seccion-estadistica" id="metodosPagoPreferidosSection">
                        <h2 class="subtitulo-seccion">Métodos de Pago Preferidos</h2>
                        <p class="parrafo-descripcion">Distribución de los métodos de pago utilizados por los clientes:</p>
                        <div class="contenedor-grafico">
                            <canvas id="metodosPagoChart"></canvas>
                        </div>
                        <ul class="lista-detalles">
                            <c:forEach var="metodo" items="${metodosPagoPreferidos}">
                                <li>${metodo}</li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="seccion-estadistica" id="productosMenosCompradosSection">
                        <h2 class="subtitulo-seccion">Productos Menos Comprados</h2>
                        <p class="parrafo-descripcion">Estos productos podrían necesitar un impulso o revisión:</p>
                        <div id="productosMenosCompradosListContainer"> <%-- Added container for "Productos Menos Comprados" --%>
                            <ul class="lista-detalles">
                                <c:forEach var="producto" items="${productosMenosComprados}" varStatus="loop">
                                    <li class="${loop.index >= 10 ? 'hidden-list-item' : ''}">${producto}</li>
                                </c:forEach>
                            </ul>
                            <c:if test="${fn:length(productosMenosComprados) > 10}">
                                <button class="show-more-btn" data-target="productosMenosCompradosListContainer">Ver más</button>
                            </c:if>
                        </div>
                    </div>

                    <div class="seccion-estadistica" id="ventasPorProductoSection">
                        <h2 class="subtitulo-seccion">Detalle de Ventas por Producto</h2>
                        <p class="parrafo-descripcion">Cantidad de unidades vendidas y el ingreso generado por cada producto:</p>
                        <div id="ventasPorProductoListContainer">
                            <ul class="lista-detalles">
                                <c:forEach var="detalle" items="${ventasPorProducto}" varStatus="loop">
                                    <li class="${loop.index >= 10 ? 'hidden-list-item' : ''}">${detalle}</li>
                                </c:forEach>
                            </ul>
                            <c:if test="${fn:length(ventasPorProducto) > 10}">
                                <button class="show-more-btn" data-target="ventasPorProductoListContainer">Ver más</button>
                            </c:if>
                        </div>
                    </div>

                    <div class="resumen-total" id="ingresosTotalesSection">
                        <h3>Ingresos Totales Generados: S/ ${ingresosTotales}</h3>
                    </div>

                    <div class="text-center mt-8">
                        <a href="${pageContext.request.contextPath}/controladorPrincipal" class="back-btn">← Volver a la Pantalla Principal</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Incluir el footer --%>
    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Data para "Productos Más Comprados" chart
            const productosMasCompradosLabels = [
                <c:forEach var="label" items="${productosMasCompradosLabels}" varStatus="loop">
                    "${label}"<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            const productosMasCompradosData = [
                <c:forEach var="data" items="${productosMasCompradosData}" varStatus="loop">
                    ${data}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];

            const ctxProductos = document.getElementById('productosMasCompradosChart').getContext('2d');
            new Chart(ctxProductos, {
                type: 'bar',
                data: {
                    labels: productosMasCompradosLabels,
                    datasets: [{
                        label: 'Unidades Vendidas',
                        data: productosMasCompradosData,
                        backgroundColor: [
                            'rgba(79, 70, 229, 0.7)', // Indigo 600
                            'rgba(139, 92, 246, 0.7)', // Violet 500
                            'rgba(234, 88, 12, 0.7)',  // Orange 600
                            'rgba(6, 182, 212, 0.7)',  // Cyan 600
                            'rgba(220, 38, 38, 0.7)',  // Red 600
                            'rgba(234, 179, 8, 0.7)',  // Yellow 600
                            'rgba(16, 185, 129, 0.7)', // Emerald 600
                            'rgba(124, 58, 237, 0.7)', // Purple 600
                            'rgba(217, 119, 6, 0.7)',  // Amber 600
                            'rgba(2, 132, 199, 0.7)'   // Light Blue 600
                        ],
                        borderColor: [
                            'rgba(79, 70, 229, 1)',
                            'rgba(139, 92, 246, 1)',
                            'rgba(234, 88, 12, 1)',
                            'rgba(6, 182, 212, 1)',
                            'rgba(220, 38, 38, 1)',
                            'rgba(234, 179, 8, 1)',
                            'rgba(16, 185, 129, 1)',
                            'rgba(124, 58, 237, 1)',
                            'rgba(217, 119, 6, 1)',
                            'rgba(2, 132, 199, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        },
                        title: {
                            display: true,
                            text: 'Top Productos Más Vendidos'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Unidades Vendidas'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Producto'
                            }
                        }
                    }
                }
            });

            // Data para "Métodos de Pago Preferidos" chart
            const metodosPagoLabels = [
                <c:forEach var="label" items="${metodosPagoPreferidosLabels}" varStatus="loop">
                    "${label}"<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            const metodosPagoData = [
                <c:forEach var="data" items="${metodosPagoPreferidosData}" varStatus="loop">
                    ${data}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];

            const ctxMetodosPago = document.getElementById('metodosPagoChart').getContext('2d');
            new Chart(ctxMetodosPago, {
                type: 'pie',
                data: {
                    labels: metodosPagoLabels,
                    datasets: [{
                        label: 'Número de Pedidos',
                        data: metodosPagoData,
                        backgroundColor: [
                            'rgba(79, 70, 229, 0.7)',
                            'rgba(234, 88, 12, 0.7)',
                            'rgba(6, 182, 212, 0.7)',
                            'rgba(220, 38, 38, 0.7)',
                            'rgba(139, 92, 246, 0.7)',
                            'rgba(234, 179, 8, 0.7)'
                        ],
                        borderColor: [
                            'rgba(79, 70, 229, 1)',
                            'rgba(139, 92, 246, 1)',
                            'rgba(234, 88, 12, 1)',
                            'rgba(6, 182, 212, 1)',
                            'rgba(220, 38, 38, 1)',
                            'rgba(234, 179, 8, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: 'Métodos de Pago Preferidos'
                        }
                    }
                }
            });

            // JavaScript para la funcionalidad "Ver más/menos"
            document.querySelectorAll('.show-more-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const targetId = this.dataset.target;
                    const listContainer = document.getElementById(targetId);
                    const hiddenItems = listContainer.querySelectorAll('.hidden-list-item');
                    
                    if (this.textContent === 'Ver más') {
                        hiddenItems.forEach(item => {
                            item.style.display = 'list-item';
                        });
                        this.textContent = 'Ver menos';
                    } else {
                        hiddenItems.forEach(item => {
                            item.style.display = 'none';
                        });
                        this.textContent = 'Ver más';
                    }
                });
            });
        });
    </script>
</body>
</html>