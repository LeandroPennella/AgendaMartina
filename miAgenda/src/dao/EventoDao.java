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
import model.Sala;
import model.Usuario;

@Component
@Transactional(readOnly = true)
public class EventoDao {
	
	private  SessionFactory sessionFactory;


	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}


	public Evento get(int id){
		Session session = sessionFactory.getCurrentSession();
		Evento out = (Evento)session.get(Evento.class, id);
		
		return out;
	}
	
	
	
	public List<Evento> getTodos(Usuario idUsuario){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery(" select distinct e FROM Evento as e left join fetch e.invitaciones as i "
									+ " WHERE (e.usuario = :idUsuario OR i.usuario = :idUsuario) "
									+ "ORDER BY e.horaInicio");
		
		q.setParameter("idUsuario", idUsuario);

		
		List<Evento> out = q.list();
		
//		for (Evento e : out) {
//			System.out.println("ID :" + e.getId());
//		}
		
		
		System.out.println("todos los eventos del usuario: " + out);
		return out;
	}
	

	public List<Evento> getTodosCONFECHA(Usuario usuario, String fechaInicio, String fechaFin){

//		SimpleDateFormat d = new SimpleDateFormat("dd-MM-yyyy");
//		Date dd=d.parse(d, new ParsePosition(0));
		
		System.out.println("ID USUARIO: " + usuario.getId());
		System.out.println("fechaInicio: " + fechaInicio);
		System.out.println("fechaFin: " + fechaFin);
		System.out.println("------------------------------");

		
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery(" select distinct e FROM Evento as e left join fetch e.invitaciones as i "
									+ " WHERE (e.usuario = :usuario OR i.usuario = :usuario) "
									+ "     AND e.fecha >= " + fechaInicio
									+ "     AND e.fecha <= " + fechaFin
									+ "ORDER BY e.horaInicio");
		
		
		q.setParameter("usuario", usuario);
//		q.setParameter("fechaInicio", fechaInicio);
//		q.setParameter("fechaFin", fechaFin);//CON SETDATE


		List<Evento> out = q.list();
		
		for (Evento e : out) {
			System.out.println("ID EVENTO:" + e.getId() + " - " + e.getFecha() );
		}
		
		
		System.out.println("todos los eventos del usuario: " + out);
		return out;
	}
	
	/////////////////////// A B M ////////////////////////////

	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void save(Evento evento) {
		Session session = sessionFactory.getCurrentSession();

		session.saveOrUpdate(evento);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void update(Evento evento) {
		Session session = sessionFactory.getCurrentSession();
		System.out.println("EVENTO A EDITAR: " + evento.toString());
		session.update(evento);
	}
	
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delete(Evento evento) {
		Session session = sessionFactory.getCurrentSession();

		session.delete(evento);
	}
	
	
	
	////////////////////////////////////////////////////
	
	
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public  List<Sala> cargarSalas(){

		Session session = sessionFactory.getCurrentSession();
		Query q= session.createQuery("FROM Sala s");
		
		List<Sala> out= q.list();

		System.out.println("cargarSalas: " + out);
		return out;
	}
	
	public Invitacion getInvitacion(Usuario usuario, Evento evento){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("FROM Invitacion i  WHERE i.usuario = :usuario AND i.evento = :evento ");
		
		q.setParameter("usuario", usuario);
		q.setParameter("evento", evento);

		
		Invitacion out = (Invitacion) q.uniqueResult();
		//System.out.println("INVITACION : " + out.toString());
		return out;
	}
	
	public List<Invitacion> getInvitacionesDeEvento(Evento evento){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("FROM Invitacion i  WHERE i.evento = :evento ");

		q.setParameter("evento", evento);
		List<Invitacion> out= q.list();

		System.out.println("Cargó invitaciones: " + out);
		return out;
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void borrarInvitacionesDeEvento(Evento evento){
		Session session = sessionFactory.getCurrentSession();
		Query q = session.createQuery("DELETE FROM Invitacion i  WHERE i.evento = :evento ");
		q.setParameter("evento", evento);
		
		q.executeUpdate();
		
	}	
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateInvitacion(Invitacion invitacion) {
		Session session = sessionFactory.getCurrentSession();
		System.out.println("INVITACION A EDITAR: " + invitacion.toString());
		session.update(invitacion);	
	}
	

}
