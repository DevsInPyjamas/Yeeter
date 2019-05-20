<%-- 
    Document   : addUser
    Created on : 29-Apr-2019, 16:37:56
    Author     : alec
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<% 
    List<Usuario> amigos = (List) request.getAttribute("amigos");
    int idGrupo = (Integer) request.getAttribute("idGrupo");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yeeter - Añadir amigos al grupo</title>
        <link rel="stylesheet" href="assets/css/loginstyle.css"/>
        <link rel="stylesheet" href="assets/css/estilos.css"/>
    </head>
    <body>
        <div class="container">
            <div class="bot-grupos">
                <nav class="navbar navbar-dark bg-dark mb-5">
                    <span class="navbar-brand">Añadir miembro</span>
                </nav>
                <% 
                if(amigos.size() > 0 ) {
                    for(Usuario amigo : amigos) {
                %>
                    <div class="card w-100 mt-1 mb-1">
                        <div class="card-body row align-items-center">
                            <div class="col-11 ">
                                <%= amigo.getNombre() %>
                                <%= amigo.getApellidos() %>
                            </div>
                            <div class="col-1">
                                <form name="addToGroup" action="AddToGroupServlet" method="POST" class="w-100">
                                    <input value="<%= amigo.getId() %>" type="hidden" name="idAmigo"/>
                                    <input value="<%= idGrupo %>" type="hidden" name="idGrupo"/>
                                    <button type="submit" class="btn btn-outline-info btn-sm"><i class="fas fa-user-plus"></i></button>
                                </form>
                            </div>
                        </div>
                    </div>
                <%
                    } 
                } else {
                %>
                    <div class="alert alert-warning">Todos tus amigos se encuentran ya en este grupo!</div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
