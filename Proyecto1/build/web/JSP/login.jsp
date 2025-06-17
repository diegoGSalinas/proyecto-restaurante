<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String mensaje = "";
%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="http://localhost:8080/Proyecto1/CSS/login.css">
        <link rel="stylesheet" href="http://localhost:8080/Proyecto1/CSS/header.css">
        <link rel="stylesheet" href="http://localhost:8080/Proyecto1/CSS/footer.css">
    </head>

    <body>
        <%@ include file="header.jsp" %>

        <div class="container">
            <div class="row justify-content-center align-items-center min-vh-100">
                <div class="col-12 col-sm-8 col-md-6 col-lg-4">
                    <div class="login-container">
                        <div class="text-center mb-4">
                            <h2 class="mb-2">Iniciar sesión</h2>
                            <p class="mb-4">
                                ¿Es tu primera vez? 
                                <a href="${pageContext.request.contextPath}/JSP/registro.jsp" class="text-decoration-none text-primary">
                                    Regístrate
                                </a>
                            </p>
                        </div>

                        <form class="login-form" action="${pageContext.request.contextPath}/controladorUser" method="POST">
                            <div class="mb-3">
                                <label for="username" class="form-label">Usuario</label>
                                <input type="text" 
                                       class="form-control" 
                                       id="username" 
                                       name="username" 
                                       placeholder="Usuario" 
                                       required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña</label>
                                <input type="password" 
                                       class="form-control" 
                                       id="password" 
                                       name="password" 
                                       placeholder="Contraseña" 
                                       required>
                            </div>

                            <div class="mb-3">
                                <a href="#" class="forgot-password text-decoration-none">¿Olvidaste la contraseña?</a>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    ${error}
                                </div>
                            </c:if>

                            <button type="submit" 
                                    name="accion" 
                                    value="Login" 
                                    class="btn btn-dark w-100">
                                <i class="fas fa-sign-in-alt me-2"></i>
                                Iniciar sesión
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <% if (!mensaje.isEmpty()) {%>
        <div class="alert alert-danger fixed-top m-3">
            <%= mensaje%>
        </div>
        <% }%>

        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>