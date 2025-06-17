/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo_Iterador;

import Modelo.Carrito;
import java.util.Iterator;
import java.util.NoSuchElementException;

public class CarritoIterator implements Iterator<Carrito> {
    private Carrito[] carritoArray;
    private int position;
    private int size;

    public CarritoIterator(java.util.List<Carrito> carritoList) {
        this.size = carritoList.size();
        this.carritoArray = carritoList.toArray(new Carrito[0]);
        this.position = 0;
    }

    @Override
    public boolean hasNext() {
        return position < size;
    }

    @Override
    public Carrito next() {
        if (!hasNext()) {
            throw new NoSuchElementException("No hay más elementos en el carrito");
        }
        return carritoArray[position++];
    }
}