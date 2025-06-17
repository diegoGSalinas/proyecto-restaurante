/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import configuracion.Conexion;
import Modelo.Pedido;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author dkred
 */
public class PedidoDao {

    Conexion conexion = Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public int insertarPedido(Pedido pedido) {
        int idGenerado = 0;
        String sql = "INSERT INTO pedido (total, id_cliente) VALUES (?, ?)";

        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setDouble(1, pedido.getTotal());
            ps.setInt(2, pedido.getId_cliente());
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
}
