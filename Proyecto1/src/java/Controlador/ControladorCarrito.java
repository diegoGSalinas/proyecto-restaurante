/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Dao.ProductoDao;
import Modelo.Carrito;
import Modelo.Producto;
import Modelo.Cliente;
import Modelo.Pedido;
import Modelo.Orden;
import Dao.PedidoDao;
import Dao.OrdenDao;
import Modelo.Orden;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dkred
 */
public class ControladorCarrito extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("generarPDF".equals(accion)) {
            try {
                generarVoucherPDF(request, response);
            } catch (DocumentException ex) {
                Logger.getLogger(ControladorCarrito.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        String idParam = request.getParameter("id");
        if (idParam != null) {
            int id = Integer.parseInt(idParam);

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

                // Verificar si ya existe el producto en el carrito
                boolean existe = false;
                for (Carrito c : carrito) {
                    if (c.getProducto().equals(producto.getNombreProducto())) {
                        c.setCantidad(c.getCantidad() + 1);
                        existe = true;
                        break;
                    }
                }
                if (!existe) {
                    carrito.add(item);
                }
               
            }

        }
        response.sendRedirect("controladorProducto");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("actualizar".equals(accion)) {
            // Actualizar cantidades
            HttpSession session = request.getSession();
            ArrayList<Carrito> carrito = (ArrayList<Carrito>) session.getAttribute("carrito");
            int size = Integer.parseInt(request.getParameter("size"));

            for (int i = 0; i < size; i++) {
                String nombre = request.getParameter("producto_" + i);
                int cantidad = Integer.parseInt(request.getParameter("cantidad_" + i));

                for (Carrito item : carrito) {
                    if (item.getProducto().equals(nombre)) {
                        item.setCantidad(cantidad);
                        break;
                    }
                }
            }
            session.setAttribute("carrito", carrito);
            response.sendRedirect("JSP/verCarrito.jsp");
        }
        else if ("pagar".equals(accion)) {
             HttpSession session = request.getSession();
             String metodo_pago = request.getParameter("metodo_pago");
             String nombre = request.getParameter("nombre_pago");
             String telefono = request.getParameter("telefono_pago");
             String direccion =request.getParameter("direccion_pago");
             HttpSession session2 = request.getSession();
             Pedido pago = new Pedido();
             pago.setMetodo_pago(metodo_pago);
             pago.setDireccion_pago(direccion);
             pago.setTelefono_pago(telefono);
             pago.setNombre_pago(nombre);
             pago.setEstado("procesado");
             session2.setAttribute("pago",pago);
             response.sendRedirect("JSP/verCarrito.jsp#compraExitosa");
        }
        else if ("agregar".equals(accion)) {
            
            int id = Integer.parseInt(request.getParameter("id"));
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

                // Verificar si ya existe el producto en el carrito (por ID)
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
                    cantidad = (int)session.getAttribute("cantidad");
                }
                
                session.setAttribute("cantidad",cantidad+1);
                
                session.setAttribute("carrito", carrito);

                // Respuesta AJAX (texto plano, puedes devolver JSON si prefieres)
                response.setContentType("text/plain");
               
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Producto no encontrado");
            }
            PrintWriter out = response.getWriter();
            out.println(cantidad+1);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void generarVoucherPDF(HttpServletRequest request, HttpServletResponse response)
            throws IOException, DocumentException {

        // Obtener datos de sesión
        HttpSession session = request.getSession();
        ArrayList<Carrito> carrito = (ArrayList<Carrito>) session.getAttribute("carrito");
        Cliente cliente = (Cliente) session.getAttribute("cliente");
        Pedido pedido = (Pedido) session.getAttribute("pago");
        // Configurar la respuesta
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=voucher.pdf");

        // Crear PDF
        Document document = new Document();
        OutputStream out = response.getOutputStream();
        PdfWriter.getInstance(document, out);
        document.open();

        document.add(new Paragraph("=== VOUCHER DE COMPRA ==="));
        document.add(new Paragraph("Usuario: " + cliente.getNombre() + " " + cliente.getApellidos()));
        document.add(new Paragraph("Celular: " + cliente.getCelular()));
        document.add(new Paragraph("Dirección: " + cliente.getDireccion()));

        PdfPTable tabla = new PdfPTable(4); // 4 columnas
        tabla.setWidthPercentage(100);
        tabla.setSpacingBefore(10f);
        tabla.setSpacingAfter(10f);

        // Encabezados
        tabla.addCell("Producto");
        tabla.addCell("Cantidad");
        tabla.addCell("Precio Unitario");
        tabla.addCell("Total");

        double totalGeneral = 0;
        for (Carrito item : carrito) {
            double subtotal = item.getCantidad() * item.getPrecio();
            totalGeneral += subtotal;

            tabla.addCell(item.getProducto());
            tabla.addCell(String.valueOf(item.getCantidad()));
            tabla.addCell("S/ " + String.format("%.2f", item.getPrecio()));
            tabla.addCell("S/ " + String.format("%.2f", subtotal));
        }
        pedido.setId_cliente(cliente.getId_cliente());
        pedido.setTotal(totalGeneral);
        
        PedidoDao pedidodao = new PedidoDao();
        int idpedido = pedidodao.insertarPedido(pedido);
        
        for (Carrito item : carrito) {
            int cantidad = item.getCantidad();
            int id_producto = item.getId_producto();
            Orden orden = new Orden(id_producto,cantidad,idpedido);
            OrdenDao ordendao = new OrdenDao();
            ordendao.insertarOrden(orden);
        }
        // Fila del total general
        PdfPCell celdaTotal = new PdfPCell(new Paragraph("Total General:"));
        celdaTotal.setColspan(3);
        celdaTotal.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tabla.addCell(celdaTotal);
        tabla.addCell("S/ " + String.format("%.2f", totalGeneral));

        document.add(tabla);

        document.add(new Paragraph("Gracias por su compra."));

        document.close();
        out.close();
    }
}
