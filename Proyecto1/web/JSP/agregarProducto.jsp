<%@page import="java.util.List"%>
<%@page import="Modelo.Marca"%>
<%@page import="Modelo.Categoria"%>
<%@page import="Modelo.Producto"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
        <title>Agregar Nuevo Producto</title>
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
                <h2>Agregar Nuevo Producto</h2>

                <% if (request.getSession().getAttribute("mensajeError") != null) { %>
                <div class="alert alert-danger">
                    ${sessionScope.mensajeError}
                    <% request.getSession().removeAttribute("mensajeError"); %>
                </div>
                <% } %>

                <%
                    Producto producto = (Producto) request.getAttribute("producto");
                    String nombre = (producto != null) ? producto.getNombreProducto() : "";
                    String descripcion = (producto != null) ? producto.getDescripcionProducto() : "";
                    String precio = (producto != null) ? String.valueOf(producto.getPrecioProducto()) : "";
                    int idCategoria = (producto != null) ? producto.getIdCategoria() : 0;
                    int idMarca = (producto != null) ? producto.getIdMarca() : 0;
                    String imgProducto = (producto != null) ? producto.getImgProducto() : "";

                    Map<String, String> errores = (Map<String, String>) request.getAttribute("errores");
                    if (errores == null) {
                        errores = new HashMap<>();
                    }
                %>

                <form action="${pageContext.request.contextPath}/ControladorProductoAdm" method="POST">
                    <input type="hidden" name="accion" value="registrar">

                    <div class="form-group">
                        <label for="nombre" class="required">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" class="form-control <%= (errores.containsKey("nombre") ? "is-invalid" : "")%>" 
                               value="<%= nombre%>" required>
                        <% if (errores.containsKey("nombre")) {%>
                        <div class="invalid-feedback">
                            <%= errores.get("nombre")%>
                        </div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="descripcion" class="required">Descripción:</label>
                        <textarea id="descripcion" name="descripcion" class="form-control <%= (errores.containsKey("descripcion") ? "is-invalid" : "")%>" 
                                  rows="3" required><%= descripcion%></textarea>
                        <% if (errores.containsKey("descripcion")) {%>
                        <div class="invalid-feedback">
                            <%= errores.get("descripcion")%>
                        </div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="precio" class="required">Precio:</label>
                        <input type="number" id="precio" name="precio" class="form-control <%= (errores.containsKey("precio") ? "is-invalid" : "")%>" 
                               step="0.01" min="0" value="<%= precio%>" required>
                        <% if (errores.containsKey("precio")) {%>
                        <div class="invalid-feedback">
                            <%= errores.get("precio")%>
                        </div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="idCategoria" class="required">Categoría:</label>
                        <select id="idCategoria" name="idCategoria" class="form-control <%= (errores.containsKey("idCategoria") ? "is-invalid" : "")%>" required>
                            <option value="">Seleccione una categoría</option>
                            <% for (Categoria cat : categorias) {
                                    String selected = (cat.getId_categoria() == idCategoria) ? "selected" : "";
                            %>
                            <option value="<%= cat.getId_categoria()%>" <%= selected%>><%= cat.getNombre_categoria()%></option>
                            <% } %>
                        </select>
                        <% if (errores.containsKey("idCategoria")) {%>
                        <div class="invalid-feedback">
                            <%= errores.get("idCategoria")%>
                        </div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="idMarca" class="required">Marca:</label>
                        <select id="idMarca" name="idMarca" class="form-control <%= (errores.containsKey("idMarca") ? "is-invalid" : "")%>" required>
                            <option value="">Seleccione una marca</option>
                            <% for (Marca marca : marcas) {
                                    String selected = (marca.getId_marca() == idMarca) ? "selected" : "";
                            %>
                            <option value="<%= marca.getId_marca()%>" <%= selected%>><%= marca.getNombre_marca()%></option>
                            <% } %>
                        </select>
                        <% if (errores.containsKey("idMarca")) {%>
                        <div class="invalid-feedback">
                            <%= errores.get("idMarca")%>
                        </div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <label for="imgProducto">Nombre de la Imagen:</label>
                        <input type="text" id="imgProducto" name="imgProducto" 
                               class="form-control <%= (errores.containsKey("imgProducto") ? "is-invalid" : "")%>" 
                               placeholder="Ejemplo: producto.jpg" value="<%= imgProducto%>">
                        <small class="form-text text-muted">Solo el nombre del archivo (Ej: producto-nombre.jpg). La imagen debe estar en: /Images/products/</small>
                        <% if (errores.containsKey("imgProducto")) {%>
                        <div class="invalid-feedback">
                            <%= errores.get("imgProducto")%>
                        </div>
                        <% }%>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Guardar Producto
                        </button>
                        <a href="${pageContext.request.contextPath}/ControladorProductoAdm" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

    </body>
</html>
