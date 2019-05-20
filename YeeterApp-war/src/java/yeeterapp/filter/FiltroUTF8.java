/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * Solución obtenida de https://github.com/melchor629/AplicacionTecnologiasWeb/blob/6449bb0e2c9ffd17b06e62b56f292a146c12404a/web/web/registro.jsp#L42
 * Filtro que captura todos los request para fijar el character encoding como
 * UTF8 y asi evitar problemas con las tildes
 * Ademas añade comodidad ya que en los servlets se puede obtener directamente la cadena
 * que el navegador envia como UTF8 sin tener que hacer la conversion desde ISO (getBytes...).
 *
 * @author alec
 */
@WebFilter(filterName = "FiltroUTF8", urlPatterns = {"/*"})
public class FiltroUTF8 implements Filter {

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public FiltroUTF8() {
    }

    private void doBeforeProcessing(ServletRequest request) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
    }

    /**
     * @param request  The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain    The filter chain we are processing
     * @throws IOException      if an input/output error occurs
     * @throws ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        doBeforeProcessing(request);
        chain.doFilter(request, response);
    }

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("FiltroUTF8()");
        }
        return "FiltroUTF8(" + filterConfig + ")";
    }

}