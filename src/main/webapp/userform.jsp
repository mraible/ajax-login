<%@ include file="/taglibs.jsp"%>

<head>
    <title><fmt:message key="userForm.title"/></title>
</head>

<p>Please fill in user's information below:</p>

<form:form commandName="user" method="post" action="userform" onsubmit="return validateUser(this)" id="userForm"
        autocomplete="off">
<form:errors path="*" cssClass="error"/>
<form:hidden path="id"/>
<form:hidden path="version"/>
<table class="detail">
<tr>
    <th><label for="username">* <fmt:message key="user.username"/>:</label></th>
    <td>
        <form:input path="username" id="username"/>
        <form:errors path="username" cssClass="fieldError"/>
    </td>
</tr>
<tr>
    <th><label for="password">* <fmt:message key="user.password"/>:</label></th>
    <td>
        <form:password path="password" id="password" showPassword="true"/>
        <form:errors path="password" cssClass="fieldError"/>
    </td>
</tr>
<tr>
    <th><label for="firstName"><fmt:message key="user.firstName"/>:</label></th>
    <td>
        <form:input path="firstName" id="firstName"/>
        <form:errors path="firstName" cssClass="fieldError"/>
    </td>
</tr>
<tr>
    <th><label for="lastName" class="required"><fmt:message key="user.lastName"/>:</label></th>
    <td>
        <form:input path="lastName" id="lastName"/>
        <form:errors path="lastName" cssClass="fieldError"/>
    </td>
</tr>
<tr>
    <th><label for="email" class="required">* <fmt:message key="user.email"/>:</label></th>
    <td>
        <form:input path="email" id="email"/>
        <form:errors path="email" cssClass="fieldError"/>
    </td>
</tr>
<tr>
    <td></td>
    <td>
        <input type="submit" class="button" name="save" value="Save"/>
      <c:if test="${not empty param.id}">
      <security:authorize ifAllGranted="ROLE_ADMIN">
        <input type="submit" class="button" name="delete" value="Delete"/>
      </security:authorize>
      </c:if>
      	<input type="submit" class="button" name="cancel" value="Cancel" onclick="bCancel=true"/>
    </td>
</tr>
</table>
</form:form>

<script type="text/javascript">
    $('#username').focus();
</script>

<v:javascript formName="user" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value="/scripts/validator.jsp"/>"></script>
