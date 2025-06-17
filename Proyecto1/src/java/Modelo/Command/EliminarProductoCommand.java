package Modelo.Command;

import Dao.ProductoDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EliminarProductoCommand implements Command {

    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private final ProductoDao productoDao;

    public EliminarProductoCommand(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.productoDao = new ProductoDao();
    }

    @Override
    public void execute() {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean eliminado = productoDao.eliminar(id);

            if (eliminado) {
                request.getSession().setAttribute("mensajeExito", "Producto eliminado correctamente");
            } else {
                request.getSession().setAttribute("mensajeError", "No se pudo eliminar el producto");
            }

            response.sendRedirect(request.getContextPath() + "/ControladorProductoAdm");

        } catch (Exception e) {
            request.getSession().setAttribute("mensajeError", "Error al eliminar: " + e.getMessage());
            try {
                response.sendRedirect(request.getContextPath() + "/ControladorProductoAdm");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
