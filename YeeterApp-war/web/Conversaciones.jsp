<%-- 
    Document   : Conversaciones
    Created on : 29-abr-2019, 18:08:35
    Author     : pedro
--%>


<%@page import="java.util.Set"%>
<%@page import="yeeterapp.entity.Mensaje"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>

<%    Set<Usuario> listaConversaciones = (Set) request.getAttribute("listaConversaciones");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mensajes</title>
    </head>
    <body>
        <div class="container">
            <div class="row">

                <div class="col-7">
                    <% if (listaConversaciones.isEmpty()) {

                    %>
                    <div class="alert alert-secondary" role="alert">
                        No hay conversaciones disponibles
                    </div>

                    <% } else {
                        for (Usuario users : listaConversaciones) {%>

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                @<%=  users.getUsername()%>
                            </h5>
                            <p class="card-text"></p>
                            <form action="ChatServlet?idAmigo=<%= users.getId()%>" method="post">
                                <input type="submit" value="Acceder a Conversación" class="btn btn-outline-secondary float-right">
                            </form>
                        </div>
                    </div>
                    <% }
                        }%>
                </div>
                <div class="col-3">
                    <form action="PreNewChatServlet">
                        <input type="submit" value="Nueva Conversacion" class="btn btn-info btn-lg">
                    </form>
                </div>
            </div>

        </div>

    </body>
</html>


