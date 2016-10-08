    <%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>

<petclinic:layout pageName="owners">
    <h2>Owners</h2>

    <datatables:table id="owners" data="${selections}" row="owner"
                      cssClass="table table-striped" pageable="false" info="false" export="pdf">
        <datatables:column title="Name" cssStyle="width: 150px;" display="html">
            <spring:url value="/owners/{ownerId}.html" var="ownerUrl">
                <spring:param name="ownerId" value="${owner.id}"/>
            </spring:url>
            <a href="${fn:escapeXml(ownerUrl)}"><c:out value="${owner.firstName} ${owner.lastName}"/></a>
        </datatables:column>

        <datatables:column title="Name" display="pdf">
            <c:out value="${owner.firstName} ${owner.lastName}"/>
        </datatables:column>
        <datatables:column title="Address" property="address" cssStyle="width: 200px;"/>
        <datatables:column title="City" property="city"/>
        <datatables:column title="Telephone" property="telephone"/>
        <datatables:column title="Pets" cssStyle="width: 100px;">
            <c:forEach var="pet" items="${owner.pets}">
                <c:out value="${pet.name}"/>
            </c:forEach>
        </datatables:column>
        <datatables:column title="Map" cssStyle="width: 150px;" display="html">
            <a href="#" onClick="window.open('https://maps.googleapis.com/maps/api/staticmap?center=${owner.address},${owner.city}&zoom=14&size=400x400&key=AIzaSyCr1CzYH28_9PEheKHMiZYyRPbmdzz4PgY&&markers=size:mid%7Ccolor:red%7Clabel:C%7C${owner.address},${owner.city}')">View Map</a>
        </datatables:column>

        <datatables:export type="pdf" cssClass="btn" cssStyle="height: 25px;"/>
    </datatables:table>
</petclinic:layout>
