package Dao;

import configuracion.Conexion;
import Modelo.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dkred
 */
public class ProductoDao {

    Conexion conexion = Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public List listar() {
        List<Producto> productos = new ArrayList();
        String sql = "select * from producto order by id_categoria";

        try {
            con = conexion.Iniciar_Conexion();

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Producto p = new Producto(
                        rs.getInt("id_producto"),
                        rs.getString("nombre_producto"),
                        rs.getString("descripcion_producto"),
                        rs.getDouble("precio_producto"),
                        rs.getString("img_producto"),
                        rs.getInt("id_categoria"),
                        rs.getInt("id_marca")
                );
                productos.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error en Productos_DAO-Listar:\n" + e);
        }
        return productos;
    }

    public List listar_por_marca(int id_marca) {
        List<Producto> productos = new ArrayList();
        String sql = "select * from producto where id_marca = " + id_marca + " order by id_categoria";

        try {
            con = conexion.Iniciar_Conexion();

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Producto p = new Producto(
                        rs.getInt("id_producto"),
                        rs.getString("nombre_producto"),
                        rs.getString("descripcion_producto"),
                        rs.getDouble("precio_producto"),
                        rs.getString("img_producto"),
                        rs.getInt("id_categoria"),
                        rs.getInt("id_marca")
                );
                productos.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error en Productos_DAO-Listar:\n" + e);
        }
        return productos;
    }

    public List listar_por_categoria(int id_categoria) {
        List<Producto> productos = new ArrayList();
        String sql = "select * from producto where id_categoria = " + id_categoria + " order by id_marca";

        try {
            con = conexion.Iniciar_Conexion();

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Producto p = new Producto(
                        rs.getInt("id_producto"),
                        rs.getString("nombre_producto"),
                        rs.getString("descripcion_producto"),
                        rs.getDouble("precio_producto"),
                        rs.getString("img_producto"),
                        rs.getInt("id_categoria"),
                        rs.getInt("id_marca")
                );
                productos.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error en Productos_DAO-Listar:\n" + e);
        }
        return productos;
    }

    public Producto buscar(int id) {
        return obtenerProductoPorId(id);
    }

    public Producto obtenerProductoPorId(int id) {
        Producto p = null;
        String sql = "select * from producto WHERE id_producto= ?";
        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Producto(
                        rs.getInt("id_producto"),
                        rs.getString("nombre_producto"),
                        rs.getString("descripcion_producto"),
                        rs.getDouble("precio_producto"),
                        rs.getString("img_producto"),
                        rs.getInt("id_categoria"),
                        rs.getInt("id_marca")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error en ProductoDao-obtenerProductoPorId: " + e.getMessage());
        }
        return p;
    }

    public boolean agregar(Producto producto) {
        System.out.println("Iniciando inserción del producto...");
        System.out.println("Datos del producto:" + producto);

        String sql = "INSERT INTO producto (nombre_producto, descripcion_producto, precio_producto, "
                + "img_producto, id_categoria, id_marca) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql);

            ps.setString(1, producto.getNombreProducto());
            ps.setString(2, producto.getDescripcionProducto());
            ps.setDouble(3, producto.getPrecioProducto());
            ps.setString(4, producto.getImgProducto());
            ps.setInt(5, producto.getIdCategoria());
            ps.setInt(6, producto.getIdMarca());

            System.out.println("Ejecutando consulta SQL: " + sql);
            System.out.println("Parámetros: " + producto.getNombreProducto() + ", "
                    + producto.getDescripcionProducto() + ", " + producto.getPrecioProducto() + ", "
                    + producto.getImgProducto() + ", " + producto.getIdCategoria() + ", " + producto.getIdMarca());

            int filasAfectadas = ps.executeUpdate();
            System.out.println("Filas afectadas: " + filasAfectadas);

            return filasAfectadas > 0;

        } catch (SQLException e) {
            System.out.println("Error en ProductoDao-agregar: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Producto producto) {

        String sql = "UPDATE producto SET nombre_producto = ?, descripcion_producto = ?, "
                + "precio_producto = ?, img_producto = ?, id_categoria = ?, id_marca = ? "
                + "WHERE id_producto = ?";

        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql);

            ps.setString(1, producto.getNombreProducto());
            ps.setString(2, producto.getDescripcionProducto());
            ps.setDouble(3, producto.getPrecioProducto());
            ps.setString(4, producto.getImgProducto());
            ps.setInt(5, producto.getIdCategoria());
            ps.setInt(6, producto.getIdMarca());
            ps.setInt(7, producto.getIdProducto());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            System.out.println("Error en ProductoDao-actualizar: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {

        String sql = "DELETE FROM producto WHERE id_producto = ?";

        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            System.out.println("Error en ProductoDao-eliminar: " + e.getMessage());
            return false;
        }
    }
}
