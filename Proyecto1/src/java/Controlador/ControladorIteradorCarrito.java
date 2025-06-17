/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Carrito;
import Modelo_Iterador.*;

import java.util.ArrayList;

public class ControladorIteradorCarrito {

    public static ResultadoCarrito procesarCarrito(ArrayList<Carrito> carrito) {
        // Usamos el contenedor definido por el patrón
        ContenedorCarrito coleccion = new CarritoColeccion(carrito);

        // Obtenemos el iterador desde el contenedor
        IteratorCarrito iterator = coleccion.getIterator();

        ArrayList<Carrito> resultado = new ArrayList<>();
        double total = 0;

        while (iterator.hasNext()) {
            Carrito item = (Carrito) iterator.next(); // hacemos un cast porque el tipo es Object
            double subtotal = item.getCantidad() * item.getPrecio();
            total += subtotal;
            resultado.add(item);
        }

        return new ResultadoCarrito(resultado, total);
    }
}
//lo que hace es
//Crea una colección con CarritoColeccion.
//
//Pide el iterador mediante el método getIterator()
//
//Recorre los elementos usando hasNext() y next().
//
//Calcula el subtotal y lo acumula al total.
