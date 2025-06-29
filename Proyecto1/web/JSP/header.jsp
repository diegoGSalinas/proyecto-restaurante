<%@page import="Modelo.Cliente"%>
<%
    Cliente cliente = (Cliente) session.getAttribute("cliente");
%>
<header>
    <div class="container">
        <div class="header-content">
            <div class="header-left">
                <a href="${pageContext.request.contextPath}/controladorPrincipal" class="logo-link">
                    <img src="${pageContext.request.contextPath}/Images/logo/logo-maido.png" alt="Logo Maido" class="logo" />
                </a>
                <nav class="nav-links">
                    <a href="${pageContext.request.contextPath}/controladorProducto" class="nav-link">PRODUCTOS</a>
                    <a href="${pageContext.request.contextPath}/JSP/newxhtml.xhtml" class="nav-link">NOSOTROS</a>
                </nav>
            </div>
            <div class="header-right">
                <nav>
                    <% if (cliente == null) { %>
                    <a href="${pageContext.request.contextPath}/JSP/login.jsp" class="nav-link">INICIAR SESIÓN</a>
                    <% } else {%>
                    <div class="user-session">
                        <a href="${pageContext.request.contextPath}/JSP/verCarrito.jsp" class="nav-link carrito-icon" title="Carrito">
                            <i class="fas fa-shopping-cart"></i>
                        </a>
                        <div class="dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-cog"></i> ADMINISTRAR
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/ControladorProductoAdm">
                                        <i class="fas fa-box"></i> Productos
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/ControladorMarca?accion=listar">
                                        <i class="fas fa-tags"></i> Marcas
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <span class="user-name"><%= cliente.getNombre()%></span>
                        <a href="${pageContext.request.contextPath}/JSP/logout.jsp" class="nav-link cerrar-sesion">CERRAR SESIÓN</a>
                    </div>
                    <% }%>
                </nav>
            </div>
        </div>
    </div>
</header>