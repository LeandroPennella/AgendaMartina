package controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;


import dao.EventoDao;
import model.Agenda;
import model.Evento;
import model.EventoPrivado;
import model.Invitacion;
import model.Usuario;


@Controller
@SessionAttributes({"usuario"})
public class AgendaController {
	private EventoDao eventoDao;

	@Autowired
	public void setEventDao(EventoDao eventoDao) {
		this.eventoDao = eventoDao;
	}
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
	@RequestMapping(value = "/cargarAgenda", method = RequestMethod.GET)
	public ModelAndView redirectToMainCalendar1(HttpServletRequest req, HttpServletResponse res,
												ModelMap model, @RequestParam int semana) throws ParseException {
	
	System.out.println("\n AgendaController - cargarAgenda \n");

	ModelAndView mv = new ModelAndView("/views/agenda.jsp");
	
	Agenda semanal = new Agenda();
	
	//Declaraciones
	Usuario usr = (Usuario)req.getSession().getAttribute("usuario");
	Calendar c = Calendar.getInstance();
	SimpleDateFormat f = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat f2 = new SimpleDateFormat("yyyyMMdd");	
	
	usr.setSemana(usr.getSemana() + (semana * 7));		
	
	c.add(Calendar.DAY_OF_WEEK, usr.getSemana());
		
	c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		Date fechaInicio = c.getTime();
	c.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		Date fechaFin = c.getTime();
	
		
	c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
	semanal.setFechasSemana(f.format(c.getTime()));
	c.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
	semanal.setFechasSemana(f.format(c.getTime()));
	c.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
	semanal.setFechasSemana(f.format(c.getTime()));
	c.set(Calendar.DAY_OF_WEEK, Calendar.THURSDAY);
	semanal.setFechasSemana(f.format(c.getTime()));
	c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
	semanal.setFechasSemana(f.format(c.getTime()));
	c.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
	semanal.setFechasSemana(f.format(c.getTime()));
	c.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
	semanal.setFechasSemana(f.format(c.getTime()));
	
	
	model.addAttribute("fechasSemana",semanal.getFechasSemana());
	model.addAttribute("nombresDia",semanal.getNombresDia());
	model.addAttribute("hoy",f.format(new Date()));
	
	List<Evento> eventosTodos = eventoDao.getTodosCONFECHA(usr, f2.format(fechaInicio),f2.format(fechaFin));
	
	
	for (Evento e : eventosTodos) {
		
		if(e.getClass() == EventoPrivado.class){
			e.setEstado("Privado");
		}else{
			if(e.getUsuario().getId() == usr.getId()){
				e.setEstado("Confirmado");
			}else{
				Invitacion inv = eventoDao.getInvitacion(usr, e);
				e.setEstado(inv.getEstado());
			}
		}
		
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(e.getFecha());
		
		e.setStrFecha(f.format(e.getFecha()));
		e.setDuracion(calcularDuracion(e));
		e.setPosicion(getPosicion(e));
		
		String diaSem = new SimpleDateFormat("EEEE").format(e.getFecha());
		
		
		agregarEventoADia(diaSem,e, semanal);
		
		
	}
	
	List<List<Evento>> eventosXDia = new ArrayList<List<Evento>>();
	eventosXDia.add(semanal.getMapaDiaEvento().get("lunes"));
	eventosXDia.add(semanal.getMapaDiaEvento().get("martes"));
	eventosXDia.add(semanal.getMapaDiaEvento().get("miércoles"));
	eventosXDia.add(semanal.getMapaDiaEvento().get("jueves"));
	eventosXDia.add(semanal.getMapaDiaEvento().get("viernes"));
	eventosXDia.add(semanal.getMapaDiaEvento().get("sábado"));
	eventosXDia.add(semanal.getMapaDiaEvento().get("domingo"));

	
	mv.addObject("listaHorarios", cargarHorarios());
	mv.addObject("eventosXDia", eventosXDia);
	

	
	System.out.println("EVENTOS Por DIA -->" + eventosXDia);
	return mv;	

}

	public List<String> cargarHorarios(){
		
		List<String> horarios = new ArrayList<String>();
		
		String inicio = "00:00";
		
		
		for(int min=0; min < 1440; min +=30){
			
			int h = min / 60 + Integer.valueOf(inicio.substring(0,1));
			int m = min % 60 + Integer.valueOf(inicio.substring(3,4));
			String newtime = String.format("%02d", h) + ":" + String.format("%02d", m);
			
			horarios.add(newtime);
		}		
		horarios.add("23:59");
		return horarios;		
	}
	
	public int calcularDuracion(Evento e) throws ParseException {

		int duracion = 0;
		DateFormat hora = new SimpleDateFormat("HH:mm");

		Iterator<String> i = cargarHorarios().iterator();
		while (i.hasNext()) {
			String celda = i.next();
			
			if (hora.parse(celda).compareTo(hora.parse(e.getHoraInicio().getHours() +":"+ e.getHoraInicio().getMinutes())) >= 0
					&& hora.parse(celda).compareTo(hora.parse( e.getHoraFin().getHours() +":"+ e.getHoraFin().getMinutes())) < 0) {
				duracion++;
			}	
		}
		System.out.println("DURACION de " +e.getNombre() + "-->" + duracion);
		return duracion;

	}
	
	public int getPosicion(Evento e) throws ParseException {

		int posicion = 0;

		DateFormat hora = new SimpleDateFormat("HH:mm");

		Iterator<String> i = cargarHorarios().iterator();
		while (i.hasNext()) {
			String celda = i.next();
			if (hora.parse(celda).compareTo(hora.parse(e.getHoraInicio().getHours() +":"+ e.getHoraInicio().getMinutes())) < 0 ){
				posicion++;
			}
		}
		System.out.println("POSICION de " +e.getNombre() + "-->" + posicion);
		return posicion;

	}
	
	public void agregarEventoADia(String diaEvento, Evento evento, Agenda agenda) {

		System.out.println("DIA de " +evento.getNombre() + "-->" + diaEvento);
		
		Iterator<String> i = agenda.getMapaDiaEvento().keySet().iterator();
		
		while (i.hasNext()) {
			String dayName = i.next();
		
			if (dayName.equals(diaEvento)) {
				agenda.getMapaDiaEvento().get(dayName).add(evento);	
			}
		}
	}
}
