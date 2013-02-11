<%@ include file="/taglibs.jsp"%>

<title>Login</title>
<body>
<p>
    Please enter your username and password to login.
</p>

<form method="post" id="loginForm" class="form-signin">
    <h2 class="form-signin-heading">Sign In</h2>
    <input type="text" name="j_username" id="j_username" class="input-block-level"
           placeholder="Username" required tabindex="1" autofocus>
    <input type="password" class="input-block-level" name="j_password" id="j_password" tabindex="2"
           placeholder="Password" required>

    <label class="checkbox" for="rememberMe">
        <input type="checkbox" class="checkbox" name="rememberMe" id="rememberMe" tabindex="3"/>
        Remember Me
    </label>

    <input type="submit" class="btn btn-primary" name="login" id="login" tabindex="4" value="Login">
</form>
</body>

