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
                                <a href="${pageContext.request.contextPath}/ControladorMarca?accion=listar">
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
                        <h2 class="mb-4">Gestión de Pedidos</h2>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp"%>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>