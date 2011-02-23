<%@ include file="/taglibs.jsp"%>

<head>
    <style type="text/css">
        .button { margin-top: 5px }
        #username { margin-bottom: 5px }
        .ui-dialog-content, form p { text-align: left }
        .ui-dialog-content { font-size: .8em }
    </style>
</head>
<div id="intro">
    <h2>Welcome to AppFuse Light!</h2>
    <p>
        <a href="http://appfuse-light.dev.java.net">AppFuse Light</a> is a lightweight version of <a href="http://appfuse.org">AppFuse</a>.
        I was inspired to create it while writing <a href="http://springlive.com">Spring Live</a> and
        looking at the <em>struts-blank</em> and <em>webapp-minimal</em>
        applications that ship with Struts and Spring, respectively.
        These "starter" apps were not robust enough for me, and I wanted
        something like AppFuse, only simpler.
    </p>
    <p>
        The basic AppFuse Light application shows how to do simple
        <acronym title="Create, Retrieve, Update and Delete">CRUD</acronym> on a database table.
        To see this feature, click on the button below. <a href="?" onclick="readMore(); return false">Click here</a>
        to learn more about AppFuse Light.
    </p>
    <p>
        <button class="button" id="demo">View Demonstration</button>
        <button class="button" id="status">Status</button>
    </p>
</div>
<div id="readmore" style="display:none">
    <h3>Introduction to AppFuse Light</h3>
    <p>
        AppFuse Light is designed to show Java Web Developers how to start
        a bare-bones webapp using a <a href="http://www.springframework.org">
        Spring</a>-managed middle-tier backend and <a href="http://www.hibernate.org">
        Hibernate</a> for persistence. In addition to Hibernate, you can also use JPA
        or <a href="http://ibatis.apache.org">iBATIS</a>.
    </p>
    <p>
        You can use many different web frameworks for your UI, including:
    </p>
    <ul>
        <li><a href="http://myfaces.apache.org">JSF/MyFaces</a></li>
        <li><a href="http://springframework.org">Spring MVC</a></li>
        <li><a href="http://stripesframework.org">Stripes</a></li>
        <li><a href="http://struts.apache.org/2.x/">Struts 2</a></li>
        <li><a href="http://tapestry.apache.org">Tapestry</a></li>
        <li><a href="http://wicket.apache.org/">Wicket</a></li>
    </ul>
    <p>
        In addition, there's a couple of extras for Spring MVC, including FreeMarker and
        Spring MVC versions. All versions are available using
        <a href="http://static.appfuse.org/light/archetypes.html">Maven Archetypes</a>.
    </p>
    <p>
        By default, AppFuse Light uses an in-memory H2 database. It will create it on-the-fly
        the first time tests are run or the application is started. More information on database
        configuration can be found in this project's README.txt file.
    </p>
    <p>
        Since no server configuration is required, this application should
        this application should work with any Servlet 2.4 servlet engine.
    </p>
    <p>
        <button class="button" onclick="readMore();">&laquo; Back</button>
    </p>
</div>
<content tag="underground">
<h3>Assumptions</h3>
<ul>
    <li>It's 2010, you should be thinking about HTML5 and SOFEA.</li>
    <li>JRebel should be used to allow quick reloading of classes.</li>
    <li>Conventions are more important than configurability.</li>
</ul>
</content>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"/>
<script type="text/javascript">
function readMore() {
    var main = document.getElementById("intro");
    var more = document.getElementById("readmore");
    if (main.style.display == "") {
        main.style.display = "none";
        more.style.display = "";
    } else {
        more.style.display = "none";
        main.style.display = "";
    }
}

var secure = true;

var getHost = function() {
    var port = (window.location.port == "8080") ? ":8443" : "";
    return ((secure) ? 'https://' : 'http://') + window.location.hostname + port;
};


var dialog = $('<div></div>');

$(document).ready(function() {
    // see if the user is logged in

    $.get('/login?ajax=true', function(data) {
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
      $.ajax({url: getHost() + '/api/login.json',
        type: 'GET',
        success: function(data, status) {
            $(".status").remove();
            $("#status").after("<span class='status'> Logged In: " + data.loggedIn + "</span>");
        }
    });
  })
});
</script>
