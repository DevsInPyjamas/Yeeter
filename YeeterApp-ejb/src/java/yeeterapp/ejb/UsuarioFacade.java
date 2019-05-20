/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.ejb;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import yeeterapp.entity.Post;
import yeeterapp.entity.Usuario;

/**
 *
 * @author jugr9
 */
@Stateless
public class UsuarioFacade extends AbstractFacade<Usuario> {
    
    private static final Logger LOG = Logger.getLogger(UsuarioFacade.class.getName());


    @PersistenceContext(unitName = "YeeterApp-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioFacade() {
        super(Usuario.class);
    }

    public Usuario queryUserByEmail(String email) {
        Query q = this.em.createNamedQuery("Usuario.findByCorreo");
        q.setParameter("correo", email);
        try {
            return (Usuario) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }

    public Usuario queryUserByUsername(String username) {
        Query q = this.em.createNamedQuery("Usuario.findByUsername");
        q.setParameter("username", username);
        try {
            return (Usuario) q.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }

    public List<Post> queryUserFeed(Integer id) {
        Query q = this.em.createNativeQuery("select * from (\n" +
                "select * from Post where idAutor = ?1\n" +
                "\n" +
                "union\n" +
                "\n" +
                "select * from Post where idGrupo in (Select Grupo.id from Grupo Left Join USUARIO_PERTENECE_GRUPO ON Grupo.id = USUARIO_PERTENECE_GRUPO.idGrupo Left Join \n" +
                " Usuario ON Usuario.id = USUARIO_PERTENECE_GRUPO.idUsuario where usuario.id = ?1)\n" +
                " \n" +
                " union\n" +
                " \n" +
                " select * from Post where idAutor in (select idAmigo from Amigos where ?1 = Amigos.idUsuario)\n" +
                " and idGrupo is null) xd order by xd.fecha_publicacion desc\n" +
                " ;", Post.class);
       q.setParameter(1, id);
       try {
           return q.getResultList();
       } catch(NoResultException e) {
           LOG.log(Level.WARNING, "Se ha producido una excepción", e.getLocalizedMessage());
           return null;
       }
    }

    public List<Usuario> queryUserByUsernameOrName(String input) {
        Query q = this.em.createNamedQuery("Usuario.findByNameOrUsername");
        input = "%" + input + "%"; // Esta linea no estoy seguro de si habría que ponerla o no la verdad
        q.setParameter("input", input);
        try {
            return (List<Usuario>) q.getResultList();
        } catch(NoResultException r) {
            return null;
        }
    }
    
    
    
    
    
}
