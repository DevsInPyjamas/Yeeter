/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import yeeterapp.ejb.GrupoFacade;
import yeeterapp.ejb.NotificacionesFacade;
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.Grupo;
import yeeterapp.entity.Notificaciones;
import yeeterapp.entity.Usuario;

/**
 *
 * @author alec
 */
@WebServlet(name = "AddToGroupServlet", urlPatterns = {"/AddToGroupServlet"})
public class AddToGroupServlet extends HttpServlet {

    @EJB
    private NotificacionesFacade notificacionesFacade;

    @EJB
    private GrupoFacade grupoFacade;

    @EJB
    private UsuarioFacade usuarioFacade;
    
    
    
    
    

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
        HttpSession session = request.getSession();
        Integer loggedID = (Integer) session.getAttribute("loggedUserID");
        String idValue = request.getParameter("id");
        RequestDispatcher rd;
        if(loggedID == null) {
            rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            request.setAttribute("error", "Por favor inicie sesión primero.");
            rd.forward(request, response);
            return;
        }
        String grupoId = request.getParameter("idGrupo");
        String idUsuarioInvitar = request.getParameter("idAmigo");
        
        Grupo grupo = grupoFacade.find(new Integer(grupoId));
        Usuario loggedUser = usuarioFacade.find(loggedID);
        Usuario usuarioAInvitar = usuarioFacade.find(new Integer(idUsuarioInvitar));
        
        
        List<Usuario> usuarioList = grupo.getUsuarioList();
        usuarioList.add(usuarioAInvitar);
        
        grupo.setUsuarioList(usuarioList);
        
        grupoFacade.edit(grupo);
        
        
        Notificaciones notificacion = new Notificaciones();
        notificacion.setContenido(loggedUser.getNombre() + " te ha añadido al grupo " + grupo.getNombre());
        notificacion.setLink("GrupoServlet?id=" + grupo.getId());
        notificacion.setIdUsuario(usuarioAInvitar);
        
        notificacionesFacade.create(notificacion);
        
        response.sendRedirect("GrupoServlet?id=" + grupo.getId()+"&mensaje=" + "Se ha invitado correctamente al usuario!");
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
