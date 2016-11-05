package validator;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import model.EventoReunion;




@Component()
public class EventoReunionValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return EventoReunion.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object object, Errors errors) {
		EventoReunion evReunion = (EventoReunion) object;


		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nombre", "error.evento.nombre.vacio");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "strHoraInicio", "error.evento.horaInicio.vacio");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "strHoraFin", "error.evento.horaFin.vacio");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "strFecha", "error.evento.fecha.vacio");

	
		if( evReunion.getInvitadosSeleccionados().size() == 0){
			errors.rejectValue("invitaciones", "error.invitados.ninguno");
		}
		
		
		if (!errors.hasFieldErrors("strHoraFin")) {

			try {
				DateFormat hora = new SimpleDateFormat("HH:mm");

				if (hora.parse(evReunion.getStrHoraInicio()).compareTo(hora.parse(evReunion.getStrHoraFin())) >= 0) {
					errors.rejectValue("strHoraFin", "error.hora.menor");
				}
			} catch (ParseException e) {

			}
		}
		
		
		//FECHA
		if(evReunion.getStrFecha() != null && evReunion.getStrFecha() != ""){
			if(evReunion.getStrFecha().toString().length() != 10){
				errors.rejectValue("strFecha", "error.formatoFecha");	
				return;
			}
			
			String  f1 = "" + evReunion.getStrFecha().charAt(0); //<=1
			int a = Integer.parseInt(f1);
			
			String  f2 = "" + evReunion.getStrFecha().charAt(1); //
			int b = Integer.parseInt(f2);

		    char c=evReunion.getStrFecha().charAt(2); //'/'
		    
			String  f3 = "" + evReunion.getStrFecha().charAt(3); //<=1 
			int d = Integer.parseInt(f3);

			String  f4 = "" + evReunion.getStrFecha().charAt(4); //<=2 
			int e = Integer.parseInt(f4);
			
		    char f=evReunion.getStrFecha().charAt(5); //'/'
		    
			String  f5 =  evReunion.getStrFecha().charAt(6) + "" +
						  evReunion.getStrFecha().charAt(6) + "" +
					  	  evReunion.getStrFecha().charAt(6) + "" +
					  	  evReunion.getStrFecha().charAt(6) ; //<=1900 >=2200
			int g = Integer.parseInt(f5);
			
			
		    if ((a==3 && b>1) || (a>3) || (a == 0 && b == 0)) {
		    	errors.rejectValue("strFecha", "error.fecha.dia");	
		    }		    
		    if (d>1 || d==1 && e>2){  
		    	errors.rejectValue("strFecha", "error.fecha.mes");	
		    }
		    if (g < 1900 || g > 2500) { 
		    	errors.rejectValue("strFecha", "error.fecha.anio");
		    } 
		    if (c!='/' || f!='/')  { 
		    	errors.rejectValue("strFecha", "error.fecha.separador");
		    }	
			
		}
	}

}
