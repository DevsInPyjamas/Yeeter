<%--
    Document   : welcomepage
    Created on : 16-Apr-2019, 10:56:06
    Author     : alec
--%>

<%@page import="yeeterapp.entity.Grupo"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="yeeterapp.entity.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="yeeterapp.entity.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>

<%
    List<Post> posts = (List) request.getAttribute("posts");
    Usuario userLog = (Usuario) request.getAttribute("loggedUser");
    String mensaje = (String) request.getAttribute("message");
%>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yeeter</title>
        <script src="assets/js/rowSelecter.js"></script>
    </head>

    <body>
        <%
            if(mensaje != null) {
        %>
            <div class="alert alert-success"><%=mensaje%></div>
        <%
            }
        %>
        <div class="container mb-5">
            <div class="row">

                <div class="col-3">

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">  @<%= userLog.getUsername()%>
                            </h5>
                            <p class="card-text">
                            <div class="row overview">
                                <div class="col-md-6 user-pad text-center">
                                    <h5>Yeets</h5>
                                    <h6><%= userLog.getPostList().size() %></h6>
                                </div>
                                <div class="col-md-6 user-pad text-center">
                                    <h5>Amigos</h5>
                                    <h6><%= userLog.getUsuarioList1().size() %></h6>
                                </div>

                            </div>
                            </p>
                        </div>
                    </div>


                </div>
                <div class="col-7">
                        <% for (Post p : posts) {

                        %>
                        <div class="card" data-href="PostServlet?postID=<%= p.getId() %>" style="cursor: pointer;">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <%                            if (p.getIdGrupo() != null) {
                                    %>
                                    Posted in group <%=p.getIdGrupo().getNombre()%> by @<%= p.getIdAutor().getUsername()%>

                                    <% } else {%>
                                    @<%= p.getIdAutor().getUsername()%>

                                    <% }%>
                                </h5>
                                <p class="card-text"><%= p.getContenido()%></p>

                                <footer > <%= p.getFechaPublicacion() %> </footer>
                            </div>
                        </div>
                        <% }%>
                </div>
            </div>
        </div>
    </body>

</html>
