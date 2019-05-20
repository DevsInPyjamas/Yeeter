/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
@WebServlet(name = "ModificarPerfilServlet", urlPatterns = {"/ModificarPerfilServlet"})
public class ModificarPerfilServlet extends HttpServlet {

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
        boolean error = false;
        Usuario user=null;
        
        Integer idLoggedUser = (Integer) session.getAttribute("loggedUserID");
        
        if(idLoggedUser == null) {
            rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            request.setAttribute("error", "Por favor inicie sesión primero.");
            rd.forward(request, response);
        }
        
        try{
            int str=Integer.valueOf(request.getParameter("id"));
            String userName=request.getParameter("username");
            String name=request.getParameter("name");
            String apell=request.getParameter("surname");
            String correo=request.getParameter("email");
            String bio=request.getParameter("bio");
            String fechaNacimiento=request.getParameter("birth");
            String pass=request.getParameter("pass");
            
            if(checkIfUsernameIsInvalid(userName)) {               
                fieldsThatFail = "user";
                error = true;
            }
            
            if(!checkIfEmailIsValid(correo)){
                fieldsThatFail = "email";
                error = true;
            }
            
            
            Date birth = null;
            
            if(!checkIfDateIsValid(fechaNacimiento)){
                fieldsThatFail = "date";
                error = true;
            }
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                birth = sdf.parse(fechaNacimiento);
            } catch (ParseException ex) {
                error = true;
                fieldsThatFail += "date";
            }
            
            if(error) {
                request.setAttribute("lastUsername", userName);
                request.setAttribute("lastEmail", correo);
                request.setAttribute("lastBio", bio);
                request.setAttribute("lastName", name);
                request.setAttribute("lastSurname", apell);
                request.setAttribute("fields", fieldsThatFail);
                rd = this.getServletContext().getRequestDispatcher("/modificarPerfil.jsp");
                rd.forward(request, response);

            }
            
            user = new Usuario();
        
        
            user.setUsername(userName);
            user.setBiografia(bio);
            user.setNombre(name);
            user.setFechaNacimiento(birth);
            user.setApellidos(apell);
            user.setCorreo(correo);
            user.setPassword(pass);
            user.setId(str);
            if(!error) {
                usuarioFacade.edit(user);
            }

            request.setAttribute("usuario", user);
            rd = this.getServletContext().getRequestDispatcher("/panelUser.jsp");
            rd.forward(request, response);
            
        }catch(Exception e){
            user=usuarioFacade.find(idLoggedUser);
            request.setAttribute("lastUsername", user.getUsername());
            request.setAttribute("lastEmail", user.getCorreo());
            request.setAttribute("lastBio", user.getBiografia());
            request.setAttribute("lastName", user.getNombre());
            request.setAttribute("lastSurname", user.getApellidos());
            request.setAttribute("fechaNacimiento", user.getFechaNacimiento());
            request.setAttribute("password", user.getPassword());
            request.setAttribute("fields", fieldsThatFail);
            rd = this.getServletContext().getRequestDispatcher("/modificarPerfil.jsp");
            rd.forward(request, response);
        }
   
    }
    
    private boolean checkIfUsernameIsInvalid(String username) {
        Pattern pattern = Pattern.compile("[^A-Za-z0-9]", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(username);
        return username.length() < 5 || matcher.find();
    }
    
    private boolean checkIfEmailIsValid(String correo){
        Pattern pattern = Pattern
                .compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                        + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
        Matcher mather = pattern.matcher(correo);
        return mather.find();

    }
    
    private boolean checkIfDateIsValid(String fecha){
        String[] date=fecha.split("-");

        return date.length==3 && date[0].length()==2 && date[1].length()==2 && date[2].length()==4
                && Integer.valueOf(date[0]) > 0
                && Integer.valueOf(date[1]) > 0
                && Integer.valueOf(date[2]) > 1900
                && Integer.valueOf(date[0]) <= 31
                && Integer.valueOf(date[1]) <= 12
                && Integer.valueOf(date[2]) < 2100;
                
        
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
