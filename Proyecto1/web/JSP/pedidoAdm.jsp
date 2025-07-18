<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración de Pedidos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productosAdm.css" />
    </head>
    <body>
        <jsp:include page="headeradmin.jsp"/>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 col-lg-2 sidebar">
                    <div class="sidebar-content">
                        <h3>Panel de Administración</h3>
                        <ul class="nav-menu">
                            <li>
                                <a href="${pageContext.request.contextPath}/ControladorEstadisticas" >
                                    <i class="fas fa-chart-bar"></i> Dashboard
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/ControladorProductoAdm" >
                                    <i class="fas fa-box"></i> Productos
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/ControladorMarca" >
                                    <i class="fas fa-tags"></i> Marcas
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/ControladorPedido" class="active">
                                    <i class="fas fa-shopping-cart"></i> Pedidos
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-9 col-lg-10 main-content">
                    <div class="content-wrapper">
                        <div class="py-4">
                            <% if (request.getAttribute("mensajeExito") != null) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${requestScope.mensajeExito}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% } %>
                            <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${requestScope.error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% }%>
                        </div>
                        <h2 class="mb-4">Gestión de Pedidos</h2>


                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID Pedido</th>
                                        <th>Total</th>
                                        <th>Cliente</th>
                                        <th>Método de Pago</th>
                                        <th>Dirección</th>
                                        <th>Teléfono</th>
                                        <th>Estado</th>
                                        <th>Cambiar Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="pedido" items="${pedidos}">
                                        <tr>
                                            <td>${pedido.id_pedido}</td>
                                            <td>${pedido.total}</td>
                                            <td>${pedido.id_cliente}</td>
                                            <td>${pedido.metodo_pago}</td>
                                            <td>${pedido.direccion_pago}</td>
                                            <td>${pedido.telefono_pago}</td>
                                            <td>
                                                <span class="badge ${pedido.estado == 'PENDIENTE' || pedido.estado == 'EN_CAMINO' ? 'bg-success' : 
                                                    pedido.estado == 'Procesando Devolucion' ? 'bg-warning' : 
                                                    pedido.estado == 'DEVOLUCION_FINALIZADA' ? 'bg-danger' : 'bg-primary'}">
                                                    ${pedido.estado} 
                                                </span>
                                                <br><c:if test="${pedido.estado == 'Procesando Devolucion'}">
                                                    <span style="font-siZe:10px" >
                                                        ${pedido.motivo}
                                                    </span>
                                                    
                                                 
                                                 </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${pedido.estado != 'FINALIZADO'}">
                                                    <form action="ControladorPedido" method="post" class="d-inline">
                                                        <input type="hidden" name="action" value="editarEstado">
                                                        <input type="hidden" name="id_pedido" value="${pedido.id_pedido}">
                                                        <select name="nuevoEstado" class="form-select form-select-sm">
                                                            <option value="PENDIENTE" ${pedido.estado == 'PENDIENTE' ? 'selected' : ''}>PENDIENTE</option>
                                                            <option value="EN_CAMINO" ${pedido.estado == 'EN_CAMINO' ? 'selected' : ''}>EN_CAMINO</option>
                                                            <option value="PROCESANDO_DEVOLUCION" ${pedido.estado == 'Procesando Devolucion' ? 'selected' : ''}>PROCESANDO_DEVOLUCION</option>
                                                            <option value="DEVOLUCION_FINALIZADA" ${pedido.estado == 'DEVOLUCION_FINALIZADA' ? 'selected' : ''}>DEVOLUCION_FINALIZADA</option>
                                                            <option value="FINALIZADO" ${pedido.estado == 'FINALIZADO' ? 'selected' : ''}>FINALIZADO</option>
                                                        </select>
                                                        <button type="submit" class="btn btn-sm btn-primary ms-2">
                                                            <i class="fas fa-sync-alt"></i> Cambiar
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${pedido.estado == 'FINALIZADO'}">
                                                    <span class="text-muted">Estado Finalizado</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp"%>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>