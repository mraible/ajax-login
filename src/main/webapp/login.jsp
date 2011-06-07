<%@ include file="/taglibs.jsp" %>

<head>
    <title>Login</title>
</head>

<c:if test="${!param.ajax}">
    <p>
        Please enter your username and password to login.
        User user/user has a <strong>ROLE_USER</strong> role,
        while admin/admin has an <strong>ROLE_ADMIN</strong> role. These users
        and their encrypted passwords are stored in <em>WEB-INF/security.xml</em>.
    </p>
</c:if>

<form action="${ctx}/j_security_check" id="loginForm" method="post">
    <p>
    <c:if test="${param.error == 'true'}">
        <div class="error">Login Failed. ${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}</div>
    </c:if>
    <c:if test="${not empty shiroLoginFailure}">
        <div class="error">${shiroLoginFailure}</div>
    </c:if>

    <label for="username" id="username-label">Username</label><br/>
    <input id="username" type="text" name="j_username"/><br/>

    <label for="password">Password</label><br/>
    <input id="password" type="password" name="j_password"/><br/>

    <input type="checkbox" name="_spring_security_remember_me" id="rememberMe"/>
    <label for="rememberMe" style="vertical-align: top">Remember Me</label><br/>

    <input type="submit" id="login" class="button" value="Login"/>
    <input type="reset" id="reset" class="button" value="Clear"/>
    </p>
</form>

<script type="text/javascript">
<c:if test="${param.ajax}">
    var loginFailed = function(data, status) {
        $(".error").remove();
        $('#username-label').before('<div class="error">Login failed, please try again.</div>');
    };

    $("#login").live('click', function(e) {
        e.preventDefault();
        $.ajax({url: getHost() + "${ctx}/api/login.json",
            type: "POST",
            beforeSend: function(xhr) {
                xhr.withCredentials = true;
            },
            data: $("#loginForm").serialize(),
            success: function(data, status) {
                if (data.loggedIn) {
                    // success
                    dialog.dialog('close');
                    location.href = getHost() + '${ctx}/users';
                } else {
                    loginFailed(data);
                }
            },
            error: loginFailed
        });
    });
</c:if>
    $('#username').focus();
</script>
