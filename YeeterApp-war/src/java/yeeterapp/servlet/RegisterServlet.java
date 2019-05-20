/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.servlet;

import java.io.IOException;
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
import yeeterapp.ejb.UsuarioFacade;
import yeeterapp.entity.Usuario;

/**
 *
 * @author alec
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/Register"})
public class RegisterServlet extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

    private static final String INVALID_FIELD = "is-invalid";
    
    
    
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
        boolean error = false;
        String fieldsThatFail = "";
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        RequestDispatcher rd;
        
        boolean usernameAvailable = this.usernameAvailable(username);
        
        if(checkIfUsernameIsInvalid(username) || !usernameAvailable) {
            if(!usernameAvailable) {
                request.setAttribute("userError", "El nombre de usuario ya existe");
            } else {
                request.setAttribute("userError", "El usuario contiene caracteres especiales o es menor que 6");
            }
            fieldsThatFail = "user";
            error = true;
        }
        
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");
        
        if(!password1.equals(password2) || password1.length() < 6) {
            error = true;
            fieldsThatFail += "pass";
        }
        
        String email = request.getParameter("email");
        
        if(!emailIsAvailable(email)) {
            error = true;
            fieldsThatFail += "email";
        }
        
        String bio = request.getParameter("bio");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String birthSTR = request.getParameter("birth");
        Date birth = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            birth = sdf.parse(birthSTR);
        } catch (ParseException ex) {
            error = true;
            fieldsThatFail += "date";
        }
        
        if(error) {
            request.setAttribute("lastUsername", username);
            request.setAttribute("lastEmail", email);
            request.setAttribute("lastBio", bio);
            request.setAttribute("lastName", name);
            request.setAttribute("lastSurname", surname);
            request.setAttribute("fields", fieldsThatFail);
            rd = this.getServletContext().getRequestDispatcher("/register.jsp");
            rd.forward(request, response);

        }
        
        Usuario user = new Usuario();
        
        
        user.setUsername(username);
        user.setPassword(password1);
        user.setBiografia(bio);
        user.setNombre(name);
        user.setFechaNacimiento(birth);
        user.setApellidos(surname);
        user.setCorreo(email);
        if(!error) {
            usuarioFacade.create(user);
        }
        
        request.setAttribute("registerCompleted", "Usuario creado correctamente");
        rd = this.getServletContext().getRequestDispatcher("/login.jsp");
        rd.forward(request, response);
    }
    
    private boolean checkIfUsernameIsInvalid(String username) {
        Pattern pattern = Pattern.compile("[^A-Za-z0-9]", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(username);
        return username.length() < 5 || matcher.find();
    }
    
    private boolean usernameAvailable(String username) {
        return usuarioFacade.queryUserByUsername(username) == null;
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

    private boolean emailIsAvailable(String email) {
        return usuarioFacade.queryUserByEmail(email) == null;
    }

}
