/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Dao.ProductoDao;
import Dao.MarcaDao;
import Modelo.Producto;
import Modelo.Marca;
import Modelo.Cliente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author dkred
 */
public class ControladorPrincipal extends HttpServlet {
    private final ProductoDao pdao = new ProductoDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession sesion = request.getSession();
      Cliente u = (Cliente) sesion.getAttribute("cliente");
       
        if (u == null) {
            response.sendRedirect("JSP/login.jsp");
            return;
        }
        MarcaDao mdao = new MarcaDao();
        List<Producto> productos = pdao.listar();
        List<Marca> marcas = mdao.listar();
        request.setAttribute("productos", productos);
        request.setAttribute("marcas", marcas);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
