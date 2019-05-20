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
import yeeterapp.ejb.PeticionAmistadFacade;
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.PeticionAmistad;
import yeeterapp.entity.PeticionAmistadPK;
import yeeterapp.entity.Usuario;

/**
 *
 * @author alec
 */
@WebServlet(name = "AceptarPeticionServlet", urlPatterns = {"/AceptarPeticionServlet"})
public class AceptarPeticionServlet extends HttpServlet {

    @EJB
    private PeticionAmistadFacade peticionAmistadFacade;

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
        int id = new Integer(request.getParameter("id"));
        Integer idLoggedUser = (Integer) session.getAttribute("loggedUserID");
        RequestDispatcher rd;
        Usuario loggedUser, profileUser;
        if(idLoggedUser == null) {
            rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            request.setAttribute("error", "Por favor inicie sesión primero.");
            rd.forward(request, response);
        } 
        loggedUser = usuarioFacade.find(idLoggedUser);    
        
        PeticionAmistadPK pk = new PeticionAmistadPK();
        pk.setUsuarioEmisor(id);
        pk.setUsuarioReceptor(idLoggedUser);
        PeticionAmistad pa = peticionAmistadFacade.find(pk);
        
        profileUser = usuarioFacade.find(id);
        
        List<Usuario> amigos = loggedUser.getUsuarioList1();
        amigos.add(profileUser);
        usuarioFacade.edit(loggedUser);
        amigos = profileUser.getUsuarioList1();
        amigos.add(loggedUser);
        usuarioFacade.edit(profileUser);
        
        peticionAmistadFacade.remove(pa);
        request.setAttribute("message", "petición aceptada");
        request.setAttribute("id", id);
        rd = this.getServletContext().getRequestDispatcher("/panelUserServlet");
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
