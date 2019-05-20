<%-- 
    Document   : newchat
    Created on : 29-abr-2019, 17:53:16
    Author     : jesus
--%>

<%@page import="javax.ejb.EJB"%>
<%@page import="yeeterapp.ejb.UsuarioFacade"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<% 
    List<Usuario> amigos = (List) request.getAttribute("amigos");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo Chat</title>
        <link rel="stylesheet" href="assets/css/loginstyle.css"/>
        <link rel="stylesheet" href="assets/css/estilos.css"/>
        <script src="assets/js/rowSelecter.js"></script>
    </head>
    <body>
        <div class="content">
            <div class="bot-grupos">
                <nav class="navbar navbar-dark bg-dark mb-5">
                    <span class="navbar-brand">Nuevo Chat</span>
                </nav>
                <%
                    if(!amigos.isEmpty()){
                        for(Usuario amigo : amigos) {
                %>
                            <div class="card w-100 mt-1 mb-1" style="cursor: pointer;" data-href="ChatServlet?idAmigo=<%= amigo.getId() %>">
                                <div class="card-body row align-items-center">
                                    <div class="col-11 ">
                                        <%= amigo.getNombre() + " " + amigo.getApellidos() %>
                                    </div>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                <div class="alert alert-warning mb-4">No tienes ning&uacute;n amigo</div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
