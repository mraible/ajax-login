<%@ include file="/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title><decorator:title default="Welcome"/> | <fmt:message key="webapp.name"/></title>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <link rel="shortcut icon" href="${ctx}/images/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/deliciouslyblue/theme.css" />
    <script type="text/javascript" src="${ctx}/scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/jquery.windowName-0.9.1.plugin.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/global.js"></script>
    <decorator:head/>
</head>
<body>
<div id="ajaxLoading" style="display: none; position: absolute; top: 0; right: 0; background: red; padding: 5px 10px; color: white">Loading...</div>
<a name="top"></a>
<div id="page">

    <div id="header" class="clearfix">

        <h1 style="cursor: pointer" onclick="location.href='${ctx}/'">AppFuse Light</h1>

        <div id="branding">
            <a href="http://appfuse.org" title="AppFuse - eliminating project startup time">
                <img src="${ctx}/images/powered-by-appfuse.gif" width="203" height="75" alt="AppFuse"/></a>
        </div>

        <p><fmt:message key="webapp.tagline"/></p>
    </div>

    <div id="content">

        <div id="main">
            <h1><decorator:title/></h1>
            <security:authorize ifAnyGranted="ROLE_USER,ROLE_ADMIN">
                <div class="logout"><a href="${ctx}/logout">Logout</a></div>
            </security:authorize>
            <div id="body">
                <%@ include file="/messages.jsp"%>
                <decorator:body/>

                <div id="underground"><decorator:getProperty property="page.underground"/></div>
            </div>
        </div>

        <div id="sub">
            <h3>Resources</h3>

            <p>The following is a list of resources that I used to create this project..</p>

            <ul class="glassList">
                <li><a href="http://raibledesigns.com/rd/entry/implementing_ajax_authentication_using_jquery">Ajax Authentication using jQuery and Spring Security</a></li>
                <li><a href="http://raibledesigns.com/rd/entry/integration_testing_with_http_https">Integration Testing with HTTP, HTTPS and Maven</a></li>
                <li><a href="http://static.springsource.org/spring-security/site/reference.html">Spring Security Reference</a></li>
                <li><a href="http://www.sitepen.com/blog/2008/07/22/windowname-transport/">window.name Transport</a></li>
                <li><a href="http://stackoverflow.com/questions/1099787/jquery-ajax-post-sending-options-as-request-method-in-firefox">jQuery OPTIONS Request</a></li>
            </ul>

            <img src="${ctx}/images/image.gif" alt="" width="150" height="112" class="right" style="margin: 10px 0 20px 0"/>
        </div>

        <div id="nav">
            <div class="wrapper">
                <h2 class="accessibility">Navigation</h2>
                <ul class="clearfix">
                    <li><a href="${ctx}/" title="Home"><span>Home</span></a></li>
                    <li><a href="${ctx}/users" title="View Users"><span>Users</span></a></li>
                </ul>
            </div>
        </div><!-- end nav -->

    </div><!-- end content -->

    <div id="footer">
        <p>
            <a href="http://validator.w3.org/check?uri=referer">Valid XHTML 1.0</a> |
            <a href="http://www.oswd.org/design/preview/id/2634">Theme</a> from <a href="http://www.oswd.org/">OSWD</a> |
            Design by <a href="http://www.oswd.org/user/profile/id/8377">super j man</a>
        </p>
    </div>
</div>
</body>
</html>
