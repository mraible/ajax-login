<%@ include file="/taglibs.jsp" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <title><decorator:title default="Welcome"/> | <fmt:message key="webapp.name"/></title>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${ctx}/images/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${ctx}/webjars/bootstrap/2.2.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/webjars/bootstrap/2.2.1/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="${ctx}/styles/app.css">
    <script type="text/javascript" src="${ctx}/webjars/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/webjars/bootstrap/2.2.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/jquery.windowName-0.9.1.plugin.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/app.js"></script>
    <decorator:head/>
</head>
<body>
<div id="ajaxLoading" style="display: none; position: absolute; top: 0; right: 0; background: red; padding: 5px 10px; color: white">Loading...</div>
<a name="top"></a>
<div id="page">

    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
                <%-- For smartphones and smaller screens --%>
                <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="brand" href="<c:url value='/'/>">Ajax Login</a>
                <div class="nav-collapse collapse">
                    <ul class="nav">
                        <li><a href="${ctx}/" title="Home">Home</a></li>
                        <li><a href="${ctx}/users" title="View Users">Users</a></li>
                        <!-- Add new menu items here -->
                        <c:if test="${not empty pageContext.request.remoteUser}">
                            <li><a href="${ctx}/logout">Logout</a></li>
                        </c:if>
                    </ul>
                </div>
                <div class="pull-right tagline">
                    <fmt:message key="webapp.tagline"/>
                </div>
                <script type="text/javascript">
                    $('a[href="${pageContext.request.requestURI}"]').parent().addClass('active');
                </script>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span7">
                <%@ include file="/messages.jsp"%>
                <decorator:body/>

                <decorator:getProperty property="page.underground"/>
            </div>
            <div class="span2">
                <div id="branding">
                    <a href="http://appfuse.org" title="AppFuse - eliminating project startup time">
                        <img src="${ctx}/images/powered-by-appfuse.gif" width="203" height="75" alt="AppFuse"/></a>
                </div>
                <h3>Resources</h3>

                <p>The following is a list of resources used to create this project..</p>

                <ul class="glassList">
                    <li><a href="http://raibledesigns.com/rd/entry/implementing_ajax_authentication_using_jquery">Ajax Authentication using jQuery and Spring Security</a></li>
                    <li><a href="http://raibledesigns.com/rd/entry/integration_testing_with_http_https">Integration Testing with HTTP, HTTPS and Maven</a></li>
                    <li><a href="http://static.springsource.org/spring-security/site/reference.html">Spring Security Reference</a></li>
                    <li><a href="http://www.sitepen.com/blog/2008/07/22/windowname-transport/">window.name Transport</a></li>
                    <li><a href="http://stackoverflow.com/questions/1099787/jquery-ajax-post-sending-options-as-request-method-in-firefox">jQuery OPTIONS Request</a></li>
                </ul>
        </div>
    </div>

    <div id="footer">
        <p>
            Created by <a href="http://appfuse.org">AppFuse</a>.
        </p>
    </div>
</body>
</html>
