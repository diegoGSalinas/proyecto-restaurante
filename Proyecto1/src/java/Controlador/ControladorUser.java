/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;
import Modelo.Usuario;
import Modelo.Cliente;
import Dao.UsuarioDao;
import Dao.ClienteDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author dkred
 */
public class ControladorUser extends HttpServlet{
    private final UsuarioDao udao = new UsuarioDao();
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lógica del controlador
       
        List<Usuario> usuarios = udao.listar(); 
        //response.getWriter().write("Mensaje desde el controlador");
                // Pasar la lista como atributo al JSP
                System.out.println("Estacionamientos enviados al JSP: " + usuarios.size());
               // request.setAttribute("estacionamientos", usuarios);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Procesar petición POST
        
        String accion = request.getParameter("accion");
        if ("Login".equals(accion)) {
            String username = request.getParameter("username");
            String clave = request.getParameter("password");

            UsuarioDao dao = new UsuarioDao();
            Usuario u = dao.validar(username, clave);

             if (u != null) {
                 int id_user = u.getId_usuario();
                 ClienteDao cidao = new ClienteDao();
                 Cliente ci = cidao.buscar_por_id_user(id_user);
                 
                 request.getSession().setAttribute("cliente", ci);
                 System.out.println(ci.getApellidos());
                response.sendRedirect("controladorPrincipal"); // página principal
            } else {
                request.setAttribute("error", "Credenciales inválidas");
                request.getRequestDispatcher("JSP/login.jsp").forward(request, response);
            }
        }
        else if("Registrar".equals(accion)){
            String username = request.getParameter("username");
            String clave = request.getParameter("password");
            String nombre = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");
            String direccion = request.getParameter("direccion");
            String celular = request.getParameter("celular");
            String latitud = request.getParameter("latitud");
            String longitud = request.getParameter("longitud");
            
            int prioridad = 2;
            UsuarioDao dao = new UsuarioDao();
            Usuario u = new Usuario(username,clave,prioridad);
            int id_usuario =dao.agregar(u);
            
            ClienteDao clientedao = new ClienteDao();
            Cliente cliente = new Cliente(nombre,apellidos,celular,correo,id_usuario,direccion,latitud,longitud);
            clientedao.agregar(cliente);
            
            request.getSession().setAttribute("cliente", cliente);
            response.sendRedirect("controladorPrincipal"); // página principal
        }
    }
}
