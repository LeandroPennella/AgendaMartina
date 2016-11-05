package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.jstl.core.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;


import dao.UsuarioDao;
import model.Usuario;
import validator.LoginValidator;


@Controller
@SessionAttributes({"usuario"})
public class LoginController {


	private LoginValidator loginValidator;
	private UsuarioDao usuarioDao;

	@Autowired
	public void setUsuarioValidador(LoginValidator loginValidator) {
		this.loginValidator = loginValidator;
	}
	
	@Autowired
	private SessionLocaleResolver sessionlocaleResolver;
	
	@Autowired
	public void setUsuarioDao(UsuarioDao usuarioDao) {
		this.usuarioDao = usuarioDao;
	}
	
///0///		
	@RequestMapping(value = "/index")
	public ModelAndView index(ModelMap model, SessionStatus status){
		System.out.println("LoginController - index");
		//status.setComplete();
		
		Usuario usuario = new Usuario();

		model.addAttribute("usuario", usuario);	
		ModelAndView mv = new ModelAndView("/views/login.jsp");
		return mv; 
	}	
	
	
///1///	

	@RequestMapping(value = "/procesarUSR", method = RequestMethod.POST)
	public ModelAndView procesarUSR(@ModelAttribute("usuario") Usuario usuario, 
									BindingResult result, SessionStatus status, 
									HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		System.out.println("LoginController - procesarUSR");	
		
		this.loginValidator.validate(usuario, result);
		if (result.hasErrors()) {
			System.out.println("hay error");
			return new ModelAndView("/views/login.jsp");
		}
		if(usuarioDao.cargarUsuario(usuario.getNombreUSR(), usuario.getPassword()) == null){
			usuario.setHayError(true);
			return new ModelAndView("/views/login.jsp");
			
		}else
			usuario.setHayError(true);
			
		System.out.println("Usuario : " + usuario.getNombreUSR() +  usuario.getPassword());
		
		if (req.getParameter("rememberSession") != null) {
			Cookie cookie = new Cookie("loginCookie", usuario.getNombreUSR());
			cookie.setMaxAge(60 * 60 * 24 * 365 * 10);
			cookie.setPath("/");
			res.addCookie(cookie);
			System.out.println("GUARDADO EN COOKIE: " + cookie.getName());
		}		
		
		
		Usuario usr = new Usuario();
		usr = usuarioDao.cargarUsuario(usuario.getNombreUSR(), usuario.getPassword());
		System.out.println("USUARIO: " + usr);
		if(usr != null){
			
			ModelAndView mv = new ModelAndView("redirect:/cargarAgenda.htm?semana=0");
			mv.addObject("usuario", usr);
			req.getSession().setAttribute("usuario", usr);
			
			System.out.println("usuario en sesion: " + req.getSession().getAttribute("usuario"));
			
			
			Config.set(req.getSession(), Config.FMT_LOCALE, new java.util.Locale(usr.getIdioma()));
			sessionlocaleResolver.setLocale(req, res, new java.util.Locale(usr.getIdioma()));			
			return mv;
			
		}
		return  new ModelAndView("/views/login.jsp?error=1");
	}	
	
///////////////////////////////////////////////////////////////////////
	
	
	@RequestMapping(value = "/cookieLogin", method = RequestMethod.GET)
	public ModelAndView cookieLogin(HttpServletRequest req,
									HttpServletResponse res) throws IOException {
		
		System.out.println("LoginController - cookieLogin");
		
		String loginCookieValue = null;
		
		Cookie[] listaCookies = req.getCookies();

		for (Cookie c : listaCookies){
			if(c.getName().equals("loginCookie")){				
				loginCookieValue = c.getValue();				
			}
		}
		
		if (loginCookieValue != null) {
		
			Usuario usr = usuarioDao.getByNombreUSR(loginCookieValue);
			
		
			req.getSession().setAttribute("usuario", usr);
			return  new ModelAndView("redirect:/cargarAgenda.htm?semana=0");
		}

		return  new ModelAndView("/views/login.jsp");
	}
		
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest req,
							   HttpServletResponse res, SessionStatus status) {
		System.out.println("LoginController - logout");
		
		
		
		if(req.getSession() != null && req.getCookies() != null){
			for(Cookie cookie: req.getCookies()){
				if(cookie.getName().equals("loginCookie")){
					if(cookie.getValue().equals(((Usuario)req.getSession().getAttribute("usuario")).getNombreUSR())){
						cookie.setMaxAge(0);
						cookie.setPath("/");
						res.addCookie(cookie);
					}
				}
			}
		status.setComplete();
		
		}
		
		
		
		System.out.println("CANTIDAD Cookies: " + req.getCookies().length);
		//req.getSession().invalidate();
		
		try {
			res.sendRedirect(req.getContextPath() + "/index.htm");
		} catch (IOException e) {

			e.printStackTrace();
		}
		return new ModelAndView("/views/login.jsp");
	}
	
	

	

}
