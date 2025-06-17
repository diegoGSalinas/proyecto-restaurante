/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Dao.ProductoDao;
import Modelo.Producto;
import Dao.CategoriaDao;
import Modelo.Categoria;
import Dao.MarcaDao;
import Modelo.Marca;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dkred
 */
@WebServlet(name = "ControladorProducto", urlPatterns = {"/ControladorProducto"})
public class ControladorProducto extends HttpServlet {

    private final ProductoDao pdao = new ProductoDao();
    private final CategoriaDao cdao = new CategoriaDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener la marca seleccionada
        String marcaId = request.getParameter("marca");
        String categoriaId = request.getParameter("categoria");
        Integer marcaSeleccionada = 1; // Inicializar como null
        try {
            if (marcaId != null && !marcaId.isEmpty()) {
                marcaSeleccionada = Integer.parseInt(marcaId);
            }
        } catch (NumberFormatException e) {
            // Si hay error, marcaSeleccionada permanece null
        }

        // Obtener categorías y productos
        List<Categoria> categorias = cdao.listar();
        List<List<Producto>> listaDeListas = new ArrayList<>();
        for (Categoria c : categorias) {
            int idCategoria = c.getId_categoria();
            List<Producto> productos = pdao.listar_por_categoria(idCategoria);
            listaDeListas.add(productos);
        }

        // Obtener marcas
        MarcaDao marcaDao = new MarcaDao();
        List<Marca> marcas = marcaDao.listar();

        // Pasar los datos a la vista
        request.setAttribute("listaDeListas", listaDeListas);
        request.setAttribute("categorias", categorias);
        request.setAttribute("marcas", marcas);
        request.setAttribute("marcaSeleccionada", marcaSeleccionada);
        request.getRequestDispatcher("JSP/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
