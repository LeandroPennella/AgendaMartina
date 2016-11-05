package model;

import java.util.HashSet;
import java.util.Set;

public class Usuario {

	
	private int id;
	private String nombreUSR;
	private String password;
	private String nombreREAL;
	private String apellido;
	private String idioma;	
	private Set<Invitacion> invitaciones = new HashSet<Invitacion>();
	private boolean hayError = false;
	private int semana = 0;
	
	///GETTERS y SETTERS
	
	public boolean isHayError() {
		return hayError;
	}
	public void setHayError(boolean hayError) {
		this.hayError = hayError;
	}
	
	public int getSemana() {
		return semana;
	}
	public void setSemana(int semana) {
		this.semana = semana;
	}
	public Set<Invitacion> getInvitaciones() {
		return invitaciones;
	}
	public void setInvitaciones(Set<Invitacion> invitaciones) {
		this.invitaciones = invitaciones;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombreUSR() {
		return nombreUSR;
	}
	public void setNombreUSR(String nombreUSR) {
		this.nombreUSR = nombreUSR;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNombreREAL() {
		return nombreREAL;
	}
	public void setNombreREAL(String nombreREAL) {
		this.nombreREAL = nombreREAL;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getIdioma() {
		return idioma;
	}
	public void setIdioma(String idioma) {
		this.idioma = idioma;
	}


	
	///METODOS SOBREESCRITOS
	@Override
	public String toString() {
		return "Usuario [id=" + id + ", nombreUSR=" + nombreUSR + ", password=" + password + ", nombreREAL="
				+ nombreREAL + ", apellido=" + apellido + ", idioma=" + idioma + "]";
	}	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((apellido == null) ? 0 : apellido.hashCode());
		result = prime * result + ((idioma == null) ? 0 : idioma.hashCode());
		result = prime * result + ((nombreREAL == null) ? 0 : nombreREAL.hashCode());
		result = prime * result + ((nombreUSR == null) ? 0 : nombreUSR.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Usuario other = (Usuario) obj;
		if (apellido == null) {
			if (other.apellido != null)
				return false;
		} else if (!apellido.equals(other.apellido))
			return false;
		if (idioma == null) {
			if (other.idioma != null)
				return false;
		} else if (!idioma.equals(other.idioma))
			return false;
		if (nombreREAL == null) {
			if (other.nombreREAL != null)
				return false;
		} else if (!nombreREAL.equals(other.nombreREAL))
			return false;
		if (nombreUSR == null) {
			if (other.nombreUSR != null)
				return false;
		} else if (!nombreUSR.equals(other.nombreUSR))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		return true;
	}

	///CONSRTUCTOR
	public Usuario() {

	}
}
