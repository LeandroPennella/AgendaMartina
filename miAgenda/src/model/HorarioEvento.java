package model;

public class HorarioEvento {

	private Integer idEvento;
	private Integer nuevaPosicion;
	private Integer duracion;
	
	//GETTERS AND SETTERS
	public Integer getIdEvento() {
		return idEvento;
	}
	public void setIdEvento(Integer idEvento) {
		this.idEvento = idEvento;
	}
	public Integer getNuevaPosicion() {
		return nuevaPosicion;
	}
	public void setNuevaPosicion(Integer nuevaPosicion) {
		this.nuevaPosicion = nuevaPosicion;
	}
	public Integer getDuracion() {
		return duracion;
	}
	public void setDuracion(Integer duracion) {
		this.duracion = duracion;
	}
	
	
	//CONSTRUCTOR
	public HorarioEvento(Integer idEvento, Integer nuevaPosicion, Integer duracion) {
		super();
		this.idEvento = idEvento;
		this.nuevaPosicion = nuevaPosicion;
		this.duracion = duracion;
	}
	
	
}
