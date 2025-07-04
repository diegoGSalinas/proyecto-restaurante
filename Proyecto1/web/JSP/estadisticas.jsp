<%--
    Document   : estadisticas
    Created on : 4 jul. 2025, 05:23:32
    Author     : Usuario
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Estadísticas de Productos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Tailwind CSS CDN for styling -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
    <style>
       
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6; 
        }
        
        .container {
            margin-top: 2rem;
            margin-bottom: 2rem;
        }
        
        .back-btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: #dc3545;
            color: white;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .back-btn:hover {
            background-color: #4338ca; /* Indigo 700 */
            color: white;
        }
    </style>
</head>
<body>
    <%-- Include header JSP --%>
    <%@ include file="header.jsp" %>

    <div class="container mx-auto p-4 max-w-4xl">
        <h1 class="text-center text-4xl font-extrabold text-gray-800 mb-8">Estadísticas de Productos</h1>

        <!-- Productos Más Comprados Section -->
        <div class="stats-section bg-white p-6 rounded-lg shadow-md mb-6">
            <h2 class="text-2xl font-semibold text-gray-700 mb-3">Productos Más Comprados</h2>
            <p class="text-gray-600 mb-4">Estos son los productos que más éxito han tenido en ventas:</p>
            <ul class="list-disc list-inside text-gray-700 space-y-2">
                <c:forEach var="producto" items="${productosMasComprados}">
                    <li>${producto}</li>
                </c:forEach>
            </ul>
        </div>

        <!-- Productos Menos Comprados Section -->
        <div class="stats-section bg-white p-6 rounded-lg shadow-md mb-6">
            <h2 class="text-2xl font-semibold text-gray-700 mb-3">Productos Menos Comprados</h2>
            <p class="text-gray-600 mb-4">Estos productos podrían necesitar un impulso o revisión:</p>
            <ul class="list-disc list-inside text-gray-700 space-y-2">
                <c:forEach var="producto" items="${productosMenosComprados}">
                    <li>${producto}</li>
                </c:forEach>
            </ul>
        </div>

        <!-- Detalle de Ventas por Producto Section -->
        <div class="stats-section bg-white p-6 rounded-lg shadow-md mb-6">
            <h2 class="text-2xl font-semibold text-gray-700 mb-3">Detalle de Ventas por Producto</h2>
            <p class="text-gray-600 mb-4">Cantidad de unidades vendidas y el ingreso generado por cada producto:</p>
            <ul class="list-disc list-inside text-gray-700 space-y-2">
                <c:forEach var="detalle" items="${ventasPorProducto}">
                    <li>${detalle}</li>
                </c:forEach>
            </ul>
        </div>

        <!-- Ingresos Totales Generados Section -->
        <div class="total-summary bg-indigo-500 text-white p-6 rounded-lg shadow-lg mb-6 text-center">
            <h3 class="text-3xl font-bold">Ingresos Totales Generados: S/ ${ingresosTotales}</h3>
        </div>

<!--         Conteo de Productos por Marca Section 
        <div class="stats-section bg-white p-6 rounded-lg shadow-md mb-6">
            <h2 class="text-2xl font-semibold text-gray-700 mb-3">Conteo de Productos por Marca</h2>
            <p class="text-gray-600 mb-4">Productos registrados por cada ID de marca:</p>
            <ul class="list-disc list-inside text-gray-700 space-y-2">
                <c:forEach var="entry" items="${conteoPorMarca}">
                    <li>ID Marca ${entry.key}: ${entry.value} productos</li>
                </c:forEach>
            </ul>
            <p class="text-gray-500 text-sm mt-4"><strong>Nota:</strong> Para mostrar los nombres de las marcas aquí, necesitarías pasar un mapa de `id_marca` a `nombre_marca` desde el controlador.</p>
        </div>-->

        <div class="text-center mt-8">
            <a href="${pageContext.request.contextPath}/controladorPrincipal" class="back-btn">← Volver a la Pantalla Principal</a>
        </div>
    </div>

    <%-- Include footer JSP --%>
    <%@ include file="footer.jsp" %>
</body>
</html>
