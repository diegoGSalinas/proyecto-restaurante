package Controlador;

import Dao.ProductoDao;
import Modelo.Producto;
import Dao.MarcaDao;
import Modelo.Marca;
import Dao.CategoriaDao;
import Modelo.Categoria;
import Modelo.Command.Command;
import Modelo.Command.ActualizarProductoCommand;
import Modelo.Command.RegistrarProductoCommand;
import Modelo.Command.EliminarProductoCommand;
import jakarta.servlet.ServletException;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

@WebServlet(name = "ControladorProductoAdm", urlPatterns = {"/ControladorProductoAdm"})
public class ControladorProductoAdm extends HttpServlet {

    private final ProductoDao productoDao = new ProductoDao();
    private final MarcaDao marcaDao = new MarcaDao();
    private final CategoriaDao categoriaDao = new CategoriaDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        try {
            if (accion != null) {
                switch (accion) {
                    case "editar":
                        this.editarProducto(request, response);
                        return;
                    case "eliminar":
                        this.eliminarProducto(request, response);
                        return;
                    case "nuevo":
                        this.mostrarFormularioNuevo(request, response);
                        return;
                }
            }

            // Si no hay acción o listar, se presenta la lista de productos
            this.listarProductos(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        try {
            if ("actualizar".equals(accion)) {
                this.actualizarProducto(request, response);
            } else if ("registrar".equals(accion)) {
                this.registrarProducto(request, response);
            } else {
                this.listarProductos(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }

    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            List<Producto> productos = productoDao.listar();

            List<Marca> marcas = marcaDao.listar();

            // Agrupar productos por marca
            Map<Marca, List<Producto>> productosPorMarca = new HashMap<>();
            if (marcas != null && productos != null) {
                for (Marca marca : marcas) {
                    List<Producto> productosMarca = new ArrayList<>();
                    for (Producto producto : productos) {
                        if (producto.getIdMarca() == marca.getId_marca()) {
                            productosMarca.add(producto);
                        }
                    }
                    if (!productosMarca.isEmpty()) {
                        productosPorMarca.put(marca, productosMarca);
                    }
                }
            }

            request.setAttribute("productosPorMarca", productosPorMarca);
            request.setAttribute("marcas", marcas);

            request.getRequestDispatcher("JSP/productosAdm.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error al cargar la lista de productos: " + e.getMessage());
            request.getRequestDispatcher("JSP/productosAdm.jsp").forward(request, response);
        }
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            List<Marca> marcas = marcaDao.listar();

            List<Categoria> categorias = categoriaDao.listar();

            request.setAttribute("marcas", marcas);
            request.setAttribute("categorias", categorias);

            request.getRequestDispatcher("JSP/agregarProducto.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("mensajeError", "Error al cargar el formulario: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ControladorProductoAdm");
        }
    }

    private void editarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = productoDao.buscar(id);

            if (producto != null) {
                List<Marca> marcas = marcaDao.listar();
                List<Categoria> categorias = categoriaDao.listar();

                request.setAttribute("producto", producto);
                request.setAttribute("marcas", marcas);
                request.setAttribute("categorias", categorias);
                request.getRequestDispatcher("JSP/editarProducto.jsp").forward(request, response);
            } else {
                request.setAttribute("mensaje", "Producto no encontrado");
                listarProductos(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "ID de producto inválido");
            listarProductos(request, response);
        }
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Command command = new EliminarProductoCommand(request, response);
        command.execute();
    }

    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Command command = new ActualizarProductoCommand(request, response);
        command.execute();
    }

    private void registrarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Command command = new RegistrarProductoCommand(request, response);
        command.execute();
    }

    @Override
    public String getServletInfo() {
        return "Controlador para la administración de productos";
    }
}
