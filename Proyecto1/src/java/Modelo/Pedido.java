/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author dkred
 */
public class Pedido {

    private int id_pedido;
    private double total;
    private int id_cliente;
    private String metodo_pago;
    private String nombre_pago;
    private String direccion_pago;
    private String telefono_pago;
    private String estado;
    private String motivo;
     
    // Constructor vacío
    public Pedido() {
    }

    // Constructor completo
    public Pedido(double total, int id_cliente, String metodo_pago, String nombre_pago, String direccion_pago, String telefono_pago,String estado) {
        
        this.total = total;
        this.id_cliente = id_cliente;
        this.metodo_pago =metodo_pago;
        this.nombre_pago =nombre_pago;
        this.direccion_pago = direccion_pago;
        this.telefono_pago = telefono_pago;
        this.estado = estado;
    }

    // Getters y Setters
    public int getId_pedido() {
        return id_pedido;
    }

    public void setId_pedido(int id_pedido) {
        this.id_pedido = id_pedido;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }
    public String getMetodo_pago() {
        return metodo_pago;
    }

    public void setMetodo_pago(String metodo_pago) {
        this.metodo_pago = metodo_pago;
    }

    public String getNombre_pago() {
        return nombre_pago;
    }

    public void setNombre_pago(String nombre_pago) {
        this.nombre_pago = nombre_pago;
    }

    public String getDireccion_pago() {
        return direccion_pago;
    }

    public void setDireccion_pago(String direccion_pago) {
        this.direccion_pago = direccion_pago;
    }

    public String getTelefono_pago() {
        return telefono_pago;
    }

    public void setTelefono_pago(String telefono_pago) {
        this.telefono_pago = telefono_pago;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    public String getMotivo()
    {
        return this.motivo;
    }
    public void setMotivo(String motivo)
    {
        this.motivo = motivo;
    }
    
}
