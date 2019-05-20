<%-- 
    Document   : creacionposts
    Created on : 18-abr-2019, 12:15:32
    Author     : jesus
--%>

<%@page import="java.util.List"%>
<%@page import="yeeterapp.entity.Grupo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<%
    List<Grupo> grupos = (List) request.getAttribute("grupos");
%>
<html>
    <head>
        <title>Creaci&oacute;n de posts</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="assets/css/loginstyle.css"/>
        <link rel="stylesheet" href="assets/css/estilos.css"/>
    </head>    
    <body>
        <div class="content">
            <div class="bot-grupos">
                <nav class="navbar navbar-dark bg-dark mb-5">
                    <span class="navbar-brand">Crear un nuevo Post</span>
                </nav>
                    <div class="card-body row align-items-center" align="center">
                        <div class="col-11">
                            <form method="post" action="CrearPost">
                                <textarea name="post" rows="5" cols="50"  required="true"></textarea><br/>
                                <select name="grupos">
                                    <option value="-1" selected>P&uacute;blico</option>
                                    <%
                                        for(Grupo grupo: grupos) {
                                    %>
                                    <option value="<%= grupo.getId() %>">
                                        <%= grupo.getNombre() %>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select><br/>
                                <div class="btn-group" role="group">
                                    <a href="WelcomeServlet" class="btn btn-lg btn-outline-secondary">
                                        Cancelar
                                    </a>
                                    <button class="btn btn-lg btn-outline-info btn-block" type="submit">
                                        Publicar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
            </div>
        </div>
    </body>
    
    
    
    
</html>
