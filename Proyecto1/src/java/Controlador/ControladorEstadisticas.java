package Controlador; 

import Dao.ProductoDao;
import Modelo.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@WebServlet("/ControladorEstadisticas")
public class ControladorEstadisticas extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // Obtener productos desde la base de datos usando tu DAO real
    ProductoDao dao = new ProductoDao();
    List<Producto> productos = dao.listar();
    
        //ventas "Realizadas" (productoId, cantidadVendida)
        Map<Integer, Integer> ventaRealizadas = new HashMap<>();
        ventaRealizadas.put(1, 50); 
        ventaRealizadas.put(2, 75); 
        ventaRealizadas.put(3, 30); 
        ventaRealizadas.put(4, 120); 
        ventaRealizadas.put(5, 60); 
        ventaRealizadas.put(6, 40); 
        ventaRealizadas.put(7, 90); 
        ventaRealizadas.put(8, 25); 

        // --- CÁLCULO DE ESTADÍSTICAS ---

        // 1. Productos más comprados (ordenados de mayor a menor)
        List<Map.Entry<Integer, Integer>> productosMasCompradosEntries = ventaRealizadas.entrySet().stream()
                .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
                .collect(Collectors.toList());

        List<String> nombresMasComprados = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : productosMasCompradosEntries) {
            Producto p = productos.stream()
                            .filter(prod -> prod.getIdProducto() == entry.getKey())
                            .findFirst()
                            .orElse(null);
            if (p != null) {
                nombresMasComprados.add(p.getNombreProducto() + " (" + entry.getValue() + " unidades)");
            }
        }
        request.setAttribute("productosMasComprados", nombresMasComprados);

        // 2. Productos menos comprados (ordenados de menor a mayor)
        List<Map.Entry<Integer, Integer>> productosMenosCompradosEntries = ventaRealizadas.entrySet().stream()
                .sorted(Map.Entry.comparingByValue())
                .collect(Collectors.toList());

        List<String> nombresMenosComprados = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : productosMenosCompradosEntries) {
            Producto p = productos.stream()
                            .filter(prod -> prod.getIdProducto() == entry.getKey())
                            .findFirst()
                            .orElse(null);
            if (p != null) {
                nombresMenosComprados.add(p.getNombreProducto() + " (" + entry.getValue() + " unidades)");
            }
        }
        request.setAttribute("productosMenosComprados", nombresMenosComprados);

        // 3. Total de ventas por producto (detallado) y cálculo de ingresos totales
        List<String> ventasPorProducto = new ArrayList<>();
        double ingresosTotales = 0.0;
        for (Producto p : productos) {
            int cantidadVendida = ventaRealizadas.getOrDefault(p.getIdProducto(), 0);
            double ingresoPorProducto = cantidadVendida * p.getPrecioProducto();
            ventasPorProducto.add(p.getNombreProducto() + ": " + cantidadVendida + " unidades (S/ " + String.format("%.2f", ingresoPorProducto) + ")");
            ingresosTotales += ingresoPorProducto;
        }
        request.setAttribute("ventasPorProducto", ventasPorProducto);
        request.setAttribute("ingresosTotales", String.format("%.2f", ingresosTotales));

        // 4. Conteo de productos por categoría
        Map<Integer, Long> conteoPorCategoria = productos.stream()
                .collect(Collectors.groupingBy(Producto::getIdCategoria, Collectors.counting()));
        request.setAttribute("conteoPorCategoria", conteoPorCategoria); 

        // 5. Conteo de productos por marca
        Map<Integer, Long> conteoPorMarca = productos.stream()
                .collect(Collectors.groupingBy(Producto::getIdMarca, Collectors.counting()));
        request.setAttribute("conteoPorMarca", conteoPorMarca);
        
        request.getRequestDispatcher("JSP/estadisticas.jsp").forward(request, response);
    }
}