<%-- 
    Document   : login
    Created on : 05-Apr-2019, 12:25:15
    Author     : alec
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<% 
    String error = (String) request.getAttribute("error");
    String user = (String) request.getAttribute("registerCompleted");
%>
<html>
    <head>
        <title>Yeeter</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" 
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="assets/css/loginstyle.css"/>
    </head>
    <body class="text-center">
        <div class="body-container">
            <div class="container d-flex justify-content-center" style="align-items: center;">
                <div style="width: 250px;">
                    <%
                        if(user != null) {
                    %>
                        <div class="alert alert-success"><%=user%></div>
                    <% 
                        }
                    %>
                    <h1 class="h3 mb-3 font-weight-normal">Log In</h1>
                    <form class="form-login-container" action="Login" name="loginInfo" 
                          accept-charset="UTF-8" method="post">
                        <label for="inputEmail" class="sr-only">Email address</label>
                        <input name="email" type="email" id="inputEmail" class="form-control" 
                               placeholder="Email address" required="" autofocus="">
                        <label for="inputPassword" class="sr-only">Password</label>
                        <input name="password" 
                               type="password" id="inputPassword" 
                               class="form-control" placeholder="Password" required="">
                        <div class="checkbox mb-3 mt-3">
                            <% if (error != null) {
                            %>
                            <div class="alert alert-warning"><%=error%></div>
                            <%
                                }
                            %>
                            <!--a class="text-muted" href="forgotpswrd.jsp">Contraseña Olvidada</a-->
                        </div>
                        <div class="btn-group" role="group">
                            <a href="register.jsp" class="btn btn-lg btn-outline-secondary">
                                Registrarse
                            </a>
                            <button class="btn btn-lg btn-outline-info btn-block" type="submit">
                                Entrar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
