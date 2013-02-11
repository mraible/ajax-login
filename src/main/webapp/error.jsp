<%@ page language="java" isErrorPage="true" %>

<head><title>Doh!</title></head>

An Error has occurred in this application.

<% if (exception != null) { %>
    Please check your log files for further information.
    <% System.err.println(exception); %>
<% } %>
