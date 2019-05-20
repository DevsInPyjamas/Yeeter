<%-- 
    Document   : register
    Created on : 05-Apr-2019, 13:28:04
    Author     : alec
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<%
    String fieldsThatFail = (String) request.getAttribute("fields");
    String userErrorMessage = (String) request.getAttribute("userError");
    String lastUsername = (String) request.getAttribute("lastUsername");
    String lastEmail = (String) request.getAttribute("lastEmail");
    String lastName = (String) request.getAttribute("lastName");
    String lastSurname = (String) request.getAttribute("lastSurname");
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Yeeter</title>
        <link rel="stylesheet" 
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/css/loginstyle.css"/>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <h1 class="mt-5 justify-content-center">Crear cuenta</h1>
        </div>
        <div class="body-container">
            <form method="post" action="Register">
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
                               value="<%=(lastUsername != null) ? lastUsername : ""%>">
                    </div>
                    <%
                        if(fieldsThatFail != null && fieldsThatFail.contains("email")) {
                    %>
                        <div class="alert alert-warning">
                            El email ya está en uso!
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
                    <%
                        if(fieldsThatFail != null && fieldsThatFail.contains("pass")) {
                    %>
                    <div class="alert alert-warning">Las contraseñas no coinciden o tienen un tamaño menor que 6</div>
                    <% 
                        }
                    %>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-prepend">
                            <span style="width: 38px; height: 38px; padding-right:3px; padding-top: 3px; display:inline-block;">
                                <i class="fas fa-key fa-2x"></i>
                            </span>
                        </div>
                        </div>
                        <input placeholder="Contraseña" required="" type="password" name="password1" class="form-control <%=(fieldsThatFail != null && fieldsThatFail.contains("pass")) ? "is-invalid" : null%>" id="basic-url" aria-describedby="basic-addon3">
                        <input placeholder="Repetir contraseña" required="" type="password" name="password2" class="form-control <%=(fieldsThatFail != null && fieldsThatFail.contains("pass")) ? "is-invalid" : null%>" id="basic-url" aria-describedby="basic-addon3">
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
                        if(fieldsThatFail != null && fieldsThatFail.contains("birth")) {
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
                           <%=(fieldsThatFail != null && fieldsThatFail.contains("birth")) ? "is-invalid" : null%>" required="" name="birth">
                    </div>

                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Biografía</span>
                        </div>
                        <textarea class="form-control" aria-label="With textarea" name="bio"></textarea>
                    </div>
                    <button class="btn btn-lg btn-outline-info btn-block mt-5" type="submit">Registrarse</button>
                </div>
            </form>
        </div>
    </body>
</html>

