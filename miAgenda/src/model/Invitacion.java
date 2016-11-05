package model;

public class Invitacion {

	@Override
	public String toString() {
		return "Invitacion [Id=" + Id + ", evento=" + evento + ", usuario=" + usuario + ", Estado=" + Estado + "]";
	}

	private int Id;
	private Evento evento;
	private Usuario usuario;
	private String Estado;
	
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public Evento getEvento() {
		return evento;
	}
	public void setEvento(Evento evento) {
		this.evento = evento;
	}
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public String getEstado() {
		return Estado;
	}
	public void setEstado(String Estado) {
		this.Estado = Estado;
	}
	
	
	
	
	///COSTRUCTOR
	public Invitacion() {

	}	
	
}
