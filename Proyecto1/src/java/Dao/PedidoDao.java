/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;
import configuracion.Conexion;
import Modelo.Pedido;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author dkred
 */
public class PedidoDao {
   Conexion conexion=Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public int insertarPedido(Pedido pedido) {
        int idGenerado = 0;
        String sql = "INSERT INTO pedido (total, id_cliente,metodo_pago,nombre_pago,direccion_pago,telefono_pago,estado) VALUES (?, ?,?,?,?,?,?)";

         try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setDouble(1, pedido.getTotal());
            ps.setInt(2, pedido.getId_cliente());
            ps.setString(3, pedido.getMetodo_pago());
            ps.setString(4, pedido.getNombre_pago());
            ps.setString(5, pedido.getDireccion_pago());
            ps.setString(6, pedido.getTelefono_pago());
            ps.setString(7, pedido.getEstado());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idGenerado = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return idGenerado; // Devuelve el ID del nuevo pedido
    }
    public boolean modificarEstado(int id_pedido,String estado)
    {
        
        String sql = "UPDATE pedido SET estado = ? WHERE id_pedido = ?";

        try {
              con = conexion.Iniciar_Conexion();
              ps = con.prepareStatement(sql);

              ps.setString(1, estado);
              ps.setInt(2,id_pedido);

              int filasAfectadas = ps.executeUpdate();
              return filasAfectadas > 0;

          } catch (SQLException e) {
              System.out.println("Error en Actualizar pedido: " + e.getMessage());
              return false;
          }
    }
    public List busquedaporIdCliente(int id_cliente){
        List<Pedido> pedidos = new ArrayList();
        String sql = "select * from pedido where id_cliente = " + id_cliente + " order by id_pedido";

        try {
            con = conexion.Iniciar_Conexion();

            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Pedido p = new Pedido(
                        rs.getInt("total"),
                        rs.getInt("id_cliente"),
                        rs.getString("metodo_pago"),
                        rs.getString("nombre_pago"),
                        rs.getString("direccion_pago"),
                        rs.getString("telefono_pago"),
                        rs.getString("estado")
                );
                p.setId_pedido(rs.getInt("id_pedido"));
                pedidos.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error en Productos_DAO-Listar:\n" + e);
        }
        return pedidos;
    }
}
