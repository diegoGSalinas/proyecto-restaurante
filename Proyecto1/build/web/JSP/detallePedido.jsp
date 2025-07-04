<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vista de Pedido</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productosAdm.css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </head>
        <style>            
         @media (max-width: 600px) {
           .icon-container {
                text-align: center;
                margin: 20px 0;
                left: 15%!important;
                position: fixed;
                z-index: 7000;
                margin-top: 70px!important;
            }
           .navbar-toggler {
                border-color: white!important; /* Cambia el color del borde */
            }

            .navbar-toggler-iconn {
                background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' height='30' width='30' viewBox='0 0 30 30'%3E%3Cpath stroke='white' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")!important;
            }

        }     
        body {
            height: auto;
            display: flex;
            flex-direction: column;
        }
        .map-container {
            flex: 1;
            position: relative;
        }
        .seleccionado
        {
            background-color: white;
            padding: 5px;
            border-radius: 20px;
            border-style: double;
        }
        #map {
            width: 100%;
            height: 90vh;
        }
        .icon-container {
            background: #412d13d6;
            padding: 8px;
            border-radius: 20px;
            border-style: outset;
            text-align: center;
            margin: 20px 0;
            left: 40%;
            position: fixed;
            z-index: 7000;
            margin-top: 100px;
        }
        .icon-container i {
            font-size: 2rem;
            margin: 0 15px;
            color: #007bff;
            cursor: pointer;
            
        }

    </style>
    <body>
           <%@ include file="header.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h2>Pedido</h2>
                    <table class="table ">
                        <thead>
                          <tr>
                            <th scope="col">#</th>
                            <th scope="col">Producto</th>
                            <th scope="col">Precio</th>
                          </tr>
                        </thead>
                        <tbody>
                             <c:set var="contador" value="1" />
                             <c:forEach var="pedido" items="${listas}">
                          <tr>
                            <th scope="row"><c:out value="${contador}" /></th>
                            <td>${pedido[0]}</td>
                            <td>${pedido[1]}</td>
                          </tr>
                            <c:set var="contador" value="${contador + 1}" />
                           </c:forEach>
                        </tbody>
                      </table>
                </div>
                <div class="col-md-6">   
                    <div class="map-container">
                          <div id="map" style="height: 800px;"></div>
                    </div>
                         
                </div>
            </div>
        </div>
    </body>
    <c:set var="primerPedido" value="${listas[0]}" />

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCBIO2xriYgqPLWW2hnlwCxZNirRtUQ6lQ&callback=initMap">
</script>
  <script>
    const destinoPedido = {
        lat: ${primerPedido[2]},
        lng: ${primerPedido[3]}
    };

    let map, directionsService, directionsRenderer, infoWindow;

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: { lat: destinoPedido.lat, lng: destinoPedido.lng }
        });

        directionsService = new google.maps.DirectionsService();
        directionsRenderer = new google.maps.DirectionsRenderer();
        directionsRenderer.setMap(map);

        infoWindow = new google.maps.InfoWindow();

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                position => {
                    const userPos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };

                    new google.maps.Marker({
                        position: userPos,
                        map: map,
                        title: 'Tu ubicación actual'
                    });

                    const destinationMarker = new google.maps.Marker({
                        position: destinoPedido,
                        map: map,
                        title: 'Destino del Pedido'
                    });

                    directionsService.route({
                        origin: userPos,
                        destination: destinoPedido,
                        travelMode: google.maps.TravelMode.DRIVING
                    }, (response, status) => {
                        if (status === 'OK') {
                            directionsRenderer.setDirections(response);
                        } else {
                            console.error('Error al calcular la ruta: ' + status);
                        }
                    });

                    infoWindow.setContent('Destino del Pedido: ' + destinoPedido.lat + ', ' + destinoPedido.lng);
                    infoWindow.open(map, destinationMarker);
                },
                () => {
                    document.getElementById('error').textContent = 'No se pudo obtener tu ubicación.';
                }
            );
        } else {
            document.getElementById('error').textContent = 'Tu navegador no soporta geolocalización.';
        }
    }
</script>
</html>
