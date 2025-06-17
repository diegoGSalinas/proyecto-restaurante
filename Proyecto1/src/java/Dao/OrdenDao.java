/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;
import configuracion.Conexion;
import Modelo.Orden;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
/**
 *
 * @author dkred
 */
public class OrdenDao {
    Conexion conexion=Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public boolean insertarOrden(Orden orden) {
        String sql = "INSERT INTO orden (id_producto, cantidad, id_pedido) VALUES (?, ?, ?)";
        boolean exito = false;

        try {
            con = conexion.Iniciar_Conexion();
            ps= con.prepareStatement(sql);
            ps.setInt(1, orden.getId_producto());
            ps.setInt(2, orden.getCantidad());
            ps.setInt(3, orden.getId_pedido());
            ps.executeUpdate();
            exito = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exito;
    }
}