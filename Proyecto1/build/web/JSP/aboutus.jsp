<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Nosotros</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/aboutus.css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body>
        <!-- Header -->
        <%@ include file="header.jsp" %>

        <section class="about-container">
            <div class="about-header">
                <h1><span class="bar">|</span> ACERCA DE NOSOTROS</h1>
                <p class="about-subtitle">Lema de la empresa</p>

                <%
                    String seccion = request.getParameter("seccion");
                %>
                <nav class="about-menu">
                    <a href="aboutus.jsp?seccion=historia" class="<%= ("historia".equals(seccion)) ? "active" : ""%>">NUESTRA HISTORIA</a>
                    <a href="aboutus.jsp?seccion=mision" class="<%= ("mision".equals(seccion)) ? "active" : ""%>">MISION</a>
                    <a href="aboutus.jsp?seccion=vision" class="<%= ("vision".equals(seccion)) ? "active" : ""%>">VISION</a>
                    <a href="aboutus.jsp?seccion=valores" class="<%= ("valores".equals(seccion)) ? "active" : ""%>">VALORES</a>
                </nav>
            </div>

            <hr class="about-divider">

            <div class="about-content">
                <% if ("historia".equals(seccion)) { %>
                <h2>Nuestra Historia</h2>
                <p>Somos una empresa dedicada a brindar el mejor servicio gastronómico. Desde nuestros inicios, hemos crecido gracias a la pasión y compromiso de nuestro equipo, ofreciendo experiencias únicas a nuestros clientes.</p>
                <p>Nuestro recorrido ha estado marcado por la innovación y la búsqueda constante de la excelencia en cada uno de nuestros productos y servicios.</p>
                <% } else if ("mision".equals(seccion)) { %>
                <h2>Misión</h2>
                <p>Nuestra misión es superar las expectativas de nuestros clientes, ofreciendo productos y servicios de alta calidad, con un enfoque en la satisfacción y el bienestar de quienes nos eligen día a día.</p>
                <% } else if ("vision".equals(seccion)) { %>
                <h2>Visión</h2>
                <p>Ser reconocidos como líderes en el sector gastronómico, expandiendo nuestra presencia y manteniendo nuestro compromiso con la innovación, la calidad y la responsabilidad social.</p>
                <% } else if ("valores".equals(seccion)) { %>
                <h2>Valores</h2>
                <ul>
                    <li><b>Calidad:</b> Buscamos la excelencia en todo lo que hacemos.</li>
                    <li><b>Compromiso:</b> Nos dedicamos a satisfacer a nuestros clientes y colaboradores.</li>
                    <li><b>Innovación:</b> Apostamos por la mejora continua y la creatividad.</li>
                    <li><b>Respeto:</b> Valoramos a las personas y fomentamos un ambiente inclusivo.</li>
                </ul>
                <% }%>
            </div>
            <div class="about-image">
                <img src="../Images/Varieties/about-us.jpg" alt="Nuestro Servicio Maido">
            </div>
        </section>

        <%@ include file="footer.jsp" %>

    </body>

</html>