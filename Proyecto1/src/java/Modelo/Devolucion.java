/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author dkred
 */
public class Devolucion {
    private int id_devolucion;
    private int id_pedido;
    private int id_cliente;
    private String estado;
    private String motivo;
    public Devolucion(){
        
    }
    
    // Constructor con parámetros
    public Devolucion( int id_pedido, int id_cliente, String estado, String motivo) {
        
        this.id_pedido = id_pedido;
        this.id_cliente = id_cliente;
        this.estado = estado;
        this.motivo = motivo;
    }

    // Getters y Setters
    public int getId_devolucion() {
        return id_devolucion;
    }

    public void setId_devolucion(int id_devolucion) {
        this.id_devolucion = id_devolucion;
    }

    public int getId_pedido() {
        return id_pedido;
    }

    public void setId_pedido(int id_pedido) {
        this.id_pedido = id_pedido;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }
}
