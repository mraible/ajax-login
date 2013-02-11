<%@ include file="/taglibs.jsp"%>

<head>
    <title><fmt:message key="userForm.title"/></title>
</head>

<p>Please fill in user's information below:</p>

<spring:bind path="user.*">
    <c:if test="${not empty status.errorMessages}">
        <div class="alert alert-error fade in">
            <a href="#" data-dismiss="alert" class="close">&times;</a>
            <c:forEach var="error" items="${status.errorMessages}">
                <c:out value="${error}" escapeXml="false"/><br/>
            </c:forEach>
        </div>
    </c:if>
</spring:bind>

<form:form commandName="user" method="post" action="userform" autocomplete="off"
           onsubmit="return validateUser(this)" id="userForm" cssClass="well form-horizontal">
<form:hidden path="id"/>
<form:hidden path="version"/>

    <spring:bind path="user.username">
    <div class="control-group${(not empty status.errorMessage) ? ' error' : ''}">
    </spring:bind>
        <label for="username" class="control-label">* <fmt:message key="user.username"/>:</label>
        <div class="controls">
            <form:input path="username" id="username" required="true" autofocus="true"/>
            <form:errors path="username" cssClass="help-inline"/>
        </div>
    </div>
    <spring:bind path="user.password">
    <div class="control-group${(not empty status.errorMessage) ? ' error' : ''}">
    </spring:bind>
        <label for="password" class="control-label">* <fmt:message key="user.password"/>:</label>
        <div class="controls">
            <form:password path="password" id="password" showPassword="true" required="true"/>
            <form:errors path="password" cssClass="help-inline"/>
        </div>
    </div>
    <spring:bind path="user.firstName">
    <div class="control-group${(not empty status.errorMessage) ? ' error' : ''}">
    </spring:bind>
        <label for="firstName" class="control-label"><fmt:message key="user.firstName"/>:</label>
        <div class="controls">
            <form:input path="firstName" id="firstName"/>
            <form:errors path="firstName" cssClass="help-inline"/>
        </div>
    </div>
    <spring:bind path="user.lastName">
    <div class="control-group${(not empty status.errorMessage) ? ' error' : ''}">
    </spring:bind>
        <label for="lastName" class="control-label"><fmt:message key="user.lastName"/>:</label>
        <div class="controls">
            <form:input path="lastName" id="lastName"/>
            <form:errors path="lastName" cssClass="help-inline"/>
        </div>
    </div>
    <spring:bind path="user.email">
    <div class="control-group${(not empty status.errorMessage) ? ' error' : ''}">
    </spring:bind>
        <label for="email" class="control-label">* <fmt:message key="user.email"/>:</label>
        <div class="controls">
            <form:input path="email" id="email" required="true"/>
            <form:errors path="email" cssClass="help-inline"/>
        </div>
    </div>
    <div class="form-actions">
        <button type="submit" class="btn btn-primary" name="save" id="save">
            <i class="icon-ok icon-white"></i> <fmt:message key="button.save"/>
        </button>

        <c:if test="${not empty param.id}">
            <button type="submit" class="btn" name="delete" id="delete">
                <i class="icon-trash"></i> <fmt:message key="button.delete"/>
            </button>
        </c:if>

        <a href="${ctx}/users" class="btn" id="cancel">
            <i class="icon-remove"></i> <fmt:message key="button.cancel"/>
        </a>
    </div>
</form:form>

<v:javascript formName="user" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value="/scripts/validator.jsp"/>"></script>
