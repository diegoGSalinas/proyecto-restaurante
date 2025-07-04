/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Dao.PedidoDao;
import Modelo.Cliente;
import Modelo.Devolucion;
import Modelo.Orden;
import Dao.OrdenDao;
import Dao.DevolucionDao;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ControladorOrden", urlPatterns = {"/ControladorOrden"})
public class ControladorOrden extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Cliente u = (Cliente) sesion.getAttribute("cliente");
         if (u == null) {
            response.sendRedirect("JSP/login.jsp");
            return;
        }
        PedidoDao pedido = new PedidoDao();
        List lista_pedidos = pedido.busquedaporIdCliente(u.getId_cliente());
        
        request.setAttribute("listaPedidos", lista_pedidos);
        request.getRequestDispatcher("JSP/ordenes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
       String accion = request.getParameter("accion");
       if ("reembolso".equals(accion)) {
            int id_pedido =  Integer.parseInt(request.getParameter("id_pedido"));
            String mensaje = request.getParameter("motivo");
            Devolucion dev = new Devolucion() ;
            dev.setId_pedido(id_pedido);
            dev.setMotivo(mensaje);
            DevolucionDao devdao = new DevolucionDao();
            devdao.insertarDevolucion(dev);

            PedidoDao pedido = new PedidoDao();
            pedido.modificarEstado(id_pedido, "Procesando Devolucion");
            response.sendRedirect("controladorOrden");
       }
       else if("mapa".equals(accion)){
           int idPedido = Integer.parseInt(request.getParameter("id"));
           Orden orden = new Orden();
           OrdenDao odao = new OrdenDao();
           List<String[]> listas = odao.listarOrden(idPedido);
           request.setAttribute("listas", listas);
           request.getRequestDispatcher("JSP/detallePedido.jsp").forward(request, response);
       }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
