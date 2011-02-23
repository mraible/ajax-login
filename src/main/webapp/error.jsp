<%@ page language="java" isErrorPage="true" %>

<head><title>Doh!</title></head>

An Error has occurred in this application.  

<% if (exception != null) { %>
    <% exception.printStackTrace(new java.io.PrintWriter(out)); %>
<% } else { %>
    Please check your log files for further information.
<% } %>
