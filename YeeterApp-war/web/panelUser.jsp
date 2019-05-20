<%-- 
    Document   : panelUser
    Created on : 17-abr-2019, 20:37:39
    Author     : leonardobruno
--%>

<%@page import="java.text.Format"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="yeeterapp.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
    
    <%
        Usuario us=(Usuario)request.getAttribute("usuario");
        boolean mismoUsuario=us.getId() == usuario;
        Format formatter = new SimpleDateFormat("dd-MM-yyyy");
        String dateString = formatter.format(us.getFechaNacimiento());
        String from = (String) request.getAttribute("from");
        String mensaje = (String) request.getAttribute("message");
    %>
    <head>
       <title>Yeeter</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="assets/css/estilos.css"/>
    </head>
    <body>
        <%
            if(mensaje != null) {
        %>
            <div class="alert alert-success"><%=mensaje%></div>
        <% 
            }
        %>
        <div class="container">
            <div class="top">
                <p>Perfil<% if(mismoUsuario) { %>
                    <a href="ModificarPasswordServlet" class="btn btn-primary" role="button" > Modificar Contraseña</a></p>
                <% } else{ %>
                    </p>
                    <% } %> 
            </div>
            <div class="bot">
                <form action="ModificarPerfilServlet" method="post">
                  <div class="form-group row">
                    <label for="inputEmail3" class="col-sm-2 col-form-label">Usuario</label>
                    <div class="col-sm-7">
                        <input readonly class="form-control" id="usuario" value="<%= us.getUsername() %>">
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-2 col-form-label">Nombre</label>
                    <div class="col-sm-7">
                      <input readonly class="form-control" id="nombre" value="<%= us.getNombre() %>">
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-2 col-form-label">Apellidos</label>
                    <div class="col-sm-7">
                      <input readonly class="form-control" id="apellidos" value="<%= us.getApellidos() %>">
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-7">
                      <input readonly type="email" class="form-control" id="email" value="<%= us.getCorreo() %>">
                    </div>
                  </div>
                  <div class="form-group row">
                      
                        <label for="inputPassword3" class="col-sm-2 col-form-label">Fecha Nacimiento</label>
                        <div class="col-sm-7">
                            <input id="fechaNacimiento" readonly type="date" class="form-control" value="<%= dateString %>">
                        <span class="result"></span>
                        </div>
                  </div>    
                  <div class="form-group row">
                    <label for="inputPassword3" class="col-sm-2 col-form-label">Biografia</label>
                    <div class="col-sm-7">
                      <textarea readonly class="form-control" aria-label="biografia" ><%= us.getBiografia() %></textarea>
                    </div>
                  </div>
                  <div class="form-group row">
                    <div class="col-sm-10">
                        <% if(mismoUsuario) { %>
                        <a href="ModificarPerfilServlet"  class="btn btn-primary">Modificar</a>
                        <% } else { %>
                        <a href="ChatServlet?idAmigo=<%= us.getId() %>" class="btn btn-primary" >Enviar Mensaje</a>
                        <%
                            if(from == null) {
                        %>
                            <a href="#" class="btn btn-primary" >Añadir Amigo</a>
                        <%
                            } else {
                        %>
                            <a href="AceptarPeticionServlet?id=<%= us.getId() %>" class="btn btn-primary">Aceptar peticion</a>
                        <% 
                            }
                        %>
                        <% } %>
                    </div>
                  </div>
                </form>
        </div>
        </div>
    </body>
</html>
