/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author dkred
 */
public class Cliente {
    private int id_cliente;
    private String nombre;
    private String apellidos;
    private String celular;
    private String correo;
    private int id_usuario;
    private String direccion;
    private String latitud;
    private String longitud;
    // Constructor vacío
    public Cliente() {
    }

    // Constructor con parámetros
    public Cliente(String nombre, String apellidos, String celular, String correo, int id_usuario,String direccion,String latitud,String longitud) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.celular = celular;
        this.correo = correo;
        this.id_usuario = id_usuario;
        this.direccion = direccion;
        this.latitud = latitud;
        this.longitud = longitud;
    }

    // Getters y Setters
    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }
    public String getLatitud(){
        return latitud;    
    }
    public String getLongitud(){
        return longitud;
    }
    public String getDireccion(){
        return direccion;
    }
    public void setLatitud(String latitud){
        this.latitud = latitud;
    }
    public void setLongitud(String longitud){
        this.longitud = longitud;
    }
    
    public void setDireccion(String direccion){
        this.direccion = direccion;
    }
    
    
}