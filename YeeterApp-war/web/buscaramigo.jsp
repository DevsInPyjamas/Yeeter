<%--
    Document   : buscaramigo
    Created on : 18-abr-2019, 11:55:45
    Author     : Juan Garcia Ruiz
--%>

<%@page import="yeeterapp.entity.Usuario"%>
<%@page import="java.util.*"%>
<%@page import="yeeterapp.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>

<!DOCTYPE html>
<%
    Usuario logUs=(Usuario) request.getAttribute("loggedUser");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    List<Usuario> users = (List<Usuario>)request.getAttribute("users");
    List<Usuario> amigos = (List<Usuario>)request.getAttribute("friends");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="assets/js/rowSelecter.js"></script>
        <title>Yeeter</title>
    </head>
    <body class = "text-center">
        <% 
            if (error != null){
                
        %>
        
        <div class="alert alert-warning"><%=error%></div>
        
        <%     
            }else if (message != null) {
        %>

        <div class="alert alert-success"><%=message%></div>

        <%
           }
        %>
        <table class = "table">
            <tr>
                <th>NOMBRE</th>
                <th>APELLIDOS</th>
                <th>USERNAME</th>
                <th></th>
            </tr>

            <%
                for(Usuario u: users){
                    int idReceptor = u.getId();
            %>

            <tr class='clickable-row' data-href="panelUserServlet?id=<%=u.getId()%>" style="cursor: pointer;">
                <th><%=u.getNombre()%></th>
                <th><%=u.getApellidos()%></th>
                <th><%=u.getUsername()%></th>
                <th>
                    <%
                        if(!amigos.contains(u) && !logUs.equals(u)){
                    %>

                    <form method = "post" action = "PeticionAmigo">
                        <input type = "hidden" name = "destID" value ="<%=idReceptor%>">
                        <div class="input-group-append">
                            <button class="btn btn-outline-dark" style="height: 38px; width: 50px;" type="submit" >
                                <span style="width: 25px; height: 25px; display:inline-block;">
                                    <i class="fas fa-user-plus"></i>
                                </span>
                            </button>
                        </div>
                    </form>

                    <%
                        }
                    %>
                </th>
            </tr>

            <%
                }
            %>
        </table>
    </body>
</html>
