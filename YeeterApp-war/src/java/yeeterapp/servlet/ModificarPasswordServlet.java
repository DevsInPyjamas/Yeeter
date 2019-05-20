/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author leonardobruno
 */
@WebServlet(name = "ModificarPasswordServlet", urlPatterns = {"/ModificarPasswordServlet"})
public class ModificarPasswordServlet extends HttpServlet {

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
        RequestDispatcher rd;
        String fieldsThatFail = "";
        Integer idLoggedUser = (Integer) session.getAttribute("loggedUserID");
        
        boolean error = false;
        Usuario user=null;
        
        if(idLoggedUser == null) {
            rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            request.setAttribute("error", "Por favor inicie sesión primero.");
            rd.forward(request, response);
        }
        
        try{
            int str=Integer.valueOf(request.getParameter("id"));
            user=this.usuarioFacade.find(str);
            String oldPassword = request.getParameter("oldPassword");
            
            if(!oldPassword.equals(user.getPassword())){
               error=true; 
               fieldsThatFail += "oldPass";
            }
            
            String password1 = request.getParameter("password1");
            String password2 = request.getParameter("password2");

            if(!password1.equals(password2) || password1.length() < 6) {
                error = true;
                fieldsThatFail += "pass";
            }
            
            if(error){
                request.setAttribute("fields", fieldsThatFail);
                rd = this.getServletContext().getRequestDispatcher("/modificarPassword.jsp");
                rd.forward(request, response);
            }else{
                user.setPassword(password2);
                usuarioFacade.edit(user);
                request.setAttribute("usuario", user);
                rd = this.getServletContext().getRequestDispatcher("/panelUser.jsp");
                rd.forward(request, response);
            }
            
            
            
        }catch(Exception ex){
            user=usuarioFacade.find(idLoggedUser);
            session.setAttribute("loggedUser", user);
            rd = this.getServletContext().getRequestDispatcher("/modificarPassword.jsp");
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
