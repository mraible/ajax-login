<%@ include file="/taglibs.jsp"%>

<title>Login</title>
<body>
<p>
    Please enter your username and password to login.
</p>

<form method="post" id="loginForm" class="form-signin" action="">
    <h2 class="form-signin-heading">Sign In</h2>

    <c:if test="${not empty shiroLoginFailure}">
        <div class="alert alert-error">Login failed. Please try again.</div>
    </c:if>

    <input type="text" name="j_username" id="j_username" class="input-block-level"
           placeholder="Username" required tabindex="1" autofocus>
    <input type="password" class="input-block-level" name="j_password" id="j_password" tabindex="2"
           placeholder="Password" required>

    <label class="checkbox" for="rememberMe">
        <input type="checkbox" class="checkbox" name="_spring_security_remember_me" id="rememberMe" tabindex="3"/>
        Remember Me
    </label>

    <input type="submit" class="btn btn-primary" name="login" id="login" tabindex="4" value="Login">
</form>

<script type="text/javascript">
<c:if test="${param.ajax}">
    var loginFailed = function(data, status) {
        $(".alert").remove();
        $('#j_username').before('<div class="alert alert-error">Login failed, please try again.</div>');
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
</script>
</body>
