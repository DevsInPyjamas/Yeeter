/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package yeeterapp.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author jugr9
 */
@Embeddable
public class PeticionAmistadPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "usuarioEmisor")
    private int usuarioEmisor;
    @Basic(optional = false)
    @NotNull
    @Column(name = "usuarioReceptor")
    private int usuarioReceptor;

    public PeticionAmistadPK() {
    }

    public PeticionAmistadPK(int usuarioEmisor, int usuarioReceptor) {
        this.usuarioEmisor = usuarioEmisor;
        this.usuarioReceptor = usuarioReceptor;
    }

    public int getUsuarioEmisor() {
        return usuarioEmisor;
    }

    public void setUsuarioEmisor(int usuarioEmisor) {
        this.usuarioEmisor = usuarioEmisor;
    }

    public int getUsuarioReceptor() {
        return usuarioReceptor;
    }

    public void setUsuarioReceptor(int usuarioReceptor) {
        this.usuarioReceptor = usuarioReceptor;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) usuarioEmisor;
        hash += (int) usuarioReceptor;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PeticionAmistadPK)) {
            return false;
        }
        PeticionAmistadPK other = (PeticionAmistadPK) object;
        if (this.usuarioEmisor != other.usuarioEmisor) {
            return false;
        }
        if (this.usuarioReceptor != other.usuarioReceptor) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "yeeterapp.entity.PeticionAmistadPK[ usuarioEmisor=" + usuarioEmisor + ", usuarioReceptor=" + usuarioReceptor + " ]";
    }
    
}
