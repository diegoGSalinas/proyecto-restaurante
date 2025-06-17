/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;
import configuracion.Conexion;
import Modelo.Categoria;
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
public class CategoriaDao {
     Conexion conexion=Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    public List listar()
    {
        List<Categoria> categorias = new ArrayList();
        String sql="select * from categoria  left join marca_categoria on categoria.id_categoria = marca_categoria.id_categoria ";

        try
        {
            con = conexion.Iniciar_Conexion();
            
            ps= con.prepareStatement(sql);
            rs=ps.executeQuery(); 
            
            while(rs.next())
            {
                Categoria u= new Categoria(rs.getInt(1),rs.getString(2),rs.getString(3));
                categorias.add(u);
            }
        }
        catch(SQLException e)
        {
            System.out.println("Error en Usuarios_DAO-Listar:\n"+e);
        }
        return categorias;
    }
    public List listar_por_marca(int id_marca)
    {
        List<Categoria> categorias = new ArrayList();
        String sql="select * from categoria  left join marca_categoria on categoria.id_categoria = marca_categoria.id_categoria where id_marca = "+id_marca;

        try
        {
            con = conexion.Iniciar_Conexion();
            
            ps= con.prepareStatement(sql);
            rs=ps.executeQuery(); 
            
            while(rs.next())
            {
                Categoria u= new Categoria(rs.getInt(1),rs.getString(2),rs.getString(3));
                categorias.add(u);
            }
        }
        catch(SQLException e)
        {
            System.out.println("Error en Usuarios_DAO-Listar:\n"+e);
        }
        return categorias;
    }
    
    public int agregar(Categoria categoria)
    {   
        int idGenerado = -1;
        String sql="insert into marcas"
                + "(nombre_marca,img_marca)"
                + "values "
                + "(?,?)";
        try
        {
            con=conexion.Iniciar_Conexion();
            ps=con.prepareStatement(sql);
            ps.setString(1, categoria.getNombre_categoria());
            ps.setString(2, categoria.getDescripcion());
            ps.executeUpdate();
         rs = ps.getGeneratedKeys();
        if (rs.next()) {
            idGenerado = rs.getInt(1); // Aquí obtienes el id generado
        }
        } catch (SQLException e) {
            System.out.println("Error en Usuarios_DAO-Agregar:\n" + e);
        } finally {
            // Aquí podrías cerrar ps, rs y con si los estás manejando manualmente
        }

        return idGenerado;
    }
}
