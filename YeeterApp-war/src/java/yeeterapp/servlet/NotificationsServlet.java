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
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.Usuario;
import yeeterapp.entity.Notificaciones;
import yeeterapp.entity.PeticionAmistad;

/**
 *
 * @author alec
 */
@WebServlet(name = "NotificationsServlet", urlPatterns = {"/NotificationsServlet"})
public class NotificationsServlet extends HttpServlet {

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
        Integer idLoggedUser = (Integer) session.getAttribute("loggedUserID");
        RequestDispatcher rd;
        Usuario loggedUser;
        if(idLoggedUser == null) {
            rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            request.setAttribute("error", "Por favor inicie sesión primero.");
            rd.forward(request, response);
        } 
        loggedUser = usuarioFacade.find(idLoggedUser);
        
        
        
        List<PeticionAmistad> peticiones = loggedUser.getPeticionAmistadList1();
        List<Notificaciones> notificaciones = loggedUser.getNotificacionesList();
        request.setAttribute("notifications", notificaciones);
        long noLeidas;
        noLeidas = notificaciones.stream().filter(notificacion -> !notificacion.getNotificacionLeida()).count() +
                peticiones.size();
        // easy win programación funcional gracias por tanto.
        /*for(Notificaciones n : notificaciones) 
            if(!n.getNotificacionLeida())
                noLeidas++;*/
        request.setAttribute("noLeidas", noLeidas);
        request.setAttribute("peticiones", peticiones);
        rd = this.getServletContext().getRequestDispatcher("/notificaciones.jsp");
        rd.forward(request, response);
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
