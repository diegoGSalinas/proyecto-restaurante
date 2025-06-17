/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author dkred
 */
public class PromoProducto {

    private int id_producto;
    private int id_promocion;

    public PromoProducto() {

    }

    public PromoProducto(int id_promocion, int id_producto) {
        this.id_promocion = id_promocion;
        this.id_producto = id_producto;
    }

    public int getIdPromocion() {
        return id_promocion;
    }

    public int getIdProducto() {
        return id_producto;
    }

    public void setIdPromocion(int id_promocion) {
        this.id_promocion = id_promocion;
    }

    public void setIdProducto(int id_producto) {
        this.id_producto = id_producto;
    }

}
