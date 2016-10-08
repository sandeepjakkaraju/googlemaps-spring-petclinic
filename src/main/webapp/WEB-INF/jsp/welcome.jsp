<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<petclinic:layout pageName="home">
    <h2><fmt:message key="welcome"/>&nbsp; &nbsp;  <shiro:principal/> !!</h2>

    <h2>Your Current Location: <div id="address"></div></h2>


    <!--
    <div class="row">
        <div class="col-md-12">
            <spring:url value="/resources/images/pets.png" htmlEscape="true" var="petsImage"/>
            <img class="img-responsive" src="${petsImage}"/>
        </div>
     <div class="row">
        <div class="col-md-12">
         <form action="fileUploadForm.htm" >
         <button type="submit" style="font-face: 'Comic Sans MS'; font-size: larger; color: teal; background-color: #FFFFC0; border: 3pt ridge lightgrey">GO TestUpload page</button>
         </form>
        </div>
     </div>
    </div>

    <p>Click the button to get your coordinates.</p>

    <button onclick="getLocation()">Try It</button>
-->

    <spring:url value="/resources/images/loading.gif" var="load"/>

    <div id="divLoading" style="margin: 0px; padding: 0px; position: fixed; right: 0px; top: 0px; width: 100%; height: 100%; background-color: rgb(102, 102, 102); z-index: 30001; opacity: 0.8;">
        <p style="position: absolute;  top: 50%; left: 45%;">
            <img id = "loading" src = "${load}" alt = "Loading indicator">
        </p>
    </div>

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


        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.watchPosition(showPosition);
            } else {
                x.innerHTML = "Geolocation is not supported by this browser.";}


        }

        function showPosition(position) {
            var latlon = position.coords.latitude + "," + position.coords.longitude;
            xhr.open('GET', "https://maps.googleapis.com/maps/api/geocode/json?latlng="+latlon+"&key=AIzaSyCr1CzYH28_9PEheKHMiZYyRPbmdzz4PgY", true);
            xhr.send();

            xloc.open('GET', "location.do?latlon="+latlon, true);
            xloc.send();


            xhr.onreadystatechange = processRequest;


            var img_url = "https://maps.googleapis.com/maps/api/staticmap?markers=color:red%7Clabel:You%7C"+latlon+"&center="+latlon+"&zoom=17&size=400x300&sensor=false&key=AIzaSyCr1CzYH28_9PEheKHMiZYyRPbmdzz4PgY";

            document.getElementById("map").innerHTML = "<img src='"+img_url+"'>";
            document.getElementById("divLoading").innerHTML = "";


            $("#divLoading").remove();
            $("#loading").remove();
        }

        window.onload = getLocation();


        function processRequest(e) {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var response = JSON.parse(xhr.responseText);

                document.getElementById("address").innerHTML = ""+response.results[0].formatted_address;

            }
        }
    </script>

</petclinic:layout>
