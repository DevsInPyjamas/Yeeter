<%--
    Document   : newjsp
    Created on : 04-Apr-2019, 12:26:08
    Author     : alec
--%>
<%@page import="yeeterapp.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Integer usuario = (Integer) session.getAttribute("loggedUserID");
    String path = (String) request.getAttribute("currentPage");
%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/css/navbar.css"/>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>
    <body>
        <nav class="yeeter-nav navbar navbar-expand-lg navbar-dark bg-dark mb-5">
            <a class="navbar-brand" href="WelcomeServlet">Yeeter</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item d-flex align-items-center <%=("notificaciones".equals(path) ? "active" : "")%>">
                        <a class="nav-link" href="NotificationsServlet"><i class="fas fa-bell"></i> Notificaciones<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item d-flex align-items-center <%=("mensajes".equals(path) ? "active" : "")%>">
                        <a class="nav-link" href="ConversacionesServlet?id=<%= usuario%>"><i class="fas fa-envelope"></i> Mensajes</a>
                    </li>
                    <li class="nav-item d-flex align-items-center <%=("grupos".equals(path) ? "active" : "")%>">
                        <a class="nav-link" href="ListaGruposServlet?id=<%= usuario%>"><i class="fas fa-users"></i> Grupos</a>
                    </li>
                </ul>
                <form class="form-inline" action="BuscarAmigos">
                    <input name = "busqueda" class="form-control mr-sm-2" type="search" placeholder="Buscar Amigos" aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-outline-light" style="height: 38px; width: 50px;" type="submit" >
                            <span style="width: 25px; height: 25px; display:inline-block;">
                                <i class="fas fa-search"></i>
                            </span>
                        </button>
                    </div>
                </form>
                <ul class="navbar-nav ml-3">
                    <li class="nav-item <%=("perfil".equals(path) ? "active" : "")%>">
                        <a class="nav-link" href="panelUserServlet"><i class="fas fa-user"></i> Perfil</a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-3">
                    <li class="nav-item">
                        <a href="PrePostServlet">
                            <button class="btn btn-outline-light my-2 my-sm-0" style="height: 38px;">
                                <span class="fa-stack" style="width: 25px; height: 25px;">
                                    <i class="fas fa-book-open fa-stack-1x book-right"></i>
                                    <i class="fas fa-pencil-alt fa-stack-1x pencil-left"></i>
                                </span>
                            </button>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-3">
	          <li class="nav-item">
	          	<a href="Login?logout=1">
                            <button class="btn btn-outline-light my-2 my-sm-0">
                                Logout                                
                            </button>
                        </a>
	          </li>
                </ul>
            </div>
        </nav>               
    </body>
</html>
