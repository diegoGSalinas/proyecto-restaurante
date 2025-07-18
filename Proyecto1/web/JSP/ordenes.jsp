<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración de Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productosAdm.css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </head>
    
     
    <body> 
        <%@ include file="header.jsp" %>
        <div  class="container" style="margin-top: 50px;">
            <div class="card">
                 <div class="card-body">
                   <h5 class="card-title">Ordenes</h5>
                 </div>
                <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">Total</th>
                        <th scope="col">Estado</th>
                        <th scope="col">Opciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="pedido" items="${listaPedidos}">
                      <tr>
                        <th scope="row">${pedido.id_pedido}</th>
                        <td>S/ ${pedido.total}</td>
                        <td>${pedido.estado}</td>
                        <td> <c:if test="${pedido.estado != 'DEVOLUCION_FINALIZADA' && pedido.estado != 'FINALIZADO'}">
                            <form action="${pageContext.request.contextPath}/controladorOrden" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${pedido.id_pedido}" />
                                
                                 <button type="submit" class="btn btn-primary" name="accion" 
                                    value="mapa" >
                                 <i class="fa fa-search"></i>
                                 </button>
                             </form>
                                
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalReembolso" data-id="${pedido.id_pedido}"> <i class="fa fa-trash"></i></button></td>
                            </c:if>
                        </tr>
                      </c:forEach>
                     
                    </tbody>
                  </table>
            </div>
        </div>
        
      <div class="modal fade" id="modalReembolso" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <form action="${pageContext.request.contextPath}/controladorOrden" method="post">
              <input type="hidden" name="accion" value="reembolso" />
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">Motivo del Reembolso</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                <input type="hidden" name="id_pedido" id="modal-id-pedido">
                <div class="mb-3">
                  <label for="motivo" class="form-label">Motivo:</label>
                  <textarea class="form-control" name="motivo" id="motivo" rows="3" required></textarea>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-danger">Enviar</button>
              </div>
            </div>
          </form>
        </div>
      </div>
         <script>
            var modal = document.getElementById('modalReembolso');
            modal.addEventListener('show.bs.modal', function (event) {
              var button = event.relatedTarget;
              var id = button.getAttribute('data-id');
              var input = modal.querySelector('#modal-id-pedido');
              input.value = id;
            });
          </script>  
        <%@ include file="footer.jsp" %>
       
    </body>
     
</html>
