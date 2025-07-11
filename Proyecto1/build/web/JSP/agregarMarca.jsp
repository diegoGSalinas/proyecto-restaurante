<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agregar Nueva Marca</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/agregarProducto.css" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container">
            <div class="form-container">
                <h2>Agregar Nueva Marca</h2>

                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    ${requestScope.error}
                </div>
                <% }%>

                <form action="${pageContext.request.contextPath}/ControladorMarca" method="POST" class="needs-validation" novalidate>
                    <input type="hidden" name="accion" value="agregar">

                    <div class="form-group">
                        <label for="nombre_marca" class="required">Nombre:</label>
                        <input type="text" id="nombre_marca" name="nombre_marca" 
                               class="form-control" required>
                        <div class="invalid-feedback">
                            Por favor ingrese el nombre de la marca.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="img_marca" class="required">Imagen:</label>
                        <input type="text" id="img_marca" name="img_marca" 
                               class="form-control" required>
                        <div class="invalid-feedback">
                            Por favor ingrese la URL de la imagen de la marca.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="latitud" class="required">Latitud:</label>
                        <input type="text" id="latitud" name="latitud" 
                               class="form-control" required>
                        <div class="invalid-feedback">
                            Por favor ingrese la latitud.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="longitud" class="required">Longitud:</label>
                        <input type="text" id="longitud" name="longitud" 
                               class="form-control" required>
                        <div class="invalid-feedback">
                            Por favor ingrese la longitud.
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Guardar Marca
                        </button>
                        <a href="${pageContext.request.contextPath}/ControladorMarca?accion=listar" 
                           class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <%@include file="footer.jsp"%>
    </body>
</html>
