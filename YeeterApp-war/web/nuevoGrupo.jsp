<%-- 
    Document   : nuevoGrupo
    Created on : 11-may-2019, 17:30:35
    Author     : jesus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Nuevo Grupo</title>
    </head>
    <body>
        <div class="container">
            <div class="container d-flex justify-content-center">
                <h1 class="mt-5 justify-content-center">Crear un nuevo grupo</h1>
            </div>
            <div class="body-container">
                <form method="post" action="NuevoGrupoServlet">
                    <div style="align-items: center;">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon1">Nombre</span>
                            </div>
                            <input type="text" class="form-control" placeholder="Nombre" 
                                   aria-label="Nombre" aria-describedby="basic-addon1"
                                   name="nombre" required="" autofocus="">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon1">Descripci&oacute;n</span>
                            </div>
                            <textarea class="form-control" placeholder="" name="descripcion" required="" aria-label="With textarea"></textarea>
                        </div>
                        <button class="btn btn-lg btn-outline-info btn-block mt-5" type="submit">Crear grupo</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
