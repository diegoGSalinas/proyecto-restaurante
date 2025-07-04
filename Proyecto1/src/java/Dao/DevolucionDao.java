/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;
import configuracion.Conexion;
import Modelo.Devolucion;
import java.sql.Connection;
import java.sql.Statement;
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
public class DevolucionDao {
     Conexion conexion=Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
     public boolean insertarDevolucion(Devolucion devolucion) {
        String sql = "INSERT INTO devoluciones (id_pedido, motivo) VALUES (?, ?)";

        try {
            con = conexion.Iniciar_Conexion();
            ps= con.prepareStatement(sql);
            ps.setInt(1, devolucion.getId_pedido());
            ps.setString(2, devolucion.getMotivo());
           
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }
}
