package Modelo.Command;

import Dao.ProductoDao;
import Modelo.Producto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ActualizarProductoCommand implements Command {

    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private final ProductoDao productoDao;

    public ActualizarProductoCommand(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.productoDao = new ProductoDao();
    }

    @Override
    public void execute() {
        try {
            request.setCharacterEncoding("UTF-8");

            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String imgProducto = request.getParameter("imgProducto");
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
            int idMarca = Integer.parseInt(request.getParameter("idMarca"));

            Producto producto = new Producto(id, nombre, descripcion, precio, imgProducto, idCategoria, idMarca);
            boolean actualizado = productoDao.actualizar(producto);

            if (actualizado) {
                request.getSession().setAttribute("mensajeExito", "Producto actualizado correctamente");
            } else {
                request.getSession().setAttribute("mensajeError", "No se pudo actualizar el producto");
            }

            response.sendRedirect(request.getContextPath() + "/ControladorProductoAdm");

        } catch (Exception e) {
            request.getSession().setAttribute("mensajeError", "Error al actualizar: " + e.getMessage());
            try {
                response.sendRedirect(request.getContextPath() + "/ControladorProductoAdm");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
