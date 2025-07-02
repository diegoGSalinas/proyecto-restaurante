package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Dao.PedidoDao;
import Modelo.Pedido;
import java.util.List;

@WebServlet(name = "ControladorPedido", urlPatterns = {"/ControladorPedido"})
public class ControladorPedido extends HttpServlet {
    private PedidoDao pedidoDao = new PedidoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null || action.equals("listar")) {
            // Listar pedidos
            List<Pedido> pedidos = pedidoDao.listarPedidos();
            request.setAttribute("pedidos", pedidos);
            request.getRequestDispatcher("/JSP/pedidoAdm.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null && action.equals("editarEstado")) {
            // Editar estado del pedido
            int id_pedido = Integer.parseInt(request.getParameter("id_pedido"));
            String nuevoEstado = request.getParameter("nuevoEstado");
            
            boolean resultado = pedidoDao.editarEstado(id_pedido, nuevoEstado);
            
            if (resultado) {
                request.setAttribute("mensaje", "Estado actualizado correctamente");
            } else {
                request.setAttribute("error", "Error al actualizar el estado");
            }
        }
        
        // Redirigir a la vista de listar
        response.sendRedirect("ControladorPedido?action=listar");
    }
}
