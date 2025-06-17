
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!--(uso de JSTL) en: seccion Usuario -->

<!DOCTYPE html>
<html lang="es">
    <%@ page import="java.util.*, Modelo.Carrito, Modelo.Usuario, Modelo.Producto, Modelo_Iterador.*,
        Controlador.ControladorIteradorCarrito;" %>
    
    <%-- llamando los objetos 'carrito' y 'usuario' desde la sesión --%>

    <%
        ArrayList<Carrito> carrito = (ArrayList<Carrito>) session.getAttribute("carrito");
      
    %>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Carrito de Compras</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="../CSS/header.css" />
        <link rel="stylesheet" href="../CSS/styles.css" />
        <link rel="stylesheet" href="../CSS/carritostyle.css" />
        
    </head>
    <body>
        <!-- Header -->
        <%@ include file="header.jsp" %>
 
        <div class="container2">
            
            <!-- Sección Usuario -->
            <div class="seccion-usuario">
                <h2><i class="fas fa-user"></i> Datos del Usuario</h2>
                <div class="datos-usuario">
                    <c:choose>
                        <c:when test="${not empty cliente}">
                            <p><strong>Usuario:</strong> ${cliente.nombre}</p>
                            <p><strong>Correo:</strong> ${cliente.correo}</p>
                            <p><strong>Celular:</strong> ${cliente.celular}</p>
                            <p><strong>Direccion:</strong> ${cliente.direccion}</p>
                        </c:when>
                        <c:otherwise>
                            <p>Debe iniciar sesión para ver sus datos</p>
                            <a href="login.jsp" class="btn-actualizar">
                                <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- Sección Carrito -->
            <div class="seccion-carrito">
                <h2><i class="fas fa-shopping-cart"></i> Tu Carrito</h2>
                <%
                    if (carrito == null || carrito.isEmpty()) {
                %>
                    <p>El carrito está vacío.</p>
                <%
                    } else {
                %>
                <form action="${pageContext.request.contextPath}/CarritoController" method="post">
                    <input type="hidden" name="accion" value="actualizar">
                    <table>
                        <tr>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Precio Unitario</th>
                            <th>Total</th>
                        </tr>
                       
                        <!--haciendo uso del iterator (claro de manera interna)-->
                        <%
                            ResultadoCarrito resultado = ControladorIteradorCarrito.procesarCarrito(carrito);
                            List<Carrito> carritoItems = resultado.getItems();
                            double total = resultado.getTotal();
                            int i = 0;
                            for (Carrito item : carritoItems) {
                                double subtotal = item.getCantidad() * item.getPrecio();
                        %>
                        <tr>
                            <td><%= item.getProducto() %></td>
                            <td>
                                <input type="number" name="cantidad_<%= i %>"
                                       value="<%= item.getCantidad() %>" min="1" style="width: 70px;">
                                <input type="hidden" name="producto_<%= i %>"
                                       value="<%= item.getProducto() %>">
                            </td>
                            <td>S/ <%= String.format("%.2f", item.getPrecio()) %></td>
                            <td>S/ <%= String.format("%.2f", subtotal) %></td>
                        </tr>
                        <%
                                i++;
                            }
                        %>
                        <tr>
                            <td colspan="3"><strong>Total General:</strong></td>
                            <td><strong>S/ <%= String.format("%.2f", total) %></strong></td>
                        </tr>
                        <input type="hidden" name="size" value="<%= i %>">
                    </table>
                    
                    <div style="display: flex; justify-content: space-between; margin-top: 20px;">
                        <button type="submit" class="btn-actualizar">
                            <i class="fas fa-sync-alt"></i> Actualizar Carrito
                        </button>

                        <a href="#resumenPedido" class="btn-confirmar" style="text-decoration: none;">
                            <i class="fas fa-credit-card"></i> Resumen Pedido
                        </a>
                    </div>
                </form>

                <!-- Modal Resumen -->
                <div id="resumenPedido" class="modal">
                    <a href="#" class="cerrar-modal">&times;</a>
                    <h3>Resumen del Pedido</h3>
                    <table class="tabla-carrito">
                        <tr>
                            <th>Producto</th>
                            <th>Precio Unitario</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                        </tr>
                        <%
                            for (Carrito item : carritoItems) {
                                double subtotal = item.getCantidad() * item.getPrecio();
                        %>
                        <tr>
                            <td><%= item.getProducto() %></td>
                            <td>S/. <%= String.format("%.2f", item.getPrecio()) %></td>
                            <td><%= item.getCantidad() %></td>
                            <td>S/. <%= String.format("%.2f", subtotal) %></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td colspan="3" style="text-align: right;"><strong>Total:</strong></td>
                            <td><strong>S/. <%= String.format("%.2f", total) %></strong></td>
                        </tr>
                    </table>

                    <div class="botones-modal">
                        <a href="#" class="btn-actualizar" style="text-decoration: none" >Seguir Comprando</a>
                        <a href="#opcionesPago" class="btn-confirmar" style="text-decoration: none">
                            <i class="fas fa-credit-card"></i> Confirmar Pedido
                        </a>
                    </div>
                </div>
                <div class="fondo-modal"></div>

                <!-- Modal Métodos de Pago -->
                <div id="opcionesPago" class="modal">
                    <a href="#" class="cerrar-modal">&times;</a>
                    <h3>Selecciona un método de pago</h3>
                    
                    <div class="metodos-pago">
                        <!-- Botón Yape -->
                        <div class="metodo-pago" onclick="mostrarFormulario('formularioYape')">
                            <img src="${pageContext.request.contextPath}/Images/icons/logo_metodopago/yape_logo_nofondo.png" alt="Yape">
                            <p>Yape</p>
                        </div>

                        <!-- Botón Plin -->
                        <div class="metodo-pago" onclick="mostrarFormulario('formularioPlin')">
                            <img src="${pageContext.request.contextPath}/Images/icons/logo_metodopago/plin_logo.png" alt="Plin">
                            <p>Plin</p>
                        </div>

                        <!-- Botón BCP -->
                        <div class="metodo-pago" onclick="mostrarFormulario('formularioBCP')">
                            <img src="${pageContext.request.contextPath}/Images/icons/logo_metodopago/bcp_logo.png" alt="BCP">
                            <p>BCP</p>
                        </div>

                        <!-- Botón Credito -->
                        <div class="metodo-pago" onclick="mostrarFormulario('formularioCredito')">
                            <img src="${pageContext.request.contextPath}/Images/icons/logo_metodopago/credito_logo.jpeg" alt="Credito">
                            <p>Credito</p>
                        </div>
                            
                    </div>
                            
                        <!--formularios:YAPE.PLIN.BCP.CREDITO-->
                        
                <div id="formularioYape" style="display: none; margin-top: 30px;">
                    <h4>Pago por Yape</h4>
                    <p>Escanea el QR y completa el formulario:</p>
                    <div style="display: flex; gap: 20px; align-items: flex-start;">
                        <!-- Columna del formulario -->
                        <div style="flex: 1;">
                            <form action="pagoYape.jsp" method="post">
                                <label>Nombre del titular:</label><br>
                                <input type="text" name="titular" pattern="[A-Za-zÑñ\s]+" required><br><br>
                                <!--Acepta solo números (\d),Hasta 8 dígitos, inputmode="numeric" muestra el teclado numérico en móviles-->
                                <label>Número de operación:</label><br>
                                <input type="text" name="nroOperacion" pattern="\d{8}" inputmode="numeric" maxlength="8" placeholder="(8 digitos)"required><br><br>
                                <label>Celular asociado:</label><br>
                                <input type="text" name="celular" pattern="\d{9}" inputmode="numeric" maxlength="9" required><br><br>
                                <label>Dirección de entrega:</label><br>
                                <input type="text" name="direccion" required><br><br>
                                <a href="#compraExitosa" class="btn-confirmar" style="text-decoration: none;">
                                    <i class="fas fa-credit-card"></i> Confirmar Compra
                                </a><br><br>
                                <a href="#resumenPedido" class="btn-actualizar" style="text-decoration: none" >volver al resumen</a>
                                    
                            </form>
                        </div>

                        <!-- Columna de la imagen QR -->
                        <div style="flex: 1; text-align: center;">
                            <img src="../Images/icons/logo_metodopago/metodopago_qr/yape_qr.jpeg" alt="QR Yape" style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.2);">
                            <p style="margin-top: 10px; font-size: 14px;">Escanea con tu app Yape</p>
                        </div>
                    </div>
                </div>
                            
                <div id="formularioPlin" style="display: none;">
                    <h4>Pago por Plin</h4>
                <p>Escanea el QR y completa el formulario:</p>
                <div style="display: flex; gap: 20px; align-items: flex-start;">
                    <!-- Columna del formulario -->
                    <div style="flex: 1;">
                        <form action="pagoPlin.jsp" method="post">
                            <label>Nombre del titular:</label><br>
                                <input type="text" name="titular" pattern="[A-Za-zÑñ\s]+" required><br><br>
                            <!--Acepta solo números (\d),Hasta 8 dígitos, inputmode="numeric" muestra el teclado numérico en móviles-->
                            <label>Número de operación:</label><br>
                                <input type="text" name="nroOperacion" pattern="\d{8}" inputmode="numeric" maxlength="8" placeholder="(8 digitos)"required><br><br>
                            <label>Celular asociado:</label><br>
                                <input type="text" name="celular" pattern="\d{9}" inputmode="numeric" maxlength="9" required><br><br>
                            <label>Dirección de entrega:</label><br>
                                <input type="text" name="direccion" required><br><br>
                            <a href="#compraExitosa" class="btn-confirmar" style="text-decoration: none;">
                                    <i class="fas fa-credit-card"></i> Confirmar Compra
                                </a><br><br>
                                <a href="#resumenPedido" class="btn-actualizar" style="text-decoration: none" >volver al resumen</a>
                                 
                        </form>
                    </div>

                    <!-- Columna de la imagen QR -->
                    <div style="flex: 1; text-align: center;">
                        <img src="../Images/icons/logo_metodopago/metodopago_qr/plin_qr.jpg" alt="QR Plin" style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.2);">
                        <p style="margin-top: 10px; font-size: 14px;">Escanea con tu app Plin</p>
                    </div>
                </div>

                </div>

                <div id="formularioBCP" style="display: none;">
                    <!-- Aquí va el formulario BCP -->
                    <h4>Transferencia BCP</h4>
                <p>Datos para transferencia: <strong>CCI 002-123456789012345678</strong></p>
                <form action="pagoBCP.jsp" method="post">
                    
                    <label>Nombre del titular:</label><br>
                        <input type="text" name="titular" pattern="[A-Za-zÑñ\s]+" required><br><br>
                    <label>Número de tarjeta:</label><br>
                        <input type="text" name="numeroTarjeta" maxlength="19" placeholder="XXXX-XXXX-XXXX-XXXX" required><br><br>
                    <label>Número de operación:</label><br>
                        <input type="text" name="nroOperacion" pattern="\d{8}" required><br><br>
                    <label>Dirección de entrega:</label><br>
                        <input type="text" name="direccion" required><br><br>
                    <a href="#compraExitosa" class="btn-confirmar" style="text-decoration: none;">
                                    <i class="fas fa-credit-card"></i> Confirmar Compra
                                </a><br><br>
                                <a href="#resumenPedido" class="btn-actualizar" style="text-decoration: none" >volver al resumen</a>
                                        
                </form>

                </div>

                <div id="formularioCredito" style="display: none;">
                    <!-- Aquí va el formulario Credito -->
                    <h4>Pago a Credito</h4>
                <form action="pagoCredito.jsp" method="post">
                    
                    <label>Nombre del titular:</label><br>
                    <input type="text" name="titular" pattern="[A-Za-zÑñ\s]+" required><br><br>

                    <label>Número de tarjeta:</label><br>
                    <input type="text" name="numeroTarjeta" maxlength="19" placeholder="XXXX-XXXX-XXXX-XXXX" required><br><br>
                    
                    <label>Fecha de vencimiento (MM/AA):</label><br>
                    <input type="text" name="fechaVencimiento" maxlength="5" placeholder="MM/AA" required><br><br>

                    <label>Código CVV:</label><br>
                    <input type="password" name="cvv" maxlength="4" required><br><br>

                    <label>Dirección de entrega:</label><br>
                    <input type="text" name="direccion" required><br><br>
                    <button type="submit" class="btn-confirmar">
                        <i class="fas fa-credit-card"></i> Confirmar Compra
                        </button><br><br>
                                
                        <a href="#resumenPedido" class="btn-actualizar" style="text-decoration: none" >volver al resumen</a>
                                    
                </form>

                </div>
             
                    
                </div>
                
                <!-- Modal Compra Exitosa -->
                <div id="compraExitosa" class="modal">
                    <a href="#" class="cerrar-modal">&times;</a>
                    <h3 style="text-align: center;">¡Compra Exitosa!</h3>
                    <p style="text-align: center; font-size: 1.1em;">Tu compra se ha realizado correctamente.</p>

                    <div style="text-align: center; margin-top: 20px;">
                       <!--     <a href="ruta/del/voucher.pdf" download class="btn-descargar" style="text-decoration: none;">
                            Descargar Voucher
                        </a>>-->
                    <a href="${pageContext.request.contextPath}/CarritoController?accion=generarPDF" class="btn-descargar" style="text-decoration: none;">
                            Descargar Voucher
                        </a

                    </div>
                </div>

                <div class="fondo-modal"></div>

                <%
                    }
                %>
            </div>

            

        </div>


       <script>
           
function ocultarTodosLosFormularios() {
    const formularios = [
        "formularioYape",
        "formularioPlin",
        "formularioBCP",
        "formularioCredito"
    ];

    formularios.forEach(id => {
        const elemento = document.getElementById(id);
        if (elemento) {
            elemento.style.display = "none";
        }
    });
}

function mostrarFormulario(idFormulario) {
    ocultarTodosLosFormularios();
    const formulario = document.getElementById(idFormulario);
    if (formulario) {
        formulario.style.display = "block";
    }
}

</script>

            <%@ include file="footer.jsp" %>
        
    </body>
</html>