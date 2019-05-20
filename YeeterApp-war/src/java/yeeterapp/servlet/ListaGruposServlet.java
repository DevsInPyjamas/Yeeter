/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.Grupo;
import yeeterapp.entity.Usuario;


/**
 *
 * @author leonardobruno
 */
@WebServlet(name = "ListaGruposServlet", urlPatterns = {"/ListaGruposServlet"})
public class ListaGruposServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            RequestDispatcher rd;
            HttpSession session = request.getSession();

            int todos=0;
            int str=0;
            Usuario us=null;

            str = Integer.valueOf(request.getParameter("id"));
            us = this.usuarioFacade.find(str);
            
            Integer idLoggedUser = (Integer) session.getAttribute("loggedUserID");
            Usuario loggedUser;
            if(idLoggedUser == null) {
                rd = this.getServletContext().getRequestDispatcher("/login.jsp");
                request.setAttribute("error", "Por favor inicie sesión primero.");
                rd.forward(request, response);
            } 
            loggedUser = usuarioFacade.find(idLoggedUser);
            
            request.setAttribute("mensaje", request.getAttribute("mensaje"));
            List<Grupo> usGrupo = loggedUser.getGrupoList();
            List<Grupo> grupos = this.grupoFacade.findAll();
            
            
            
            request.setAttribute("usuario", us);
            request.setAttribute("usuariosGrupos", usGrupo);
            request.setAttribute("grupos", grupos);
            request.setAttribute("todos", todos);
            
            rd = this.getServletContext().getRequestDispatcher("/listaGrupos.jsp");
            rd.forward(request, response);
            
        }
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
