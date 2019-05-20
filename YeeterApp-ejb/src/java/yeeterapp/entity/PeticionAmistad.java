/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jugr9
 */
@Entity
@Table(name = "peticion_amistad")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PeticionAmistad.findAll", query = "SELECT p FROM PeticionAmistad p")
    , @NamedQuery(name = "PeticionAmistad.findByUsuarioEmisor", query = "SELECT p FROM PeticionAmistad p WHERE p.peticionAmistadPK.usuarioEmisor = :usuarioEmisor")
    , @NamedQuery(name = "PeticionAmistad.findByUsuarioReceptor", query = "SELECT p FROM PeticionAmistad p WHERE p.peticionAmistadPK.usuarioReceptor = :usuarioReceptor")
    , @NamedQuery(name = "PeticionAmistad.findByMensaje", query = "SELECT p FROM PeticionAmistad p WHERE p.mensaje = :mensaje")})
public class PeticionAmistad implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected PeticionAmistadPK peticionAmistadPK;
    @Size(max = 255)
    @Column(name = "mensaje")
    private String mensaje;
    @JoinColumn(name = "usuarioEmisor", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Usuario usuario;
    @JoinColumn(name = "usuarioReceptor", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Usuario usuario1;

    public PeticionAmistad() {
    }

    public PeticionAmistad(PeticionAmistadPK peticionAmistadPK) {
        this.peticionAmistadPK = peticionAmistadPK;
    }

    public PeticionAmistad(int usuarioEmisor, int usuarioReceptor) {
        this.peticionAmistadPK = new PeticionAmistadPK(usuarioEmisor, usuarioReceptor);
    }

    public PeticionAmistadPK getPeticionAmistadPK() {
        return peticionAmistadPK;
    }

    public void setPeticionAmistadPK(PeticionAmistadPK peticionAmistadPK) {
        this.peticionAmistadPK = peticionAmistadPK;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Usuario getUsuario1() {
        return usuario1;
    }

    public void setUsuario1(Usuario usuario1) {
        this.usuario1 = usuario1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (peticionAmistadPK != null ? peticionAmistadPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PeticionAmistad)) {
            return false;
        }
        PeticionAmistad other = (PeticionAmistad) object;
        if ((this.peticionAmistadPK == null && other.peticionAmistadPK != null) || (this.peticionAmistadPK != null && !this.peticionAmistadPK.equals(other.peticionAmistadPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "yeeterapp.entity.PeticionAmistad[ peticionAmistadPK=" + peticionAmistadPK + " ]";
    }
    
}
