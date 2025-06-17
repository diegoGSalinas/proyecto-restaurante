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
                        <a href="${pageContext.request.contextPath}/ControladorProductoAdm" class="nav-link" title="Administrar productos">
                            <i class="fas fa-cog"></i> ADMINISTRAR
                        </a> 
                        <span class="user-name"><%= cliente.getNombre()%></span>
                        <a href="${pageContext.request.contextPath}/JSP/logout.jsp" class="nav-link cerrar-sesion">CERRAR SESIÓN</a>
                    </div>
                    <% }%>
                </nav>
            </div>
        </div>
    </div>
</header>