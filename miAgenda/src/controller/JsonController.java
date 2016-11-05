package controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import dao.EventoDao;
import dao.UsuarioDao;
import model.Evento;
import model.Usuario;

@Controller
@SessionAttributes({"usuario"})
public class JsonController {

	private UsuarioDao usuarioDao;
	private EventoDao eventoDao;

	@Autowired
	public void setEventoDao(EventoDao eventoDao) {
		this.eventoDao = eventoDao;
	}

	@Autowired
	public void setUsuarioDao(UsuarioDao usuarioDao) {
		this.usuarioDao = usuarioDao;
	}

	@RequestMapping(value = "/coincidenciasUSR/{param}")
	public @ResponseBody List<Usuario> coincidenciasUSR(@PathVariable String param,
			@ModelAttribute("usuario") Usuario usr) {
		System.out.println("------->" + usr + "   PARAM: " + param);
		List<Usuario> lista = usuarioDao.coincidencias(param, usr.getId());

		return lista;
	}


	@RequestMapping(value = "/cambiarHorario3/{idEv}")
	public @ResponseBody void cambiarHorario3(@PathVariable String idEv, HttpServletResponse res, HttpServletRequest req) {
		
	System.out.println("idEv: " + idEv);

		int idEvento = Integer.parseInt( idEv.substring(0, idEv.indexOf("-")));
		int nuevoInicio = Integer.parseInt( idEv.substring(idEv.indexOf("-")+1, idEv.indexOf("*")));
		int nuevaDuracion = Integer.parseInt( idEv.substring(idEv.indexOf("*")+1));
		
		
		System.out.println("idEvento: " + idEvento);
		System.out.println("nuevoInicio: " + nuevoInicio);
		System.out.println("nuevaDuracion: " + nuevaDuracion);
		
		Evento e = this.eventoDao.get(idEvento);
		int cont = -1;
		int duracion = -1;
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				
		Iterator<String> i = cargarHorarios().iterator();
		while (i.hasNext()) {
			String hora = i.next();
			cont++;
			if (cont >= nuevoInicio) {
				duracion++;
				if (cont == nuevoInicio) {
					try {
						e.setStrHoraInicio(hora);
						e.setHoraInicio(sdf.parse(hora));
					} catch (ParseException e1) {
						e1.printStackTrace();
					}
				} else {
					if (duracion == nuevaDuracion) {
						try {
							e.setStrHoraFin(hora);
							e.setHoraFin(sdf.parse(hora));
						} catch (ParseException e1) {
							e1.printStackTrace();
						}
					}
				}
			}			
		}
		eventoDao.update(e);
//		ModelAndView mv = new ModelAndView("redirect:/cargarAgenda.htm?semana=0");
//		return mv;
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

}
