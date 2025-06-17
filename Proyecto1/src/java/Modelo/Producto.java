/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author dkred
 */
public class Producto {

    private int idProducto;
    private String nombreProducto;
    private String descripcionProducto;
    private double precioProducto;
    private String imgProducto;
    private int idCategoria;
    private int idMarca;

    public Producto(int idProducto, String nombreProducto, String descripcionProducto,
            double precioProducto, String imgProducto, int idCategoria, int idMarca) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.precioProducto = precioProducto;
        this.imgProducto = imgProducto;
        this.idCategoria = idCategoria;
        this.idMarca = idMarca;

    }

    public int getIdProducto() {
        return idProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public String getDescripcionProducto() {
        return descripcionProducto;
    }

    public double getPrecioProducto() {
        return precioProducto;
    }

    public String getImgProducto() {
        return imgProducto;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public int getIdMarca() {
        return idMarca;
    }

    // Setters
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public void setDescripcionProducto(String descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }

    public void setPrecioProducto(double precioProducto) {
        this.precioProducto = precioProducto;
    }

    public void setImgProducto(String imgProducto) {
        this.imgProducto = imgProducto;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    @Override
    public String toString() {
        return "Producto{"
                + "idProducto=" + idProducto
                + ", nombreProducto='" + nombreProducto + '\''
                + ", descripcionProducto='" + descripcionProducto + '\''
                + ", precioProducto=" + precioProducto
                + ", imgProducto='" + imgProducto + '\''
                + ", idCategoria=" + idCategoria
                + ", idMarca=" + idMarca
                + '}';
    }
}
