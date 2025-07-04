/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author dkred
 */
public class Orden {

    private int id_orden;
    private int id_producto;
    private int cantidad;
    private int id_pedido;

    // Constructor vacío
    public Orden() {
    }

    // Constructor completo
    public Orden( int id_producto, int cantidad, int id_pedido) {
        
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.id_pedido = id_pedido;
    }

    // Getters y Setters
    public int getId_orden() {
        return id_orden;
    }

    public void setId_orden(int id_orden) {
        this.id_orden = id_orden;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getId_pedido() {
        return id_pedido;
    }

    public void setId_pedido(int id_pedido) {
        this.id_pedido = id_pedido;
    }
}
