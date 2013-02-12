<%@ include file="/taglibs.jsp" %>

<h3>Data Access Failure</h3>
<p>
    <c:out value="${requestScope.exception.message}"/>
</p>

<a href="<c:url value='/'/>">&#171; Home</a>
