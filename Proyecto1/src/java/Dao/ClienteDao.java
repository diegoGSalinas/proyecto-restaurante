/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;
import configuracion.Conexion;
import Modelo.Cliente;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author dkred
 */
public class ClienteDao {
    Conexion conexion=Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    public int agregar(Cliente cliente) {
        int idGenerado = 0;
        String sql = "insert into cliente (nombre, apellidos, celular, correo, id_usuario,direccion,latitud,longitud) values (?, ?, ?, ?, ?,?,?,?)";

        try {
            con = conexion.Iniciar_Conexion();
            
            ps= con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellidos());
            ps.setString(3, cliente.getCelular());
            ps.setString(4, cliente.getCorreo());
            ps.setInt(5, cliente.getId_usuario());
            ps.setString(6, cliente.getDireccion());
            ps.setString(7, cliente.getLatitud());
            ps.setString(8, cliente.getLongitud());
            System.out.println("PreparedStatement: " + ps.toString());
            ps.executeUpdate();
            System.out.println("hola-----------------------:\n");
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idGenerado = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println("Error en ClienteDAO - agregar:\n" + e);
        } finally {
            cerrarRecursos();
        }

        return idGenerado;
    }

    // Método para listar todos los clientes
    public List<Cliente> listar() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente";

        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setId_cliente(rs.getInt("id_cliente"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellidos(rs.getString("apellidos"));
                cliente.setCelular(rs.getString("celular"));
                cliente.setCorreo(rs.getString("correo"));
                cliente.setId_usuario(rs.getInt("id_usuario"));
                lista.add(cliente);
            }

        } catch (SQLException e) {
            System.out.println("Error en ClienteDAO - listar:\n" + e);
        } finally {
            cerrarRecursos();
        }

        return lista;
    }
    public Cliente buscar_por_id_user(int id_user) {
        
        String sql = "SELECT * FROM cliente where id_usuario = '"+id_user+"'";
        Cliente cliente = new Cliente();
        try {
            con = conexion.Iniciar_Conexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                cliente.setId_cliente(rs.getInt("id_cliente"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellidos(rs.getString("apellidos"));
                cliente.setCelular(rs.getString("celular"));
                cliente.setCorreo(rs.getString("correo"));
                cliente.setId_usuario(rs.getInt("id_usuario"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setLatitud(rs.getString("latitud"));
                cliente.setLongitud(rs.getString("longitud"));
            }

        } catch (SQLException e) {
            System.out.println("Error en ClienteDAO - buscar_by_id:\n" + e);
        } finally {
            cerrarRecursos();
        }

        return cliente;
    }
     private void cerrarRecursos() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error cerrando recursos:\n" + e);
        }
    }

}
