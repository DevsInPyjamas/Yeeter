<%--
    Document   : modificarPerfil
    Created on : 19-abr-2019, 15:32:38
    Author     : leonardobruno
--%>

<%@page import="java.text.Format"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="yeeterapp.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
    <head>
<style>
        .body-container {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 50px;
            padding-bottom: 150px;
        }

    </style>
    <%
        Format formatter = new SimpleDateFormat("dd-MM-yyyy");
        String fechaNacimiento = formatter.format(request.getAttribute("fechaNacimiento"));
        String fieldsThatFail = (String) request.getAttribute("fields");
        String userErrorMessage = (String) request.getAttribute("userError");
        String lastUsername = (String) request.getAttribute("lastUsername");
        String lastEmail = (String) request.getAttribute("lastEmail");
        String lastName = (String) request.getAttribute("lastName");
        String lastSurname = (String) request.getAttribute("lastSurname");
        String lastBio = (String)request.getAttribute("lastBio");
        String lastPass=(String)request.getAttribute("password");

    %>
        <meta charset="UTF-8">
        <title>Yeeter</title>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <h1 class="mt-5 justify-content-center">Modificar Perfil</h1>
        </div>
        <div class="body-container">
            <form method="post" action="ModificarPerfilServlet?id=<%= usuario %>" >
                <input type="hidden" name="pass" value="<%= lastPass %>"/>
                <div style="align-items: center;">
                    <%
                        if(userErrorMessage != null) {
                    %>
                    <div class="alert alert-warning">
                        <%=userErrorMessage%>
                    </div>
                    <%
                        }
                    %>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="basic-addon1">Username</span>
                        </div>
                        <input type="text" class="form-control <%=(fieldsThatFail != null && fieldsThatFail.contains("user") ? "is-invalid" : null)%>" placeholder="Username"
                               aria-label="Username" aria-describedby="basic-addon1"
                               name="username" required="" autofocus=""
                               value="<%= lastUsername %>">
                    </div>

                    <%
                        if(fieldsThatFail != null && fieldsThatFail.contains("email")) {
                    %>
                    <div class="alert alert-warning">
                        Formato de email incorrecto
                    </div>
                    <%
                        }
                    %>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span style="width: 38px; height: 38px; padding-right:3px; padding-top: 3px; display:inline-block;">
                                <i class="fas fa-envelope fa-2x"></i>
                            </span>
                        </div>
                        <input type="email" class="form-control <%=(fieldsThatFail != null && fieldsThatFail.contains("email") ? "is-invalid" : null)%>"
                               placeholder="e-mail" name="email" required=""
                               aria-label="Recipient's username" aria-describedby="basic-addon2"
                               value="<%=(lastEmail != null) ? lastEmail : ""%>">
                    </div>

                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Nombre</span>
                        </div>
                    <input type="text" class="form-control" required="" name="name"
                           value="<%=(lastName != null) ? lastName : ""%>">
                    </div>

                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Apellidos</span>
                        </div>
                    <input type="text" class="form-control" required="" name="surname"
                           value="<%=(lastSurname != null) ? lastSurname : ""%>">
                    </div>

                    <%
                        if(fieldsThatFail != null && fieldsThatFail.contains("date")) {
                    %>
                    <div class="alert alert-warning">
                        La fecha no es correcta
                    </div>
                    <%
                        }
                    %>

                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Fecha de Nacimiento</span>
                        </div>
                    <input type="date" class="form-control
                           <%=(fieldsThatFail != null && fieldsThatFail.contains("date")) ? "is-invalid" : fechaNacimiento %>" required="" name="birth"
                           value="<%= fechaNacimiento %>" >
                    </div>

                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Biografía</span>
                        </div>
                        <textarea class="form-control" aria-label="With textarea" name="bio"><%= lastBio %></textarea>
                    </div>
                    <button class="btn btn-lg btn-outline-info btn-block mt-5" type="submit">Modificar</button>
                </div>
            </form>
        </div>
    </body>
</html>
