/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// Modelo/CarritoColeccion.java
package Modelo_Iterador;

import Modelo.Carrito;
import Modelo_Iterador.ContenedorCarrito;
import Modelo_Iterador.IteratorCarrito;
import java.util.ArrayList;

public class CarritoColeccion implements ContenedorCarrito {
    private ArrayList<Carrito> items;

    public CarritoColeccion(ArrayList<Carrito> items) {
        this.items = items;
    }

    public ArrayList<Carrito> getItems() {
        return items;
    }

    @Override
    public IteratorCarrito getIterator() {
        return new CarritoIterator();
    }

    private class CarritoIterator implements IteratorCarrito {
        int index = 0;

        @Override
        public boolean hasNext() {
            return index < items.size();
        }

        @Override
        public Object next() {
            if (this.hasNext()) {
                return items.get(index++);
            }
            return null;
        }
    }
}
