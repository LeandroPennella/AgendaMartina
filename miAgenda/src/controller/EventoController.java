package controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;


import dao.EventoDao;
import dao.UsuarioDao;
import model.EstadoInvitacion;
import model.Evento;
import model.EventoPrivado;
import model.EventoReunion;
import model.Invitacion;
import model.Sala;
import model.Usuario;
import validator.EventoPrivadoValidator;
import validator.EventoReunionValidator;

@Controller
@SessionAttributes({"usuario"})
public class EventoController {
	
	private EventoPrivadoValidator eventoPrivadoValidator;
	private EventoReunionValidator eventoReunionValidator;
	private EventoDao eventoDao;
	private UsuarioDao usuarioDao;		

	@Autowired
	public void setEventoPrivadoValidator(EventoPrivadoValidator eventoPrivadoValidator) {
		this.eventoPrivadoValidator = eventoPrivadoValidator;
	}

	@Autowired
	public void setEventoReunionValidator(EventoReunionValidator eventoReunionValidator) {
		this.eventoReunionValidator = eventoReunionValidator;
	}
	
	@Autowired
	public void setEventoDao(EventoDao eventoDao) {
		this.eventoDao = eventoDao;
	}		
	
	@Autowired
	public void setUsuarioDao(UsuarioDao usuarioDao) {
		this.usuarioDao = usuarioDao;
	}	
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////		
	
