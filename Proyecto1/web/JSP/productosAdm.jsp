<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="Modelo.Producto"%>
<%@page import="Modelo.Marca"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Map<Marca, List<Producto>> productosPorMarca = (Map<Marca, List<Producto>>) request.getAttribute("productosPorMarca");

    NumberFormat formatoMoneda = NumberFormat.getCurrencyInstance(new Locale("es", "PE"));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración de Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productosAdm.css" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="main-container">
            <!-- Menú lateral -->
            <div class="sidebar">
                <h3>Panel de Administración</h3>
                <ul class="nav-menu">
                    <li>
                        <a href="${pageContext.request.contextPath}/ControladorProductoAdm" 
                           class="active">
                            <i class="fas fa-box"></i> Productos
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ControladorMarca">
                            <i class="fas fa-tags"></i> Marcas
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ControladorOrden">
                            <i class="fas fa-shopping-cart"></i> Órdenes
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Contenido principal -->
            <div class="main-content">
                <div class="py-4">
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

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="mb-0">Gestión de Productos</h2>
                        <a href="${pageContext.request.contextPath}/ControladorProductoAdm?accion=nuevo" class="btn btn-success">
                            <i class="fas fa-plus"></i> Agregar Producto
                        </a>
                    </div>

                    <% if (productosPorMarca != null && !productosPorMarca.isEmpty()) {
                            for (Map.Entry<Marca, List<Producto>> entry : productosPorMarca.entrySet()) {
                                Marca marca = entry.getKey();
                                List<Producto> productosMarca = entry.getValue();
                    %>
                    <div class="bg-dark text-white p-3 mb-4 rounded-3">
                        <%= marca.getNombre_marca()%>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Imagen</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Precio</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Producto p : productosMarca) {%>
                                <tr>
                                    <td><%= p.getIdProducto()%></td>
                                    <td>
                                        <% if (p.getImgProducto() != null && !p.getImgProducto().isEmpty()) {%>
                                        <img src="${pageContext.request.contextPath}/Images/products/<%= p.getImgProducto()%>" alt="<%= p.getNombreProducto()%>" class="producto-imagen rounded">
                                        <% } else { %>
                                        <span class="text-muted">Sin imagen</span>
                                        <% }%>
                                    </td>
                                    <td><%= p.getNombreProducto()%></td>
                                    <td><%= p.getDescripcionProducto()%></td>
                                    <td><%= formatoMoneda.format(p.getPrecioProducto())%></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/ControladorProductoAdm?accion=editar&id=<%= p.getIdProducto()%>" class="btn btn-warning btn-sm" title="Editar">
                                            <i class="fas fa-edit"></i> Editar
                                        </a>
                                        <a href="${pageContext.request.contextPath}/ControladorProductoAdm?accion=eliminar&id=<%= p.getIdProducto()%>" class="btn btn-danger btn-sm" title="Eliminar" onclick="return confirm('¿Está seguro de eliminar este producto?')">
                                            <i class="fas fa-trash"></i> Eliminar
                                        </a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <div class="alert alert-info">
                        No hay productos disponibles.
                    </div>
                    <% } %>

                    <% if (productosPorMarca.isEmpty()) { %>
                    <div class="alert alert-info">
                        No hay productos registrados.
                    </div>
                    <% }%>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>
                </html>
