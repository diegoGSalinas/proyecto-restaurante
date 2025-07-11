package Controlador;

import Dao.ProductoDao;
import Dao.EstadisticasDao; // Importa el nuevo DAO
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

        // Instancia de los DAOs
        ProductoDao productoDao = new ProductoDao();
        EstadisticasDao estadisticasDao = new EstadisticasDao();

        // Obtener la lista completa de productos (necesario para mapear IDs a nombres y precios)
        List<Producto> productos = productoDao.listar();

        // --- OBTENER ESTADÍSTICAS DESDE LA BASE DE DATOS ---

        // 1. Productos más comprados (ordenados de mayor a menor)
        Map<String, Integer> productosMasCompradosMap = estadisticasDao.obtenerProductosMasPedidos();
        List<String> productosMasCompradosLabels = new ArrayList<>();
        List<Integer> productosMasCompradosData = new ArrayList<>();
        productosMasCompradosMap.forEach((nombre, cantidad) -> {
            productosMasCompradosLabels.add(nombre);
            productosMasCompradosData.add(cantidad);
        });
        request.setAttribute("productosMasCompradosLabels", productosMasCompradosLabels);
        request.setAttribute("productosMasCompradosData", productosMasCompradosData);

        // También mantenemos la lista formateada para mostrarla como texto
        List<String> nombresMasCompradosFormatted = productosMasCompradosMap.entrySet().stream()
                .map(entry -> entry.getKey() + " (" + entry.getValue() + " unidades)")
                .collect(Collectors.toList());
        request.setAttribute("productosMasComprados", nombresMasCompradosFormatted);


        // 2. Métodos de Pago Preferidos por Clientes
        Map<String, Long> metodosPagoPreferidosMap = estadisticasDao.obtenerMetodosPagoPreferidos();
        List<String> metodosPagoPreferidosLabels = new ArrayList<>();
        List<Long> metodosPagoPreferidosData = new ArrayList<>();
        metodosPagoPreferidosMap.forEach((metodo, cantidad) -> {
            metodosPagoPreferidosLabels.add(metodo);
            metodosPagoPreferidosData.add(cantidad);
        });
        request.setAttribute("metodosPagoPreferidosLabels", metodosPagoPreferidosLabels);
        request.setAttribute("metodosPagoPreferidosData", metodosPagoPreferidosData);

        // También mantenemos la lista formateada para mostrarla como texto
        List<String> metodosPagoListFormatted = metodosPagoPreferidosMap.entrySet().stream()
                .map(entry -> entry.getKey() + ": " + entry.getValue() + " pedidos")
                .collect(Collectors.toList());
        request.setAttribute("metodosPagoPreferidos", metodosPagoListFormatted);


        // 3. Número Total de Pedidos
        long totalPedidos = estadisticasDao.obtenerNumeroTotalPedidos();
        request.setAttribute("totalPedidos", totalPedidos);

        // --- CÁLCULOS ADICIONALES (usando datos reales de la DB) ---

        // Obtener las ventas reales por producto desde la base de datos
        Map<Integer, Integer> ventaRealizadas = estadisticasDao.obtenerCantidadVendidaPorProducto();

        // 4. Productos menos comprados (ordenados de menor a mayor)
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

        // 5. Total de ventas por producto (detallado) y cálculo de ingresos totales
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

        // 6. Conteo de productos por categoría (basado en la lista de productos obtenida)
        Map<Integer, Long> conteoPorCategoria = productos.stream()
                .collect(Collectors.groupingBy(Producto::getIdCategoria, Collectors.counting()));
        request.setAttribute("conteoPorCategoria", conteoPorCategoria);

        // 7. Conteo de productos por marca (basado en la lista de productos obtenida)
        Map<Integer, Long> conteoPorMarca = productos.stream()
                .collect(Collectors.groupingBy(Producto::getIdMarca, Collectors.counting()));
        request.setAttribute("conteoPorMarca", conteoPorMarca);

        // Redireccionar a la página JSP para mostrar las estadísticas
        request.getRequestDispatcher("JSP/estadisticas.jsp").forward(request, response);
    }
}
