package Controlador;

import Dao.MarcaDao;
import Modelo.Marca;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

@WebServlet(name = "ControladorMarca", urlPatterns = {"/ControladorMarca"})
public class ControladorMarca extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "listar":
                    listarMarcas(request, response);
                    break;
                case "agregar":
                    request.getRequestDispatcher("/JSP/agregarMarca.jsp").forward(request, response);
                    break;
                case "eliminar":
                    eliminarMarca(request, response);
                    break;
                case "editar":
                    cargarMarcaParaEditar(request, response);
                    break;
            }
        } else {
            listarMarcas(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "agregar":
                    agregarMarca(request, response);
                    break;
                case "actualizar":
                    actualizarMarca(request, response);
                    break;
            }
        }
    }

    private void listarMarcas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MarcaDao dao = new MarcaDao();
        List<Marca> marcas = dao.listar();
        request.setAttribute("marcas", marcas);
        request.getRequestDispatcher("/JSP/marcaAdm.jsp").forward(request, response);
    }

    private void agregarMarca(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre_marca");
        String img = request.getParameter("img_marca");
        String latitud = request.getParameter("latitud");
        String longitud = request.getParameter("longitud");

        Marca marca = new Marca();
        marca.setNombre_marca(nombre);
        marca.setImg_marca(img);
        marca.setLatitud(latitud);
        marca.setLongitud(longitud);

        MarcaDao dao = new MarcaDao();
        try {
            int resultado = dao.agregar(marca);
            if (resultado > 0) {
                request.setAttribute("mensajeExito", "Marca agregada correctamente");
                listarMarcas(request, response);
            } else {
                request.setAttribute("error", "Error al agregar la marca: No se generó un ID válido");
                listarMarcas(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error al agregar la marca: " + e.getMessage());
            request.getRequestDispatcher("/JSP/marcas.jsp").forward(request, response);
        }
    }

    private void cargarMarcaParaEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id_marca"));
            MarcaDao dao = new MarcaDao();
            Marca marca = dao.obtenerPorId(id);

            if (marca != null) {
                request.setAttribute("marca", marca);
                request.getRequestDispatcher("/JSP/editarMarca.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Marca no encontrada");
                request.getRequestDispatcher("/JSP/marcaAdm.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de marca inválido");
            request.getRequestDispatcher("/JSP/marcaAdm.jsp").forward(request, response);
        }
    }

    private void actualizarMarca(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id_marca"));
            String nombre = request.getParameter("nombre_marca");
            String img = request.getParameter("img_marca");
            String latitud = request.getParameter("latitud");
            String longitud = request.getParameter("longitud");

            Marca marca = new Marca();
            marca.setId_marca(id);
            marca.setNombre_marca(nombre);
            marca.setImg_marca(img);
            marca.setLatitud(latitud);
            marca.setLongitud(longitud);

            MarcaDao dao = new MarcaDao();
            int resultado = dao.actualizar(marca);

            if (resultado > 0) {
                request.setAttribute("mensajeExito", "Marca actualizada correctamente");
                listarMarcas(request, response);
            } else {
                request.setAttribute("error", "Error al actualizar la marca: No se encontró la marca");
                listarMarcas(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error al actualizar la marca: " + e.getMessage());
            listarMarcas(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Error: El ID de la marca debe ser un número válido");
            listarMarcas(request, response);
        }
    }

    private void eliminarMarca(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id_marca"));
            MarcaDao dao = new MarcaDao();
            int resultado = dao.eliminar(id);

            if (resultado > 0) {
                response.sendRedirect("ControladorMarca?accion=listar");
            } else {
                request.setAttribute("error", "Error al eliminar la marca: No se encontró la marca");
                request.getRequestDispatcher("/JSP/marcas.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error al eliminar la marca: " + e.getMessage());
            request.getRequestDispatcher("/JSP/marcas.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Error: El ID de la marca debe ser un número válido");
            request.getRequestDispatcher("/JSP/marcas.jsp").forward(request, response);
        }
    }
}
