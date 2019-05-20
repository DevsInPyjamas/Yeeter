/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import yeeterapp.ejb.ComentarioFacade;
import yeeterapp.ejb.NotificacionesFacade;
import yeeterapp.ejb.PostFacade;
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.Comentario;
import yeeterapp.entity.Notificaciones;
import yeeterapp.entity.Post;
import yeeterapp.entity.Usuario;

/**
 *
 * @author jugr9
 */
@WebServlet(name = "CrearComentarioServlet", urlPatterns = {"/CrearComentarioServlet"})
public class CrearComentarioServlet extends HttpServlet {
    
    @EJB
    UsuarioFacade usuarioFacade;
    @EJB
    PostFacade postFacade;
    @EJB
    ComentarioFacade comentarioFacade;
    @EJB
    NotificacionesFacade notificacionesFacade;
    
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Post post = postFacade.find(new Integer(request.getParameter("postID")));
        String comentario = request.getParameter("comentario");
        
        HttpSession session = request.getSession();
        int idUsuario = (Integer) session.getAttribute("loggedUserID");
        Usuario us = usuarioFacade.find(idUsuario);
        RequestDispatcher rd;
        
        if(us == null){
            rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            request.setAttribute("error", "Por favor inicie sesión.");
            rd.forward(request, response);
        }
        
        Comentario com = new Comentario();
        com.setAutor(us);
        com.setContenido(comentario);
        com.setPost(post);
        com.setFechaPublicacion(new java.util.Date(System.currentTimeMillis()));
        comentarioFacade.create(com);
        
        List<Comentario> listaComentarios = post.getComentarioList();
        listaComentarios.add(com);
        post.setComentarioList(listaComentarios);
        
        postFacade.edit(post);
        
        Notificaciones not = new Notificaciones();
        not.setContenido("@" + us.getUsername() + " ha comentado un post tuyo.");
        not.setLink("PostServlet?postID=" + post.getId());
        not.setIdUsuario(post.getIdAutor());
        not.setNotificacionLeida(false);
        
        notificacionesFacade.create(not);
        
        List<Notificaciones> listaNotificaciones = post.getIdAutor().getNotificacionesList();
        listaNotificaciones.add(not);
        post.getIdAutor().setNotificacionesList(listaNotificaciones);
        
        usuarioFacade.edit(post.getIdAutor());
        
        request.setAttribute("message", "Has comentado con éxito esta publicación");
        response.sendRedirect("PostServlet?postID=" + post.getId());
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
