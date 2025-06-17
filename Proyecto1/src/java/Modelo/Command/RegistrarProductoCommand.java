package Modelo.Command;

import Dao.ProductoDao;
import Modelo.Producto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.file.Paths;

public class RegistrarProductoCommand implements Command {

    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private final ProductoDao productoDao;

    public RegistrarProductoCommand(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.productoDao = new ProductoDao();
    }

    @Override
    public void execute() {
        try {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String precioStr = request.getParameter("precio");
            String idCategoriaStr = request.getParameter("idCategoria");
            String idMarcaStr = request.getParameter("idMarca");
            String imgProducto = request.getParameter("imgProducto");

            if (nombre == null || descripcion == null || precioStr == null
                    || idCategoriaStr == null || idMarcaStr == null || imgProducto == null) {
                throw new IllegalArgumentException("Faltan parámetros requeridos");
            }

            double precio = Double.parseDouble(precioStr);
            int idCategoria = Integer.parseInt(idCategoriaStr);
            int idMarca = Integer.parseInt(idMarcaStr);

            // Verifica que el nombre del archivo no contenga rutas y sea texto plano
            String fileName = Paths.get(imgProducto).getFileName().toString();

            Producto producto = new Producto(0, nombre, descripcion, precio, fileName, idCategoria, idMarca);
            boolean registrado = productoDao.agregar(producto);

            if (registrado) {
                request.getSession().setAttribute("mensajeExito", "Producto registrado correctamente");
            } else {
                request.getSession().setAttribute("mensajeError", "No se pudo registrar el producto");
            }

            response.sendRedirect(request.getContextPath() + "/ControladorProductoAdm");

        } catch (Exception e) {
            request.getSession().setAttribute("mensajeError", "Error al registrar: " + e.getMessage());
            try {
                response.sendRedirect(request.getContextPath() + "/ControladorProductoAdm");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
