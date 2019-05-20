/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.ejb;

import java.util.List;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import yeeterapp.entity.Post;

/**
 *
 * @author jugr9
 */
@Stateless
public class PostFacade extends AbstractFacade<Post> {
    
    private static final Logger LOG = Logger.getLogger(UsuarioFacade.class.getName());

    @PersistenceContext(unitName = "YeeterApp-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PostFacade() {
        super(Post.class);
    }
     public Post queryPost(String post) {
        Query q = this.em.createNamedQuery("Post.findAll");
        q.setParameter("post", post);
        return (Post) q.getResultList();
    }

    public List<Post> queryGroupFeed(int idGroup){
        Query q = this.em.createNamedQuery("Post.findByIdGrupo");
        q.setParameter("idGroup", idGroup);
        return q.getResultList();
    }
}
