package model;

import java.util.Date;

public abstract class Evento {

	private int id;
	private int idUsuario;
	private String nombre;
	private Date fecha;
	private Date horaInicio;
	private Date horaFin;
	private Usuario usuario;

	private String strFecha;
	private String strHoraInicio;
	private String strHoraFin;
	private String estado;
	
	private int posicion;
	private int duracion;

///GETTERS Y SETTERS 

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getNombre() {
		return nombre;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public Date getHoraInicio() {
		return horaInicio;
	}

	public void setHoraInicio(Date horaInicio2) {
		this.horaInicio = horaInicio2;
	}

	public Date getHoraFin() {
		return horaFin;
	}

	public void setHoraFin(Date horaFin) {
		this.horaFin = horaFin;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	private boolean hayError = false;
	
	public boolean isHayError() {
		return hayError;
	}

	public void setHayError(boolean hayError) {
		this.hayError = hayError;
	}

	public String getStrFecha() {
		return strFecha;
	}

	public void setStrFecha(String strFecha) {
		this.strFecha = strFecha;
	}

	public String getStrHoraInicio() {
		return strHoraInicio;
	}

	public void setStrHoraInicio(String strHoraInicio) {
		this.strHoraInicio = strHoraInicio;
	}

	public String getStrHoraFin() {
		return strHoraFin;
	}

	public void setStrHoraFin(String strHoraFin) {
		this.strHoraFin = strHoraFin;
	}

	public int getPosicion() {
		return posicion;
	}

	public void setPosicion(int posicion) {
		this.posicion = posicion;
	}

	public int getDuracion() {
		return duracion;
	}

	public void setDuracion(int duracion) {
		this.duracion = duracion;
	}
	
	//// HASH EQUALS

	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + duracion;
		result = prime * result + ((estado == null) ? 0 : estado.hashCode());
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + (hayError ? 1231 : 1237);
		result = prime * result + ((horaFin == null) ? 0 : horaFin.hashCode());
		result = prime * result + ((horaInicio == null) ? 0 : horaInicio.hashCode());
		result = prime * result + id;
		result = prime * result + idUsuario;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		result = prime * result + posicion;
		result = prime * result + ((strFecha == null) ? 0 : strFecha.hashCode());
		result = prime * result + ((strHoraFin == null) ? 0 : strHoraFin.hashCode());
		result = prime * result + ((strHoraInicio == null) ? 0 : strHoraInicio.hashCode());
		result = prime * result + ((usuario == null) ? 0 : usuario.hashCode());
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
		Evento other = (Evento) obj;
		if (duracion != other.duracion)
			return false;
		if (estado == null) {
			if (other.estado != null)
				return false;
		} else if (!estado.equals(other.estado))
			return false;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		if (hayError != other.hayError)
			return false;
		if (horaFin == null) {
			if (other.horaFin != null)
				return false;
		} else if (!horaFin.equals(other.horaFin))
			return false;
		if (horaInicio == null) {
			if (other.horaInicio != null)
				return false;
		} else if (!horaInicio.equals(other.horaInicio))
			return false;
		if (id != other.id)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (posicion != other.posicion)
			return false;
		if (strFecha == null) {
			if (other.strFecha != null)
				return false;
		} else if (!strFecha.equals(other.strFecha))
			return false;
		if (strHoraFin == null) {
			if (other.strHoraFin != null)
				return false;
		} else if (!strHoraFin.equals(other.strHoraFin))
			return false;
		if (strHoraInicio == null) {
			if (other.strHoraInicio != null)
				return false;
		} else if (!strHoraInicio.equals(other.strHoraInicio))
			return false;
		if (usuario == null) {
			if (other.usuario != null)
				return false;
		} else if (!usuario.equals(other.usuario))
			return false;
		return true;
	}

	
	
	@Override
	public String toString() {
		return "Evento [id=" + id + ", idUsuario=" + idUsuario + ", nombre=" + nombre + ", fecha=" + fecha
				+ ", horaInicio=" + horaInicio + ", horaFin=" + horaFin + ", usuario=" + usuario + ", strFecha="
				+ strFecha + ", strHoraInicio=" + strHoraInicio + ", strHoraFin=" + strHoraFin + ", estado=" + estado
				+ ", posicion=" + posicion + ", duracion=" + duracion + ", hayError=" + hayError + "]";
	}

	
	///CONSTRUCTOR
	public Evento() {
	
	}

	
	
}
