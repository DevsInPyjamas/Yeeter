<%-- 
    Document   : listaMiem
    Created on : 22-abr-2019, 9:26:31
    Author     : leonardobruno
--%>

<%@page import="yeeterapp.entity.Grupo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<%
    List<Usuario> lista=(List)request.getAttribute("usuarios");
    Grupo grupo = (Grupo) request.getAttribute("grupo");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/estilos.css"/>
        <title>Yeeter - Miembros de <%= grupo.getNombre() %></title>
    </head>
    <body>
        <div class="container">
            <div class="bot-grupos">
                <nav class="navbar navbar-dark bg-dark">
                    <span class="navbar-brand">Miembros de <%= grupo.getNombre() %></span>
                    <ul class="navbar-nav ml-3"> 
                        <a class="btn btn-outline-info" href="AddMemberServlet?id=<%= grupo.getId() %>">
                            Add Member
                        </a>
                    </ul>
                </nav>
                <div class="list-group">
                    <% for(int i=0;i<lista.size();i++){
                    %>
                    <a type="button" href="panelUserServlet?id=<%= lista.get(i).getId()%>" class="list-group-item list-group-item-action"><%= lista.get(i).getNombre()%></a>
                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>
