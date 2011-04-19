<%@ include file="/taglibs.jsp" %>

<head>
    <style type="text/css">
        .button {
            margin-top: 5px
        }

        #username {
            margin-bottom: 5px
        }

        .ui-dialog-content, form p {
            text-align: left
        }

        .ui-dialog-content {
            font-size: .8em
        }
    </style>
</head>
<div id="intro">
    <h2>Welcome to Ajax Login</h2>

    <p>
        This application was built using <a href="http://appfuse-light.java.net">AppFuse Light</a> and
        is designed to be a demonstration of the following features:
    </p>
    <ul>
        <li>Require HTTPS for authentication.</li>
        <li>Allows testing HTTPS without installing an SSL certificate locally.</li>
        <li>Implements a RESTful LoginService that allows users to login.</li>
        <li>Implement login with Ajax, with the request coming from an insecure page.</li>
    </ul>

    <p>You can read more about this application in my <a
            href="http://raibledesigns.com/rd/entry/implementing_ajax_authentication_using_jquery">
        Implementing Ajax Authentication using jQuery, Spring Security and HTTPS</a> article.
        The source for this application is <a href="https://github.com/mraible/ajax-login">available on GitHub</a>.
    </p>

    <p>To login normally, click on the "Users" tab above and enter your credentials when prompted. To login
        using Ajax, click on the "View Demonstration" button below and use admin/admin to login. The Ajax login is not
        persistent yet, but I hope to fix that soon.
    </p>

    <p>
        <button class="button" id="demo">View Demonstration</button>
        <button class="button" id="status">Status</button>
    </p>
</div>

<content tag="underground">
    <h3>Assumptions</h3>
    <ul>
        <li>It's 2011, you should be thinking about HTML5 and SOFEA.</li>
        <li>JRebel should be used to allow quick reloading of classes.</li>
        <li>Conventions are more important than configurability.</li>
    </ul>
</content>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"/>
<script type="text/javascript">

    var secure = true;

    var getHost = function() {
        var port = (window.location.port == "8080" || window.location.port == "8443") ? ":8443" : "";
        return ((secure) ? 'https://' : 'http://') + window.location.hostname + port;
    };


    var dialog = $('<div></div>');

    $(document).ready(function() {
        // see if the user is logged in

        $.get('${ctx}/login?ajax=true', function(data) {
            dialog.html(data);
            dialog.dialog({
                autoOpen: false,
                title: 'Authentication Required'
            });
        });

        $('#demo').click(function() {
            dialog.dialog('open');
            // prevent the default action, e.g., following a link
            return false;
        });

        $('#status').click(function() {
            $.ajax({url: getHost() + '${ctx}/api/login.json',
                type: 'GET',
                beforeSend: function(xhr){
                    xhr.withCredentials = true;
                },
                success: function(data, status) {
                    $(".status").remove();
                    $("#status").after("<span class='status'> Logged In: " + data.loggedIn + "</span>");
                }
            });
        })
    });
</script>
