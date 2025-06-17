/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo_Iterador;

import Modelo.Carrito;
import java.util.List;

public class ResultadoCarrito {
    private List<Carrito> items;
    private double total;

    public ResultadoCarrito(List<Carrito> items, double total) {
        this.items = items;
        this.total = total;
    }

    public List<Carrito> getItems() {
        return items;
    }

    public double getTotal() {
        return total;
    }
}
