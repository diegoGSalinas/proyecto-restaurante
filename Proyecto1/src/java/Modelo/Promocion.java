/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author dkred
 */
public class Promocion {
    private int id_promocion;
    private String nombre_promocion;
    private String descuento;
    public Promocion(){
        
    }
    public Promocion(int id_promocion, String nombre_promocion, String descuento){
        this.id_promocion = id_promocion;
        this.nombre_promocion = nombre_promocion;
        this.descuento = descuento;
    }
    public int getIdPromocion(){
        return id_promocion;
    }
    public String getNombrePromocion(){
        return nombre_promocion;
    }
    public String getDescuento(){
        return descuento;
    }
    public void setIdPromocion(int id_promocion){
          this.id_promocion = id_promocion;
    }
    public void setNombrePromocion(String nombre_promocion){
          this.nombre_promocion = nombre_promocion;
    }
    public void setDescuento(String descuento){
          this.descuento = descuento;
    } 
    
}
