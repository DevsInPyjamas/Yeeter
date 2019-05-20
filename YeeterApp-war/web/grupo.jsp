<%--
    Document   : grupo
    Created on : 22-abr-2019, 9:25:39
    Author     : leonardobruno
--%>

<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="yeeterapp.entity.Post"%>
<%@page import="yeeterapp.entity.Grupo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<%
    Grupo grupo = (Grupo)request.getAttribute("grupo");
    boolean esAdmin= usuario.equals(grupo.getIdCreador().getId());
    String message = (String) request.getAttribute("mensaje");
    boolean editing = (Boolean) request.getAttribute("editing") != null && (Boolean) request.getAttribute("editing");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/estilos.css"/>
        <title>Yeeter - <%= grupo.getDescripcion() %></title>
        <script src="assets/js/rowSelecter.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="bot-grupos">
                <% 
                    if(message != null) {
                %>
                <div class="alert alert-success"> <%= message %> </div>
                <%
                    }
                %>
                <% if(!editing) {%>
                    <nav class="navbar navbar-dark bg-dark">
                        <span class="navbar-brand"><%= grupo.getNombre() %></span>
                    </nav>
                    <p><%= grupo.getDescripcion() %></p>
                <%
                } else {
                %>
                    <form action="EditarGrupoServlet" method="post">
                        <nav class="navbar navbar-dark bg-dark">
                            <input name="nombre" value="<%= grupo.getNombre() %>">
                        </nav>
                        <textarea name="descripcion" class="w-100 h-100"><%= grupo.getDescripcion() %></textarea>
                        <input type="hidden" value="<%= grupo.getId() %>" name="idGrupo">
                        <div class="btn-group mt-5 mr-auto" role="group">
                            <button class="btn btn-lg btn-outline-info btn-block" type="submit"> Modificar </button>
                            <a class="btn btn-lg btn-outline-secondary" href="WelcomeServlet">
                                Cancelar
                            </a>
                        </div>
                    </form>
                <%
                    }
                %>
                <% if(!editing){ %>
                    <nav class="nav nav-pills flex-column flex-sm-row">
                        <a class="btn btn-lg btn-outline-info" href="ListaMiemServlet?id=<%=grupo.getId()%>">Miembros</a>
                        <% if(esAdmin){ %>
                            <form action="GrupoServlet" method="post">
                                <input type="hidden" value="true" name="editing">
                                <input type="hidden" value ="<%= grupo.getId() %>" name="id">
                                <button class="btn btn-lg btn-outline-info btn-block" type="submit"> Modificar </button>
                            </form>
                        <% } %>
                    </nav>
            </div>
            <div class="mt-5">
                <% for(Post p: grupo.getPostList()){   %>
                <div class="card mt-1 mb-1" data-href="PostServlet?postID=<%= p.getId() %>" style="cursor: pointer;">
                    <div class="card-body">
                        <h5 class="card-title">@<%= p.getIdAutor().getUsername()%></h5>
                        <p class="card-text"><%= p.getContenido()%></p>
                        <footer > <%= p.getFechaPublicacion() %> </footer>
                    </div>
                </div>
                <% }
                   }
                %>
            </div>
        </div>
    </body>
</html>
