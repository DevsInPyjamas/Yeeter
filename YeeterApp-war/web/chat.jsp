<%-- 
    Document   : chat
    Created on : 29-abr-2019, 19:42:13
    Author     : jesus
--%>

<%@page import="yeeterapp.entity.Mensaje"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<%
    List<Mensaje> mensajes = (List) request.getAttribute("mensajes");
    Usuario amigo = (Usuario) request.getAttribute("amigo");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/loginstyle.css"/>
        <link rel="stylesheet" href="assets/css/estilos.css"/>
        <title>Chat</title>
    </head>
    <body>
        <div class="container">
            <div class="bot-grupos">
                <nav class="navbar navbar-dark bg-dark mb-5">
                    <span class="navbar-brand">Chat con <%= amigo.getNombre() + " " + amigo.getApellidos() %> </span>
                </nav>
                <div class="container">
                    <%
                        if (!mensajes.isEmpty()) {
                            for(Mensaje mensaje : mensajes) {
                    %>
                    <div class="row">
                        <% if(!mensaje.getIdEmisor().equals(amigo) ) { %>
                        <div class="col-6"></div>
                        <% 
                            }
                        %>
                        <div class="card col-6 w-100 mt-1 mb-1">
                            <div class="card-body">

                                <h5 class="card-title">
                                    <% if(!mensaje.getIdEmisor().equals(amigo) ) { %>
                                        Yo:
                                    <% } else { %>
                                        <%= amigo.getNombre() %>:
                                    <% } %>
                                </h5>
                                <p class="card-text">
                                    <%= mensaje.getContenido() %>
                                </p>
                            </div>
                        </div>
                    </div>
                                <div class="mb-3"></div>                                
                    <%
                            }
                        } else {
                    %>
                    <div class="alert alert-warning mb-4">No hay mensajes con este usuario</div>
                    <%
                        }
                    %>
                </div>
                <form method="post" action="EnviarMensajeServlet">
                    <textarea name="mensaje" rows="5" cols="160"></textarea><br/>
                    <input type="hidden" name="amigo" value="<%= amigo.getId() %>">
                    <div class="btn-group" role="group">
                        <button class="btn btn-lg btn-outline-info btn-block" type="submit">
                            Enviar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
