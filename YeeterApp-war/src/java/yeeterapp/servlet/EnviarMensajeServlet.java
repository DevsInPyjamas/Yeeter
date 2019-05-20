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
import yeeterapp.ejb.MensajeFacade;
import yeeterapp.ejb.NotificacionesFacade;
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.Mensaje;
import yeeterapp.entity.Notificaciones;
import yeeterapp.entity.Usuario;

/**
 *
 * @author pedro
 */
@WebServlet(name = "EnviarMensajeServlet", urlPatterns = {"/EnviarMensajeServlet"})
public class EnviarMensajeServlet extends HttpServlet {

    @EJB
    private NotificacionesFacade notificacionesFacade;

    @EJB
    private UsuarioFacade usuarioFacade;

    @EJB
    private MensajeFacade mensajeFacade;

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
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();        
        Integer idLoggedUser = (Integer) session.getAttribute("loggedUserID");
        RequestDispatcher rd;
        Usuario loggedUser;
        if(idLoggedUser == null) {
            rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            request.setAttribute("error", "Por favor inicie sesión primero.");
            rd.forward(request, response);
            return;
        } 
        loggedUser = usuarioFacade.find(idLoggedUser);
        String mensaje = request.getParameter("mensaje");
        String amigoId = request.getParameter("amigo");
        Usuario amigo = usuarioFacade.find(new Integer(amigoId));
        Mensaje message = new Mensaje();
        message.setContenido(mensaje);
        message.setIdEmisor(loggedUser);
        message.setIdReceptor(amigo);
        Date fecha = new Date(System.currentTimeMillis());
        message.setFecha(fecha);
        
        List<Notificaciones> not = amigo.getNotificacionesList();
        Notificaciones n = new Notificaciones();
        n.setContenido("El usuario " + loggedUser.getUsername() + " te ha enviado un mensaje");     
        n.setLink("ChatServlet?idAmigo=" + loggedUser.getId());
        n.setIdUsuario(amigo);
        
        notificacionesFacade.create(n);
        not.add(n);
        
        usuarioFacade.edit(amigo);
        
        mensajeFacade.create(message);
        
        response.sendRedirect("ChatServlet?idAmigo=" + amigoId);
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
