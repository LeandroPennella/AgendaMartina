package model;

import java.util.HashSet;
import java.util.Set;

public class EventoReunion extends Evento{

	private String temario;
	private int idSala;

	private Set<Invitacion> invitaciones = new HashSet<Invitacion>();
	private Set<Invitacion> invitadosSeleccionados = new HashSet<Invitacion>();
	

	///GETTERS Y SETTERS		

	public Set<Invitacion> getInvitadosSeleccionados() {
		return invitadosSeleccionados;
	}
	public void setInvitadosSeleccionados(Set<Invitacion> invitadosSeleccionados) {
		this.invitadosSeleccionados = invitadosSeleccionados;
	}
	public int getIdSala() {
		return idSala;
	}
	public void setIdSala(int idSala) {
		this.idSala = idSala;
	}

	public Set<Invitacion> getInvitaciones() {
		return invitaciones;
	}
	public void setInvitaciones(Set<Invitacion> invitaciones) {
		this.invitaciones = invitaciones;
	}


	public String getTemario() {
		return temario;
	}
	public void setTemario(String temario) {
		this.temario = temario;
	}



	
	////CONSTRUCTOR
	
	public EventoReunion() {
		super();
		
	}


	
	
}
