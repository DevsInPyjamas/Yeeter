/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
import java.util.*;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.PeticionAmistad;
import yeeterapp.entity.Usuario;

/**
 *
 * @author Juan Garcia Ruiz
 */
@WebServlet(name = "buscarAmigoServlet", urlPatterns = {"/BuscarAmigos"})
public class SearchFriendsServlet extends HttpServlet {

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
            return;
        }
        loggedUser = usuarioFacade.find(idLoggedUser);
        String input = request.getParameter("busqueda");
        List<Usuario> users = usuarioFacade.queryUserByUsernameOrName(input);
        List<Usuario> friends = loggedUser.getUsuarioList();

        if(users.isEmpty()){
            request.setAttribute("error","No existe ningún usuario que coincida con esos datos.");
        }
        
        request.setAttribute("loggedUser", loggedUser);
        request.setAttribute("users", users);
        request.setAttribute("friends", friends);
        rd = this.getServletContext().getRequestDispatcher("/buscaramigo.jsp");
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
