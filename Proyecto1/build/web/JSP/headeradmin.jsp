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
                <a href="${pageContext.request.contextPath}/ControladorEstadisticas" class="logo-link">
                    <img src="${pageContext.request.contextPath}/Images/logo/logo-maido.png" alt="Logo Maido" class="logo" />
                </a>
                
            </div>
            <div class="header-right">
                <nav>
                    
                    <div class="user-session">
                       
                        <span class="user-name">ADMIN</span>
                        <a href="${pageContext.request.contextPath}/JSP/logout.jsp" class="nav-link cerrar-sesion">CERRAR SESIÓN</a>
                    </div>
                    
                </nav>
            </div>
        </div>
    </div>
</header>