package model;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;



public class Agenda {

	List<String> fechasSemana = new ArrayList<String>();
	List<String> nombresDia = new ArrayList<String>();
	Map<String, List<Evento>> mapaDiaEvento = new LinkedHashMap<String, List<Evento>>();
	List<Evento> lunes = new ArrayList<Evento>();
	List<Evento> martes = new ArrayList<Evento>();
	List<Evento> miércoles = new ArrayList<Evento>();
	List<Evento> jueves = new ArrayList<Evento>();
	List<Evento> viernes = new ArrayList<Evento>();
	List<Evento> sábado = new ArrayList<Evento>();
	List<Evento> domingo = new ArrayList<Evento>();
	
	
	
	///GETTERS Y SETTERS	
	
	public List<String> getFechasSemana() {
		return fechasSemana;
	}
	public void setFechasSemana(String fecha) {
		fechasSemana.add(fecha);
	}
	
	public List<String> getNombresDia() {
		return nombresDia;
	}
	public void setNombresDia(List<String>nombresDia) {
		this.nombresDia = nombresDia;
	}
	
	public Map<String, List<Evento>> getMapaDiaEvento() {
		return mapaDiaEvento;
	}
	public void setMapaDiaEvento(Map<String, List<Evento>> dias) {
		this.mapaDiaEvento = dias;
	}
	
	
///CONSTRUCTOR
	public Agenda() {

		nombresDia.add("Lunes");
		nombresDia.add("Martes");
		nombresDia.add("Miercoles");
		nombresDia.add("Jueves");
		nombresDia.add("Viernes");
		nombresDia.add("Sabado");
		nombresDia.add("Domingo");

		mapaDiaEvento.put("lunes", lunes);
		mapaDiaEvento.put("martes", martes);
		mapaDiaEvento.put("miércoles", miércoles);
		mapaDiaEvento.put("jueves", jueves);
		mapaDiaEvento.put("viernes", viernes);
		mapaDiaEvento.put("sábado", sábado);
		mapaDiaEvento.put("domingo", domingo);	
		
	}
	
	
	
	
}
