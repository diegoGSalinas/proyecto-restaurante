<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración de Marcas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productosAdm.css" />

    </head>
    <body>
        <jsp:include page="header.jsp"/>



        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 col-lg-2 sidebar">
                    <div class="sidebar-content">
                        <h3>Panel de Administración</h3>
                        <ul class="nav-menu">
                            <li>
                                <a href="${pageContext.request.contextPath}/ControladorProductoAdm">
                                    <i class="fas fa-box"></i> Productos
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/ControladorMarca?accion=listar" class="active">
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
                </div>
                <div class="col-md-9 col-lg-10 main-content">
                    <div class="content-wrapper">
                        <div class="py-4">
                            <% if (request.getAttribute("mensajeExito") != null) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${requestScope.mensajeExito}
                                <% if (request.getAttribute("id_nueva_marca") != null) { %>
                                (ID: ${requestScope.id_nueva_marca})
                                <% } %>
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
                        <h2 class="mb-4">Gestión de Marcas</h2>

                        <!-- Mensajes de error -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="mb-0">Gestión de Marcas</h2>
                            <a href="${pageContext.request.contextPath}/JSP/agregarMarca.jsp" class="btn btn-success">
                                <i class="fas fa-plus"></i> Agregar Nueva Marca
                            </a>
                        </div>

                        <!-- Tabla de marcas -->
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Imagen</th>
                                        <th>Latitud</th>
                                        <th>Longitud</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="marca" items="${marcas}">
                                        <tr>
                                            <td>${marca.id_marca}</td>
                                            <td>${marca.nombre_marca}</td>
                                            <td>
                                                <img src="${pageContext.request.contextPath}/Images/Restaurantes/${marca.img_marca}" alt="${marca.nombre_marca}" 
                                                     class="img-thumbnail" style="max-width: 50px;">
                                            </td>
                                            <td>${marca.latitud}</td>
                                            <td>${marca.longitud}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/ControladorMarca" method="GET" class="d-inline">
                                                    <input type="hidden" name="accion" value="editar">
                                                    <input type="hidden" name="id_marca" value="${marca.id_marca}">
                                                    <button type="submit" class="btn btn-warning btn-sm">
                                                        <i class="fas fa-edit"></i> Editar
                                                    </button>
                                                </form>
                                                <a href="${pageContext.request.contextPath}/ControladorMarca?accion=eliminar&id_marca=${marca.id_marca}" 
                                                   class="btn btn-danger btn-sm" 
                                                   onclick="return confirm('¿Está seguro de eliminar esta marca?')">
                                                    Eliminar
                                                </a>
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
