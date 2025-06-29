package Dao;

import configuracion.Conexion;
import Modelo.Marca;
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
public class MarcaDao {

    Conexion conexion = Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public List listar() {
        List<Marca> marcas = new ArrayList();
        String sql = "select * from marcas";

        try {
            con = conexion.Iniciar_Conexion();

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Marca u = new Marca(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                marcas.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error en Marcas_DAO-Listar:\n" + e);
        }
        return marcas;
    }

    public int agregar(Marca marca) throws SQLException {
        int idGenerado = -1;
        String sql = "insert into marcas"
                + "(nombre_marca,img_marca,latitud,longitud)"
                + "values "
                + "(?,?,?,?)";
        try {
            con = conexion.Iniciar_Conexion();
            if (con == null) {
                throw new SQLException("No se pudo establecer conexión con la base de datos");
            }

            ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, marca.getNombre_marca());
            ps.setString(2, marca.getImg_marca());
            ps.setString(3, marca.getLatitud());
            ps.setString(4, marca.getLongitud());

            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    idGenerado = rs.getInt(1);
                } else {
                    throw new SQLException("No se pudo obtener el ID generado");
                }
            } else {
                throw new SQLException("No se insertaron filas en la base de datos");
            }
        } catch (SQLException e) {
            System.out.println("Error en Marcas_DAO-Agregar:\n" + e.getMessage());
            throw e; // Propagamos el error para que el controlador lo maneje
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos:\n" + e.getMessage());
            }
        }

        return idGenerado;
    }

    public Marca obtenerPorId(int id) {
        Marca marca = null;
        String sql = "SELECT * FROM marcas WHERE id_marca = ?";

        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                marca = new Marca(
                        rs.getInt("id_marca"),
                        rs.getString("nombre_marca"),
                        rs.getString("img_marca"),
                        rs.getString("latitud"),
                        rs.getString("longitud")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error en Marcas_DAO-obtenerPorId:\n" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos:\n" + e);
            }
        }
        return marca;
    }

    public int actualizar(Marca marca) throws SQLException {
        int r = 0;
        String sql = "update marcas set nombre_marca=?, img_marca=?, latitud=?, longitud=? where id_marca=?";
        System.out.println("Actualizando marca con ID: " + marca.getId_marca());
        System.out.println("Datos: " + marca.getNombre_marca() + ", " + marca.getImg_marca() + ", " + marca.getLatitud() + ", " + marca.getLongitud());

        con = conexion.Iniciar_Conexion();
        if (con == null) {
            throw new SQLException("No se pudo establecer conexión con la base de datos");
        }

        System.out.println("Conexión exitosa a la base de datos");
        ps = con.prepareStatement(sql);
        ps.setString(1, marca.getNombre_marca());
        ps.setString(2, marca.getImg_marca());
        ps.setString(3, marca.getLatitud());
        ps.setString(4, marca.getLongitud());
        ps.setInt(5, marca.getId_marca());

        int rowsAffected = ps.executeUpdate();
        System.out.println("Filas afectadas: " + rowsAffected);
        r = 1;

        return r;
    }

    public int eliminar(int id) throws SQLException {
        int r = 0;
        String sql = "delete from marcas where id_marca=?";

        con = conexion.Iniciar_Conexion();
        if (con == null) {
            throw new SQLException("No se pudo establecer conexión con la base de datos");
        }

        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
        r = 1;

        return r;
    }
}
