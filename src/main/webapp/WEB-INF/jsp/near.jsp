<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<petclinic:layout pageName="home">

    <spring:url value="/resources/images/loading.gif" var="load"/>


    <div id="divLoading" style="margin: 0px; padding: 0px; position: fixed; right: 0px; top: 0px; width: 100%; height: 100%; background-color: rgb(102, 102, 102); z-index: 30001; opacity: 0.8;">
        <p style="position: absolute;  top: 50%; left: 45%;">
            <img id = "loading" src = "${load}" alt = "Loading indicator">
        </p>
    </div>

    <h2>Your Nearest ATM: <div id="address"></div></h2>

    <STYLE>
        #loading {
            POSITION: ABSOLUTE;
            TOP: 50%;
            LEFT: 50%;
            WIDTH: 100PX;
            HEIGHT: 100PX;
            /* 1/2 OF THE HEIGHT AND WIDTH OF THE ACTUAL GIF */
            MARGIN: -16PX 0 0 -16PX;
            Z-INDEX: 100;
        }
    </STYLE>


    <p id="demo"></p>
    <div id="map"></div>

    <script>
        var x = document.getElementById("demo");
        var xhr = new XMLHttpRequest();
        var xloc = new XMLHttpRequest();
        var latlon;

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.watchPosition(showPosition);
            } else {
                x.innerHTML = "Geolocation is not supported by this browser.";}


        }

        function showPosition(position) {
            latlon = position.coords.latitude + "," + position.coords.longitude;
            xhr.open('GET', "https://crossorigin.me/https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+latlon+"&radius=500&type=atm&key=AIzaSyCr1CzYH28_9PEheKHMiZYyRPbmdzz4PgY", true);
            xhr.send();

                    xhr.onreadystatechange = processRequest;

            $("#divLoading").remove();
            $("#loading").remove();
        }

        window.onload = getLocation();


        function processRequest(e) {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var response = JSON.parse(xhr.responseText);

                document.getElementById("address").innerHTML = ""+response.results[0].name;


                var img_url = "https://crossorigin.me/https://maps.googleapis.com/maps/api/staticmap?markers=color:red%7Clabel:You%7C"+response.results[0].geometry.location.lat+","+response.results[0].geometry.location.lng+"&center="+latlon+"&markers=color:blue%7Clabel:H%7C"+latlon+"&zoom=17&size=400x300&sensor=false&key=AIzaSyCr1CzYH28_9PEheKHMiZYyRPbmdzz4PgY";

                document.getElementById("map").innerHTML = "<img src='"+img_url+"'>";

            }
        }
    </script>

</petclinic:layout>
