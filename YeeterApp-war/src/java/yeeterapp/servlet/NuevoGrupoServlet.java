/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
import java.util.Date;
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
import yeeterapp.entity.Usuario;
import yeeterapp.entity.Grupo;

/**
 *
 * @author jesus
 */
@WebServlet(name = "NuevoGrupoServlet", urlPatterns = {"/NuevoGrupoServlet"})
public class NuevoGrupoServlet extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

    @EJB
    private GrupoFacade grupoFacade;

    
    
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
        
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        
        Grupo grupo = new Grupo();
        grupo.setNombre(nombre);
        grupo.setIdCreador(loggedUser);
        grupo.setDescripcion(descripcion);
        Date date = new java.util.Date(System.currentTimeMillis());
        grupo.setFechaCreacion(date);
        
        grupoFacade.create(grupo);
               
        response.sendRedirect("ListaGruposServlet?mensaje=Grupo creado correctamente");
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
