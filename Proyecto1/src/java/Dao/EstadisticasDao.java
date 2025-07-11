/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import configuracion.Conexion; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.HashMap; // Necesario para obtenerCantidadVendidaPorProducto

// DAO para obtener estadísticas de la base de datos
public class EstadisticasDao {

    // Método auxiliar para obtener la conexión usando tu clase Conexion
    private Connection getConnection() throws SQLException {
        // Obtiene una instancia de tu clase Conexion y luego inicia la conexión
        return Conexion.Obtener_Conexion().Iniciar_Conexion();
    }

    // Obtiene los productos más pedidos y su cantidad total
    public Map<String, Integer> obtenerProductosMasPedidos() {
        Map<String, Integer> productosMasPedidos = new LinkedHashMap<>();
        String sql = "SELECT p.nombre_producto, SUM(o.cantidad) AS total_cantidad_pedida " +
                     "FROM producto AS p " +
                     "JOIN orden AS o ON p.id_producto = o.id_producto " +
                     "GROUP BY p.nombre_producto " +
                     "ORDER BY total_cantidad_pedida DESC;";

        try (Connection con = getConnection(); // Usa tu método getConnection
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String nombreProducto = rs.getString("nombre_producto");
                int cantidadPedida = rs.getInt("total_cantidad_pedida");
                productosMasPedidos.put(nombreProducto, cantidadPedida);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener productos más pedidos: " + e.getMessage());
            e.printStackTrace();
        }
        return productosMasPedidos;
    }

    // Obtiene los métodos de pago preferidos y la cantidad de pedidos por cada uno
    public Map<String, Long> obtenerMetodosPagoPreferidos() {
        Map<String, Long> metodosPagoPreferidos = new LinkedHashMap<>();
        String sql = "SELECT metodo_pago, COUNT(id_pedido) AS cantidad_pedidos " +
                     "FROM pedido " +
                     "GROUP BY metodo_pago " +
                     "ORDER BY cantidad_pedidos DESC;";

        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String metodoPago = rs.getString("metodo_pago");
                long cantidadPedidos = rs.getLong("cantidad_pedidos");
                metodosPagoPreferidos.put(metodoPago, cantidadPedidos);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener métodos de pago preferidos: " + e.getMessage());
            e.printStackTrace();
        }
        return metodosPagoPreferidos;
    }

    // Obtiene el número total de pedidos
    public long obtenerNumeroTotalPedidos() {
        long totalPedidos = 0;
        String sql = "SELECT COUNT(id_pedido) AS total_pedidos FROM pedido;";

        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalPedidos = rs.getLong("total_pedidos");
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener el número total de pedidos: " + e.getMessage());
            e.printStackTrace();
        }
        return totalPedidos;
    }

    // Método para obtener la cantidad vendida de cada producto (para cálculos de ingresos)
    // Esto es útil si necesitas el mapeo directo de id_producto a cantidad vendida desde la DB
    public Map<Integer, Integer> obtenerCantidadVendidaPorProducto() {
        Map<Integer, Integer> ventas = new HashMap<>();
        String sql = "SELECT id_producto, SUM(cantidad) AS cantidad_total " +
                     "FROM orden " +
                     "GROUP BY id_producto;";

        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ventas.put(rs.getInt("id_producto"), rs.getInt("cantidad_total"));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener cantidad vendida por producto: " + e.getMessage());
            e.printStackTrace();
        }
        return ventas;
    }
}