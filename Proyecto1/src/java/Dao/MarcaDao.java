
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
    Conexion conexion=Conexion.Obtener_Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    public List listar()
    {
        List<Marca> marcas = new ArrayList();
        String sql="select * from marcas";
        
         
        try
        {
            con = conexion.Iniciar_Conexion();
            
            ps= con.prepareStatement(sql);
            rs=ps.executeQuery(); 
            
            while(rs.next())
            {
                Marca u= new Marca(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5));
                marcas.add(u);
            }
        }
        catch(SQLException e)
        {
            System.out.println("Error en Marcas_DAO-Listar:\n"+e);
        }
        return marcas;
    }
    
    public int agregar(Marca marca)
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
            ps.setString(1, marca.getNombre_marca());
            ps.setString(2, marca.getImg_marca());
            ps.executeUpdate();
         rs = ps.getGeneratedKeys();
        if (rs.next()) {
            idGenerado = rs.getInt(1); // Aquí obtienes el id generado
        }
        } catch (SQLException e) {
            System.out.println("Error en Usuarios_DAO-Agregar:\n" + e);
        } finally {
           
        }

        return idGenerado;
    }
}
