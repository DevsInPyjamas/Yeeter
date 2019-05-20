/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import yeeterapp.entity.Mensaje;
import yeeterapp.entity.Usuario;

/**
 *
 * @author jugr9
 */
@Stateless
public class MensajeFacade extends AbstractFacade<Mensaje> {

    @PersistenceContext(unitName = "YeeterApp-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MensajeFacade() {
        super(Mensaje.class);
    }
    public List<Mensaje> queryByID (Integer id) {
       Query q = this.em.createNamedQuery("Mensaje.findById");
       q.setParameter("id", id);
       try {
           return q.getResultList();
       } catch(NoResultException e) {
           return null;
       }
   }
    
    public List<Mensaje> queryMensajesAmigos (int idEmisor, int idReceptor) {
        Query q = this.em.createNamedQuery("Mensaje.findByIdEmisorIdReceptor");
        q.setParameter("idReceptor", idReceptor);
        q.setParameter("idEmisor", idEmisor);
        try {
            return (List) q.getResultList();
        } catch(NoResultException e) {
            return null;
        }
    }
    public List<Mensaje> queryfindByUserMensageList(int userID) {
        Query q = this.em.createNamedQuery("Mensaje.findByUserMensageList");
        
        q.setParameter("userID",userID );
        try {
            return (List) q.getResultList();
        } catch(NoResultException e) {
            return null;
        }
    }
    public List<Mensaje> queryfindByEmisor(Usuario idEmisor) {
        Query q = this.em.createNamedQuery("Mensaje.findByIdEmisor");
        
        q.setParameter("idEmisor",idEmisor );
        try {
            return (List) q.getResultList();
        } catch(NoResultException e) {
            return null;
        }
    }
     public List<Mensaje> queryfindByReceptor(Usuario idReceptor) {
        Query q = this.em.createNamedQuery("Mensaje.findByIdReceptor");
        
        q.setParameter("idReceptor",idReceptor );
        try {
            return (List) q.getResultList();
        } catch(NoResultException e) {
            return null;
        }
    }
}
