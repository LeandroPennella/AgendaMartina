package interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import model.Usuario;

public class MyInterceptor implements HandlerInterceptor{
	
	//Despues de la vista, pero antes de mostrar al cliente
		@Override
		public void afterCompletion(HttpServletRequest arg0,
				HttpServletResponse arg1, Object arg2, Exception arg3)
				throws Exception {
		}
		
		
	//Despues del controlador pero antes de la vista
		@Override
		public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
				Object arg2, ModelAndView arg3) throws Exception {


		}

		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	
		//Antes del controlador
		
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res,
			Object objeto) throws Exception {

		System.out.println("///////INTERCEPTOR////////");

		String loginCookieValue = null;
		Cookie[] listaCookies = req.getCookies();
		
		if(listaCookies !=null){
			for(Cookie c : listaCookies){
				System.out.println("listaCookies" + c.getName());
				
				if(c.getName().equals("loginCookie")){
					loginCookieValue = c.getValue();
					System.out.println("logincookie existe - value = " + loginCookieValue);
				}
			
			}
		}
		
		//Boolean estaLogueado = false;
		String contextRelativeURI = req.getRequestURI().substring(
				req.getContextPath().length());
		
		if(loginCookieValue != null){
			//LOGUEADO POR COOKIE
			if(contextRelativeURI.equals("/")){
				//RequestDispatcher rd = req.getRequestDispatcher("/cargarAgenda.htm");
				RequestDispatcher rd = req.getRequestDispatcher("/services/cookieLogin");
				rd.forward(req, res);
				System.out.println("Logueado por cookie");
				return false;
			}else
				return true;
		}else{
			//NO LOGUEADO POR COOKIE PREGUNTO POR SESION
			System.out.println("NO Logueado por cookie");
			
			Usuario usrSesion = (Usuario)req.getSession().getAttribute("usuario");
			System.out.println("...." + (Usuario)req.getSession().getAttribute("usuario"));
			if(usrSesion != null){
				if(usrSesion.getId() != 0 ){
					System.out.println("Logueado por sesion: "  + ((Usuario)req.getSession().getAttribute("usuario")).getNombreUSR());
					return true;
				}else{
					System.out.println("NO Logueado por sesion");
					if(contextRelativeURI.equals("/views/login.jsp")
							||	contextRelativeURI.equals("/") 
							||	contextRelativeURI.equals("/procesarUSR.htm")
							||	contextRelativeURI.equals("/index.htm")
							||  contextRelativeURI.equals("/services/login")
							||  contextRelativeURI.equals("/services/cookieLogin")){
						System.out.println("contextRelativeURI: " + contextRelativeURI);
						System.out.println("req.getRequestURI():" + req.getRequestURI());
						return true;
					}else{
						RequestDispatcher rd = req.getRequestDispatcher("/index.htm");
						rd.forward(req, res);
						return false;	
					}
				}
			}
		}
	
	
		
//		
//		
//		
//		String contextRelativeURI = req.getRequestURI().substring(
//				req.getContextPath().length());
//			
//		//Verifico si esta logueado en sesion
//		if(req.getSession().getAttribute("usuario") != null){
//			
//			System.out.println("Esta logueado sesion: " + ((Usuario)req.getSession().getAttribute("usuario")).getNombreUSR());
//			
//			if (contextRelativeURI.equals("/views/login.jsp")
//					|| contextRelativeURI.equals("/")) {
//				
//				RequestDispatcher rd = req.getRequestDispatcher("/services/cargarAgenda/");
//				rd.forward(req, res);
//				return false;
//			}
//			estaLogueado = true;				
//		}
//		
//		
//		//Verifico si esta logueado en cookies
//		
//		else if(loginCookieValue != null &&
//				!contextRelativeURI.equals("/services/cookieLogin")){
//			
//			System.out.println("Esta logueado con cookies: " + loginCookieValue);
//			estaLogueado = true;
//			
//			RequestDispatcher rd = req.getRequestDispatcher("/services/cookieLogin");
//			rd.forward(req, res);
//			return false;
//		}
//		
//		if(estaLogueado){
//			if(contextRelativeURI.equals("/")){
//				RequestDispatcher rd = req.getRequestDispatcher("/services/cargarAgenda");
//				rd.forward(req, res);
//				return false;
//			}
//		}else if(!estaLogueado){
//
//					if(contextRelativeURI.equals("/views/login.jsp")
//						||	req.getRequestURI().contains("/") 
//						||	req.getRequestURI().contains("/procesarUSR.htm")
//						||	req.getRequestURI().contains("/index.htm"))
//					{
//						
//						System.out.println("se esta logueando, seguir" + req.getRequestURI());
//						return true;
//					
//
//					}else{
//						RequestDispatcher rd = req.getRequestDispatcher("/index.htm");
//						rd.forward(req, res);
//						return false;
//					}
//			}
//			
		return true;
		
	}
}