	@RequestMapping(value = "/evento")
	public ModelAndView evento(HttpServletRequest req) {
		System.out.println("EventoController - evento");	
		
		Usuario usuarioActual = (Usuario)req.getSession().getAttribute("usuario");
	
		ModelAndView mv = new ModelAndView("/views/nuevoEvento.jsp");
		
		mv.addObject("invitadosPosibles", usuarioDao.getTodosMenosActual(usuarioActual.getId()));
		mv.addObject("salas", eventoDao.cargarSalas());
		mv.addObject("horas", cargarHorarios());
		
		mv.addObject("eventoReunion",new EventoReunion());
		mv.addObject("eventoPrivado",new EventoPrivado());
		
		return mv;
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								//////	ABM EVENTO PRIVADO	//////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////
//////	NUEVO EVENTO PRIVADO	//////	
/////////////////////////////////////
	
		@RequestMapping(value = "/nuevoEventoPrivado", method = RequestMethod.POST)
		public ModelAndView nuevoEventoPrivado(@ModelAttribute("eventoPrivado") EventoPrivado evPrivado,
												BindingResult result, HttpServletRequest req) {
			System.out.println("nuevoEventoPrivado");

			

			this.eventoPrivadoValidator.validate(evPrivado, result);
			if (result.hasErrors()) {
				ModelAndView mv = new ModelAndView("/views/nuevoEvento.jsp");
				mv.addObject("eventoReunion",new EventoReunion());
				mv.addObject("invitadosPosibles", usuarioDao.getTodosMenosActual(((Usuario)req.getSession().getAttribute("usuario")).getId()));
				mv.addObject("salas", eventoDao.cargarSalas());
				mv.addObject("horas", cargarHorarios());
				
				evPrivado.setHayError(true);
				return mv;
			}
			
			evPrivado.setHayError(false);
		 try {
			 DateFormat formatter = new SimpleDateFormat("HH:mm");
			 Date horaInicio = formatter.parse(evPrivado.getStrHoraInicio());
			 Date horaFin = formatter.parse(evPrivado.getStrHoraFin());


			 if(horaInicio.compareTo(horaFin) > 0){
					ModelAndView mv = new ModelAndView("/views/nuevoEvento.jsp");
					mv.addObject("eventoReunion",new EventoReunion());
					
					evPrivado.setHayError(true);
					return mv;
			 }
			 
			 evPrivado.setHoraInicio(horaInicio);
			 evPrivado.setHoraFin(horaFin);

			 SimpleDateFormat formatFecha = new SimpleDateFormat("dd/MM/yyyy");
			 Date fecha = formatFecha.parse(evPrivado.getStrFecha());
			
			 evPrivado.setUsuario((Usuario)req.getSession().getAttribute("usuario"));
			 evPrivado.setFecha(fecha);
			 
		 	//GUARDO
		 	eventoDao.save(evPrivado);
		
		 } catch (ParseException e) {
			 e.printStackTrace();
			 System.out.println("ERROR AL CONVERTIR EN FORMATO HORA y FECHA");
			}		

			evPrivado.getUsuario().setSemana(0);
			return new ModelAndView("redirect:/cargarAgenda.htm?semana=0");
		}
		
///////////////////////////////////////
//////TRAER EVENTO PRIVADO	//////////	
/////////////////////////////////////
		
		@RequestMapping(value = "/verEventoPrivado", method = RequestMethod.GET)
		public ModelAndView verEventoPrivado(@RequestParam String id) {
			System.out.println("EventController - verEventoPrivado: " + id);

			ModelAndView mav = new ModelAndView();
			
			Evento eventoPrivado = eventoDao.get(Integer.parseInt(id));
			
			String strFecha = new SimpleDateFormat("dd/MM/yyyy").format(eventoPrivado.getFecha());
			String strHoraInicio  = eventoPrivado.getHoraInicio().toString().substring(11,16);
			String strHoraFin  = eventoPrivado.getHoraFin().toString().substring(11,16);
			
			eventoPrivado.setStrFecha(strFecha);
			eventoPrivado.setStrHoraInicio(strHoraInicio);
			eventoPrivado.setStrHoraFin(strHoraFin);
			
			
			mav.addObject("horas", cargarHorarios());
			mav.addObject("eventoPrivado", eventoPrivado);
			mav.setViewName("/views/editarEventoPrivado.jsp");

			return mav;
		}

///////////////////////////////////////
//////	EDITAR EVENTO PRIVADO	//////	
/////////////////////////////////////	
		
		@RequestMapping(value = "/editarEventoPrivado", params={"modificar"}, method = RequestMethod.POST)
		public ModelAndView editarEventoPrivado(@ModelAttribute("eventoPrivado") EventoPrivado evPrivado,
												BindingResult result, SessionStatus status, HttpServletRequest req, HttpSession httpSession) {

			System.out.println("EventController - editarEventoPrivado");

			ModelAndView mv = new ModelAndView();
			mv.setViewName("redirect:/cargarAgenda.htm?semana=0");

			if (eventoPrivadoValidator.supports(evPrivado.getClass()))
				this.eventoPrivadoValidator.validate(evPrivado, result);
				
			System.out.println("EDITAR : " + evPrivado.getId() +" result:" + result.toString());
			if (!result.hasErrors()) {
						
				evPrivado.setUsuario((Usuario)req.getSession().getAttribute("usuario"));
				evPrivado.setHayError(false);
				 try {
					 DateFormat formatter = new SimpleDateFormat("HH:mm");
					 Date horaInicio = formatter.parse(evPrivado.getStrHoraInicio());
					 Date horaFin = formatter.parse(evPrivado.getStrHoraFin());
					
					 evPrivado.setHoraInicio(horaInicio);
					 evPrivado.setHoraFin(horaFin);
					
//					 if(horaInicio.compareTo(horaFin) > 0){
//						   evPrivado.setHayError(true);
//							System.out.println("TIENE ERROR" + evPrivado.toString());
//							mv.setViewName("/views/editarEventoPrivado.jsp");
//							return mv;
//					 }
					 
					
					 SimpleDateFormat formatFecha = new SimpleDateFormat("dd/MM/yyyy");
					 Date fecha = formatFecha.parse(evPrivado.getStrFecha());
					
					 evPrivado.setFecha(fecha);						

					this.eventoDao.update(evPrivado);
				 } catch (ParseException e) {
					 e.printStackTrace();
					 System.out.println("ERROR AL CONVERTIR EN FORMATO HORA y FECHA");
					}		
			}else {
				evPrivado.setHayError(true);
				mv.addObject("horas", cargarHorarios());
				System.out.println("TIENE ERROR" + evPrivado.toString());
				mv.setViewName("/views/editarEventoPrivado.jsp");
			}
			return mv;
		}
		
///////////////////////////////////////
//////	BORRAR EVENTO PRIVADO	//////	
/////////////////////////////////////
		
		@RequestMapping(value = "/editarEventoPrivado", params = {"borrar"}, method = RequestMethod.POST)
		public ModelAndView borrarEventoPrivado (@ModelAttribute("eventoPrivado") EventoPrivado eventoPrivado) {
			System.out.println("EventController - borrarEventoPrivado");

			this.eventoDao.delete(this.eventoDao.get(eventoPrivado.getId()));

			
			//eventoPrivado.getUsuario().setSemana(0);
			ModelAndView out = new ModelAndView("redirect:/cargarAgenda.htm?semana=0");
			out.addObject("idEvento", eventoPrivado.getId());
			return out;
		}
						
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//////	ABM EVENTO REUNION	//////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
///////////////////////////////////////
//////	NUEVO EVENTO REUNION	//////	
/////////////////////////////////////
		
		@RequestMapping(value = "/nuevoEventoReunion", method = RequestMethod.POST)
		public ModelAndView nuevoEventoReunion(@ModelAttribute("eventoReunion") EventoReunion evReunion,
												BindingResult result, HttpServletRequest req) {
			
			
			 System.out.println("             ");
			 System.out.println("EventoController - nuevoEventoReunion");
			 System.out.println("             ");
			
			
			evReunion.setUsuario((Usuario)req.getSession().getAttribute("usuario"));
			evReunion.setIdUsuario(((Usuario)req.getSession().getAttribute("usuario")).getId());
			
			Set<Invitacion> invitacionesSelect = new HashSet<Invitacion>();
			for(Usuario usr: usuarioDao.getTodos()){
				 
				if(req.getParameter("invitado_" + usr.getId()) !=null){
					Invitacion inv = new Invitacion();
					inv.setEvento(evReunion);
					inv.setUsuario(usr);
					inv.setEstado(EstadoInvitacion.Pendiente.toString());
					invitacionesSelect.add(inv);
				}
			}
			evReunion.setInvitadosSeleccionados(invitacionesSelect);
			
			this.eventoReunionValidator.validate(evReunion, result);

			
			if (result.hasErrors()) {
				ModelAndView mv = new ModelAndView("/views/nuevoEvento.jsp");
				
				mv.addObject("eventoPrivado", new EventoPrivado());
				
				mv.addObject("invitadosPosibles", usuarioDao.getTodosMenosActual(((Usuario)req.getSession().getAttribute("usuario")).getId()));
				mv.addObject("salas", cargarComboSalas());
				mv.addObject("horas", cargarHorarios());
				mv.addObject("invitaciones",invitacionesSelect);
				
				System.out.println("ERRORES: " + result.toString());
				
				
				
				evReunion.setHayError(true);
				return mv;
				
			}

			
			evReunion.setHayError(false);
			 try {
				 DateFormat formatter = new SimpleDateFormat("HH:mm");
				 Date horaInicio = formatter.parse(evReunion.getStrHoraInicio());
				 Date horaFin = formatter.parse(evReunion.getStrHoraFin());
				
				 evReunion.setHoraInicio(horaInicio);
				 evReunion.setHoraFin(horaFin);
				 
//				 if(horaInicio.compareTo(horaFin) > 0){
//					 ModelAndView mv = new ModelAndView("/views/nuevoEvento.jsp");
//						
//						mv.addObject("eventoPrivado", new EventoPrivado());
//						
//						mv.addObject("invitadosPosibles", usuarioDao.getTodosMenosActual(((Usuario)req.getSession().getAttribute("usuario")).getId()));
//						mv.addObject("salas", cargarComboSalas());
//						mv.addObject("horas", cargarHorarios());
//						
//						evReunion.setHayError(true);
//						return mv;
//				 }
				 
				 SimpleDateFormat formatFecha = new SimpleDateFormat("dd/MM/yyyy");
				 Date fecha = formatFecha.parse(evReunion.getStrFecha());
				
				 evReunion.setFecha(fecha);	
				 
				 evReunion.setInvitaciones(invitacionesSelect);

				eventoDao.save(evReunion);
				evReunion.getUsuario().setSemana(0);
				
				
			 } catch (ParseException e) {
				 e.printStackTrace();
				 System.out.println("ERROR AL INTENTAR GUARDAR EL EVENTO ");
				}
			 return new ModelAndView("redirect:/cargarAgenda.htm?semana=0"); 

			 
//			Set<Invitacion> invitaciones = new HashSet<Invitacion>();
//			
//			for(Usuario usr: usuarioDao.getTodos()){
//				 
//				if(req.getParameter("invitado_" + usr.getId()) !=null){
//					Invitacion inv = new Invitacion();
//					inv.setEvento(evReunion);
//					inv.setUsuario(usr);
//					inv.setEstado(EstadoInvitacion.Pendiente.toString());
//					invitaciones.add(inv);
//				}
//			}
//
//
//			evReunion.setInvitaciones(invitaciones);
//			System.out.println("Invitados: " + evReunion.getInvitaciones());

		}

///////////////////////////////////////
//////TRAER EVENTO REUNION	//////////	
/////////////////////////////////////
		
		@RequestMapping(value = "/verEventoReunion", method = RequestMethod.GET)
		public ModelAndView verEventoReunion(@RequestParam String id, HttpServletRequest req) {
											 System.out.println("EventController - verEventoReunion");


			ModelAndView mav = new ModelAndView();
			mav.addObject("salas", cargarComboSalas());
			mav.addObject("horas", cargarHorarios());

			EventoReunion eventoReunion = (EventoReunion) eventoDao.get(Integer.parseInt(id));
			
			String strFecha = new SimpleDateFormat("dd/MM/yyyy").format(eventoReunion.getFecha());
			String strHoraInicio  = eventoReunion.getHoraInicio().toString().substring(11,16);
			String strHoraFin  = eventoReunion.getHoraFin().toString().substring(11,16);
			
			eventoReunion.setStrFecha(strFecha);
			eventoReunion.setStrHoraInicio(strHoraInicio);
			eventoReunion.setStrHoraFin(strHoraFin);			

			List<Usuario> invitadosPosibles = usuarioDao.getTodosMenosActual(eventoReunion.getUsuario().getId());
			List<Usuario> invitadosSeleccionados = new ArrayList<Usuario>();
			List<Invitacion> invitaciones = new ArrayList<Invitacion>();
			
			for (Invitacion i : eventoReunion.getInvitaciones())
				invitadosSeleccionados.add(i.getUsuario());
			
			mav.addObject("invitadosPosibles", invitadosPosibles);
			mav.addObject("invitadosSeleccionados", invitadosSeleccionados);
			mav.addObject("eventoReunion", eventoReunion);
			mav.addObject("invitaciones", eventoDao.getInvitacionesDeEvento(eventoReunion));

			Usuario USRActual = (Usuario)req.getSession().getAttribute("usuario");
			mav.addObject("USRActual", USRActual);		
			
			if(USRActual.getId() != eventoReunion.getUsuario().getId()){
				Invitacion invitacion = eventoDao.getInvitacion(USRActual, eventoReunion);
				eventoReunion.setEstado(invitacion.getEstado());
			}

			mav.setViewName("/views/editarEventoReunion.jsp");

			return mav;
		}		
		
///////////////////////////////////////
//////	EDITAR EVENTO REUNION	//////	
/////////////////////////////////////		
		
		@RequestMapping(value = "/editarEventoReunion",params = {"modificar"})
		public ModelAndView editarEventoReunion(@ModelAttribute("eventoReunion") EventoReunion eventoReunion,
												BindingResult result, SessionStatus status,
												HttpServletRequest req, HttpSession httpSession) {

			System.out.println("EventController - editarEventoReunion");
		
			ModelAndView mav = new ModelAndView();
			eventoReunion.getUsuario().setSemana(0);
			mav.setViewName("redirect:/cargarAgenda.htm?semana=0");
			

			Set<Invitacion> invitacionesNuevas = new HashSet<Invitacion>();
			Set<Invitacion> invitacionesViejas = new HashSet<Invitacion>();

			//TRAER INVITACIONES NUEVAS
			for(Usuario usr: usuarioDao.getTodos()){
				if(req.getParameter("invitado_" + usr.getId()) !=null){
					Invitacion inv = new Invitacion();
					inv.setEvento(eventoReunion);
					inv.setUsuario(usr);
					inv.setEstado(EstadoInvitacion.Pendiente.toString());
					invitacionesNuevas.add(inv);
				}
			}
			eventoReunion.setInvitadosSeleccionados(invitacionesNuevas);
			
			
				if (eventoReunionValidator.supports(eventoReunion.getClass()))
					eventoReunionValidator.validate(eventoReunion, result);

				if (!result.hasErrors()) {
					eventoReunion.setHayError(false);
					
					 try {
						 
						 DateFormat formatter = new SimpleDateFormat("HH:mm");
						 Date horaInicio = formatter.parse(eventoReunion.getStrHoraInicio());
						 Date horaFin = formatter.parse(eventoReunion.getStrHoraFin());
						
						 eventoReunion.setHoraInicio(horaInicio);
						 eventoReunion.setHoraFin(horaFin);

						 SimpleDateFormat formatFecha = new SimpleDateFormat("dd/MM/yyyy");
						 Date fecha = formatFecha.parse(eventoReunion.getStrFecha());
						
						 eventoReunion.setFecha(fecha);
					

						
						//TRAER INVITACIONES VIEJAS
						 invitacionesViejas.addAll(eventoDao.getInvitacionesDeEvento(eventoReunion));
						
						//SETEO EL ESTADO DE LOS VIEJOS A LOS NUEVOS
						for (Invitacion n : invitacionesNuevas){
							for (Invitacion v : invitacionesViejas){
								if(n.getUsuario().equals(v.getUsuario())){
									n.setEstado(v.getEstado());
								}
							}
						}
						
						//BORRO LAS INVITACIONES VIEJAS DE ESE EVENTO
						eventoDao.borrarInvitacionesDeEvento(eventoReunion);
						
						System.out.println("YA BORRE VIEJOS");
						eventoReunion.setInvitaciones(invitacionesNuevas);
						this.eventoDao.update(eventoReunion);

												 
					 } catch (ParseException e) {
						 e.printStackTrace();
						 System.out.println("ERROR: " + e.getMessage());
						}
						
				} else {

					eventoReunion.setHayError(true);
					mav.addObject("invitadosPosibles", usuarioDao.getTodosMenosActual(eventoReunion.getIdUsuario()));
					mav.addObject("salas", cargarComboSalas());
					mav.addObject("horas", cargarHorarios());
					mav.addObject("invitaciones",invitacionesNuevas);
					
					mav.setViewName("redirect:verEventoReunion.htm?id=" + eventoReunion.getId());
					//mav.setViewName("/views/editarEventoReunion.jsp");
					
				}
			return mav;
		}
		
///////////////////////////////////////
//////	BORRAR EVENTO REUNION	//////	
/////////////////////////////////////		
		
		@RequestMapping(value = "/editarEventoReunion",params = {"borrar"})
		public ModelAndView borrarEventoReunion(@ModelAttribute("eventoReunion") EventoReunion eventoReunion) {
			System.out.println("EventController - borrarEventoReunion");

			this.eventoDao.delete(this.eventoDao.get(eventoReunion.getId()));
			eventoReunion.getUsuario().setSemana(0);
			ModelAndView out = new ModelAndView("redirect:/cargarAgenda.htm?semana=0");
			out.addObject("idEvento", eventoReunion.getId());
			return out;
		}
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		@RequestMapping(value = "/editarMiEstadoEvento", method = RequestMethod.POST)
		public ModelAndView editarMiEstadoEvento(@ModelAttribute("eventoReunion") EventoReunion eventoReunion,
												BindingResult result, SessionStatus status,
												HttpServletRequest req, HttpSession httpSession) {

			System.out.println("EventController - editarMiEstadoEvento");

			ModelAndView mav = new ModelAndView();
			eventoReunion.getUsuario().setSemana(0);
			mav.setViewName("redirect:/cargarAgenda.htm?semana=0");


			Invitacion invitacionEditada =  this.eventoDao.getInvitacion((Usuario)req.getSession().getAttribute("usuario"), eventoReunion);
			
			System.out.println("invitacionEditada: ");
			
			invitacionEditada.setEstado(eventoReunion.getEstado());
			
			this.eventoDao.updateInvitacion(invitacionEditada);

			return mav;
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								//////	FUNCIONES PRIVADAS	//////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
		public List<Sala> cargarComboSalas(){
			
			List<Sala>salas = new ArrayList<Sala>();
		
			salas = eventoDao.cargarSalas();
			System.out.println("controller salas: " + salas);
			return salas;
		}
	
		
		@RequestMapping(value = "/invitar", method = RequestMethod.POST)
		public  @ResponseBody Set<Invitacion> invitar(@ModelAttribute("eventoReunion") EventoReunion evReunion, @RequestBody Usuario usuario) {
			
			System.out.println("INVITADOS ANT: "+ evReunion.getInvitaciones());
			
			Boolean existe = false;	
			for(Invitacion iAnterior : evReunion.getInvitaciones())
			{
							
				if(iAnterior.getUsuario().getId() == usuario.getId())
				{
					System.out.println("EXISTE: "+usuario);
					evReunion.getInvitaciones().add(iAnterior);
					existe = true;
				}
			}
			
			if(!existe) // Si el usuario no existia en los invitados lo agrega como A CONFIRMAR
			{
				System.out.println("AGREGADO: "+usuario);
				Invitacion invitado = new Invitacion();
				invitado.setUsuario(usuario);
				invitado.setEstado(EstadoInvitacion.Pendiente.toString());
				evReunion.getInvitaciones().add(invitado);
			}
			
			System.out.println("INVITADOS DPS: "+ evReunion.getInvitaciones());
			
			return evReunion.getInvitaciones();
			
		}	
		
		
		@RequestMapping(value = "/desinvitar", method = RequestMethod.POST)
		public  @ResponseBody Set<Invitacion> quitar(@ModelAttribute("eventoReunion") EventoReunion evReunion, @RequestBody Usuario usr) {
				
				usr = this.usuarioDao.get(usr.getId());
			
				for (Invitacion inv : evReunion.getInvitaciones()) {

					
					if(usr.equals(inv.getUsuario()))
					{
						evReunion.getInvitaciones().remove(inv);
						break;
					}
				}
			
			return evReunion.getInvitaciones();
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





