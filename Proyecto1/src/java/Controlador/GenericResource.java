/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/GenericResource.java to edit this template
 */
package Controlador;

import Dao.ProductoDao;
import Modelo.Carrito;
import Modelo.Producto;

import jakarta.ws.rs.Path;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
/**
 * REST Web Service
 *
 * @author dkred
 */
@Path("generic")
public class GenericResource {

  

    public GenericResource() {
    }

    /**
     * Retrieves representation of an instance of Controlador.GenericResource
     * @return an instance of java.lang.String
     */
    @POST
    @Path("/agregar")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public Response agregarProducto(JsonIdDTO idDTO, @Context HttpServletRequest request) {

        int id = idDTO.getId();
        int cantidad = 0;

        ProductoDao productoDAO = new ProductoDao();
        Producto producto = productoDAO.obtenerProductoPorId(id);

        if (producto != null) {
            Carrito item = new Carrito(producto.getNombreProducto(), 1, producto.getPrecioProducto());
            item.setId_producto(producto.getIdProducto());

            HttpSession session = request.getSession();
            ArrayList<Carrito> carrito = (ArrayList<Carrito>) session.getAttribute("carrito");
            if (carrito == null) {
                carrito = new ArrayList<>();
            }

            boolean existe = false;
            for (Carrito c : carrito) {
                if (c.getId_producto() == producto.getIdProducto()) {
                    c.setCantidad(c.getCantidad() + 1);
                    existe = true;
                    break;
                }
            }

            if (!existe) {
                carrito.add(item);
            }

            if (session.getAttribute("cantidad") != null) {
                cantidad = (int) session.getAttribute("cantidad");
            }

            session.setAttribute("cantidad", cantidad + 1);
            session.setAttribute("carrito", carrito);

            return Response.ok(String.valueOf(cantidad + 1)).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("Producto no encontrado").build();
        }
    }

    // DTO simple para recibir el JSON
    public static class JsonIdDTO {
        private int id;

        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
    }
}
