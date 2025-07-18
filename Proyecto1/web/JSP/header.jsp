<%@page import="Modelo.Cliente"%>
<%@page import="Modelo.Carrito"%>
<%
    Cliente cliente = (Cliente) session.getAttribute("cliente");
%>
<%
    int cantidadCarrito = 0;
    if (session.getAttribute("cantidad") != null) {
        cantidadCarrito = (int)session.getAttribute("cantidad"); 
    }
%>
<style>
    .carrito-icon {
        position: relative;
        display: inline-block;
    }

    .cart-count {
        position: absolute;
        top: -5px;
        right: -10px;
        background-color: red;
        color: white;
        font-size: 12px;
        padding: 2px 6px;
        border-radius: 50%;
        font-weight: bold;
    }
</style>
<header>
    <div class="container">
        <div class="header-content">
            <div class="header-left">
                <a href="${pageContext.request.contextPath}/controladorPrincipal" class="logo-link">
                    <img src="${pageContext.request.contextPath}/Images/logo/logo-maido.png" alt="Logo Maido" class="logo" />
                </a>
                <nav class="nav-links">
                    <a href="${pageContext.request.contextPath}/controladorProducto" class="nav-link">PRODUCTOS</a>
                    <a href="${pageContext.request.contextPath}/JSP/aboutus.jsp" class="nav-link">NOSOTROS</a>
                      <a href="${pageContext.request.contextPath}/controladorOrden" class="nav-link">ORDENES</a>
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
                            <% if (cantidadCarrito > 0) { %>
                                <span class="cart-count" id="cart-count"><%= cantidadCarrito %></span>
                            <% } else { %>
                                <span class="cart-count d-none" id="cart-count">0</span>
                            <% } %>
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