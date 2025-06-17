<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Marca"%>
<%@page import="Modelo.Categoria"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Producto producto = (Producto) request.getAttribute("producto");

    List<Marca> marcas = (List<Marca>) request.getAttribute("marcas");
    if (marcas == null) {
        marcas = new ArrayList<>();
    }

    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    if (categorias == null) {
        categorias = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Producto</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/editarProducto.css" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container">
            <div class="form-container">
                <h2>Editar Producto</h2>

                <form action="${pageContext.request.contextPath}/ControladorProductoAdm" method="POST">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="id" value="${producto.idProducto}">

                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" class="form-control" value="${producto.nombreProducto}" required>
                    </div>

                    <div class="form-group">
                        <label for="descripcion">Descripción:</label>
                        <textarea id="descripcion" name="descripcion" class="form-control" rows="3" required>${producto.descripcionProducto}</textarea>
                    </div>

                    <div class="form-group">
                        <label for="precio">Precio:</label>
                        <input type="number" id="precio" name="precio" class="form-control" step="0.01" min="0" value="${producto.precioProducto}" required>
                    </div>

                    <div class="form-group">
                        <label for="idCategoria">Categoría:</label>
                        <select id="idCategoria" name="idCategoria" class="form-control" required>
                            <option value="">Seleccione una categoría</option>
                            <% for (Categoria cat : categorias) {
                                    String selected = (cat.getId_categoria() == producto.getIdCategoria()) ? "selected" : "";
                            %>
                            <option value="<%= cat.getId_categoria()%>" <%= selected%>><%= cat.getNombre_categoria()%></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="idMarca">Marca:</label>
                        <select id="idMarca" name="idMarca" class="form-control" required>
                            <%
                                if (marcas != null && !marcas.isEmpty()) {
                                    for (Marca marca : marcas) {
                                        String selected = (producto != null && producto.getIdMarca() == marca.getId_marca()) ? "selected" : "";
                            %>
                            <option value="<%= marca.getId_marca()%>" <%= selected%>><%= marca.getNombre_marca()%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="imgProducto">URL de la Imagen:</label>
                        <input type="text" id="imgProducto" name="imgProducto" class="form-control" value="${producto.imgProducto}">
                        <small class="form-text text-muted">Ejemplo: nombre-imagen.jpg</small>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Guardar Cambios
                        </button>
                        <a href="${pageContext.request.contextPath}/ControladorProductoAdm" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
