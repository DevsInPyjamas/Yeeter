<%-- 
    Document   : modificarPassword
    Created on : 27-abr-2019, 17:10:37
    Author     : leonardobruno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<%
    String fieldsThatFail = (String) request.getAttribute("fields");
    %>
<!DOCTYPE html>
<style>
        .body-container {
            height: 60%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 50px;
            padding-bottom: 150px;
        }
        
    </style>
<html>
        <meta charset="UTF-8">
        <title>Yeeter</title>
        <link rel="stylesheet" 
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <h1 class="mt-5 justify-content-center">Modificar Contraseña</h1>
        </div>
        <div class="body-container">
            <form method="post" action="ModificarPasswordServlet?id=<%= usuario %>">
                <div style="align-items: center;">
                    <%
                        if(fieldsThatFail != null && fieldsThatFail.contains("oldPass")) {
                    %>
                    <div class="alert alert-warning">Contraseña distinta a la original</div>
                    <% 
                        }
                    %>
                    <div class="input-group mb-3" style="padding-top: 10px">
                        <div class="input-group-prepend">
                            <div class="input-group-prepend">
                            <span style="width: 38px; height: 38px; padding-right:3px; padding-top: 3px; display:inline-block;">
                                <i class="fas fa-key fa-2x"></i>
                            </span>
                        </div>
                        </div>
                        <input placeholder="Contraseña Antigua" required="" type="password" name="oldPassword" class="form-control <%=(fieldsThatFail != null && fieldsThatFail.contains("pass")) ? "is-invalid" : null%>" id="basic-url" aria-describedby="basic-addon3">
                    </div>
                    <%
                        if(fieldsThatFail != null && fieldsThatFail.contains("pass")) {
                    %>
                    <div class="alert alert-warning">Las contraseñas no coinciden o tienen un tamaño menor que 6</div>
                    <% 
                        }
                    %>
                    <div class="input-group mb-3" style="padding-top: 10px">
                        <div class="input-group-prepend">
                            <div class="input-group-prepend">
                            <span style="width: 38px; height: 38px; padding-right:3px; padding-top: 3px; display:inline-block;">
                                <i class="fas fa-key fa-2x"></i>
                            </span>
                        </div>
                        </div>
                        <input placeholder="Nueva Contraseña" required="" type="password" name="password1" class="form-control <%=(fieldsThatFail != null && fieldsThatFail.contains("pass")) ? "is-invalid" : null%>" id="basic-url" aria-describedby="basic-addon3">
                        <input placeholder="Repetir contraseña" required="" type="password" name="password2" class="form-control <%=(fieldsThatFail != null && fieldsThatFail.contains("pass")) ? "is-invalid" : null%>" id="basic-url" aria-describedby="basic-addon3">
                    </div>

                    <button class="btn btn-lg btn-outline-info btn-block mt-5" type="submit">Modificar</button>
                </div>
            </form>
        </div>
    </body>
</html>

