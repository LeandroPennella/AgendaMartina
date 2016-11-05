package validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import dao.UsuarioDao;
import model.Usuario;


@Component
public class LoginValidator {
	
	private UsuarioDao usuarioDao;

	@Autowired
	public void setUsuarioDao(UsuarioDao usuarioDao) {
		this.usuarioDao = usuarioDao;
	}
	
	public boolean supports(Class<?> clazz) {
		return Usuario.class.isAssignableFrom(clazz);
	}


	public void validate(Object object, Errors errors) {
		Usuario usuario = (Usuario) object;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nombreUSR", "error.login.nombre.vacio");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "error.login.password.vacio");
	
	}
}
