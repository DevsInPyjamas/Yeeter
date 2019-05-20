<%-- 
    Document   : notificaciones
    Created on : 23-Apr-2019, 19:28:05
    Author     : alec
--%>

<%@page import="yeeterapp.entity.PeticionAmistad"%>
<%@page import="yeeterapp.entity.Notificaciones"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<% 
    List<Notificaciones> notificaciones = (List) request.getAttribute("notifications");
    long noLeidas = (Long) request.getAttribute("noLeidas");
    List<PeticionAmistad> peticiones = (List) request.getAttribute("peticiones");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=(noLeidas != 0)? "(" + Long.toString(noLeidas) + ")":""%> Notificaciones</title>
        <link rel="stylesheet" href="assets/css/loginstyle.css"/>
        <link rel="stylesheet" href="assets/css/estilos.css"/>
        <script src="assets/js/rowSelecter.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="bot-grupos">
                <nav class="navbar navbar-dark bg-dark mb-5">
                    <span class="navbar-brand">Notificaciones</span>
                    <form class="inline-form" name="markAsReadNotification" action="MarkAsReadServlet" method="POST">
                        <button class="btn btn-outline-info">
                            Marcar todas como leídas
                        </button>
                    </form>

                </nav>
                <% 
                    for(PeticionAmistad pet : peticiones) {
                %>
                    <div class="not-read card w-100 mt-1 mb-1" data-href="panelUserServlet?id=<%= pet.getUsuario().getId() %>&from=friendRequest" style="cursor: pointer;">
                    <div class="card-body row align-items-center">
                        <div class="col-11 ">
                            <%= pet.getMensaje() %>
                        </div>
                        <div class="col-1">
                            <form name="markAsReadNotification" action="AceptarPeticionServlet" method="POST" class="w-100">
                            <input value="<%= pet.getPeticionAmistadPK().getUsuarioEmisor()%>" type="hidden" name="id"/>
                                <button type="submit" class="btn btn-outline-info btn-sm"><i class="fas fa-check"></i></button>
                            </form>
                        </div>
                    </div>
                    </div>
                <%
                    }
                %>
                <% 
                for(Notificaciones not : notificaciones) {
                %>
                <div class="<%= (!not.getNotificacionLeida())? "not-read" : "" %> card w-100 mt-1 mb-1" data-href="<%= not.getLink() %>" style="cursor: pointer;">
                    <div class="card-body row align-items-center">
                        <div class="col-11 ">
                            <%= not.getContenido() %>
                        </div>
                        <% if(!not.getNotificacionLeida()) { %>
                            <div class="col-1">
                                <form name="markAsReadNotification" action="MarkAsReadServlet" method="POST" class="w-100">
                                <input value="<%= not.getId() %>" type="hidden" name="idNotification"/>
                                    <button type="submit" class="btn btn-outline-info btn-sm"><i class="fas fa-check"></i></button>
                                </form>
                            </div>
                        <% } %>
                    </div>
                </div>
                <%
                }
                %>
            </div>
        </div>
    </body>
</html>
