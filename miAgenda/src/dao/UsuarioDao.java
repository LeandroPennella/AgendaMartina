package dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import model.Evento;
import model.Invitacion;
import model.Usuario;



@Component
@Transactional(readOnly = true)
public class UsuarioDao {
	private  SessionFactory sessionFactory;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public Usuario get(long id) {
		Session session = sessionFactory.getCurrentSession();
		Usuario usr = (Usuario) session.get(Usuario.class, id);
		return usr;
	}	
	

	public Usuario getByNombreUSR(String nombreUSR){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("FROM Usuario usr WHERE usr.nombreUSR = :nombreUSR");
		q.setParameter("nombreUSR", nombreUSR);
//		List<Usuario> list = q.list();
//		Usuario out = list.get(0);
//		
//		return out;		
		
		Usuario out = (Usuario) q.uniqueResult();
		return out;
	}
	
	public List<Usuario> getTodos(){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("FROM Usuario usr");
		List<Usuario> out = q.list();
		
		return out;		
	}
	
	public List<Usuario> getTodosMenosActual(int id){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("FROM Usuario usr WHERE usr.id != :id");
		
		q.setParameter("id", id);
		List<Usuario> out = q.list();
		
		System.out.println("out - getTodosMenosActual:" + out );
		return out;		
	}	
	

	public  Usuario cargarUsuario(String nombreUSR, String pass){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("FROM Usuario usr WHERE usr.nombreUSR = :nombreUSR AND usr.password = :pass");
		
		 
		q.setParameter("nombreUSR", nombreUSR);
		q.setParameter("pass", pass);

//		List<Usuario> list = q.list();
//		Usuario out = list.get(0);
//		
//		System.out.println("DAOcargarUsuario - out: " + out);
//		
//		return out;	
		Usuario out = (Usuario) q.uniqueResult();
		return out;
		
	}
	
	
	
	

	
	public Usuario load(long id){
		Session session = sessionFactory.getCurrentSession();
		Usuario usr = (Usuario) session.get(Usuario.class, id);
		
		
		return usr;		
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void save(Usuario pedido) {
		Session session = sessionFactory.getCurrentSession();

		session.saveOrUpdate(pedido);

	}	
	
	
	
	public List<Usuario> coincidencias(String param, int actual) {
		System.out.println("param: " + param);
		System.out.println("actual: " + actual);
		
		
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("FROM Usuario AS usr WHERE (usr.nombreREAL LIKE CONCAT('%" + param + "%') OR usr.apellido LIKE CONCAT('%" + param + "%') OR usr.nombreUSR LIKE CONCAT('%" + param + "%')) AND usr.id != " + actual);


		
		System.out.println("QUERY: " + q);
		
		
		List<Usuario> posibles = q.list();

		System.out.println("POSIBLES: " + posibles);
		return posibles;
	}
	
	

		
}








