<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="header.jsp" />

<jsp:include page="scripts.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<script type="text/javascript">
	
		var row = 45;
		var techo = 245;
		var mapaHorario = [];
		var eventosDia = [];
		 
		
			 $(function() {		
				 
				$(".dragEvento").draggable({
						 zIndex: 10000,
						 grid: [ 0, row],
						 containment: "#limiteEventos",
						 drag: function() {
							 
							 	var posicion = getPosicion(this.id);
							 	var duracion = getDuracion(this.id);					 	
 	 							var nuevoInicio = getNuevaHora(posicion);
	 							var nuevoFin = getNuevaHora(parseInt(posicion) + parseInt(duracion));
	 							
	 							$(this).find(".horaEvento").html(nuevoInicio + "-" + nuevoFin);
	 							getCompartidos();
	 							
						 	},
						 	
						 	
	 					  	stop: function() {
	 					  		
	 					  		var finalPos = getPosicion(this.id);
	 					  		var duracion = getDuracion(this.id);
	 					  	
	 					  		
									cambiarEnMapaHorario(getId(this.id) +"-"+ getDuracion(this.id), finalPos, duracion);
									reiniciarValores();
									getCompartidos();


				            	
				           		$.ajax({
									url: '<c:url value="/services/cambiarHorario3/" />'+ getId(this.id) + "-" + finalPos + "*" + getDuracion(this.id),
									type: "POST",
									dataType: "json",
									contentType: "application/json;charset=UTF-8",
									
									success : function(){
// 										cargarMapaHorario();
// 										reiniciarValores();
// 										getCompartidos();
									},
									
									error: function(jqXHR, textStatus,	errorThrown) {
										
										var errorHtml = "An error ocurred <br/>";
										errorHtml += "Status: "
												+ textStatus + "<br/>";
										errorHtml += "Reason: <pre>"
												+ errorThrown
												+ "</pre> <br/>";
										$("#respuestaPostAjax").html(
												errorHtml);
									}
								});	
								
					        }
			           		
					});
			  });
			 	
			 
		</script>

</head>
<c:import url="/views/navbar.jsp"></c:import>
<body>  
	<div id="navegarSemanas">

		<div id="semanaAtras">
			<a href='<c:url value="/cargarAgenda.htm?semana=-1" />' class="boton"  type="button">
	      			<span class="glyphicon glyphicon-arrow-left"></span> <fmt:message key="boton.agenda.anterior"/>
			</a>
		</div>
		<div id="semanaAdelante">
			<a href='<c:url value="/cargarAgenda.htm?semana=1" />' class="boton" type="button">
	      			<span class="glyphicon glyphicon-arrow-right"></span> <fmt:message key="boton.agenda.siguiente"/>
			</a>
		</div>
	</div>
<div class="content">


	
	<div id="agenda">
		<div class="row">
		
			<div id="horarios" class="col-md-1">
				<div id="hora">
					<fmt:message key="agenda.horarios"/>
				</div>
				<c:forEach var="hora" items="${listaHorarios}">
					<c:if test="${hora != '23:59'}">
						<div id="hora">${hora}</div>	
					</c:if>
				</c:forEach>

			</div>
			
			<c:forEach begin="0" end="6" var="dia">
			
    			<c:if test="${fechasSemana[dia] == hoy}">
					<style>#${nombresDia[dia]} {background-color: lightblue}</style>
				</c:if>
				
				<div id="${nombresDia[dia]}" class="col-md-1" style="width: 12%; ">
					<h5>
						<fmt:message key="agenda.${nombresDia[dia]}"/><br>
						${fechasSemana[dia]}
					</h5>
					<div id="limiteEventos"></div>
					
					<c:set var="eventosDia" value="${eventosXDia[dia]}"/>
					<c:set var="item" value="${0}"/>

					<c:forEach begin="0" end="47" var="x">
					<c:forEach var="ev" items="${eventosDia}">

					<c:if test="${x == ev.posicion}">						
<%-- 					<c:set var="item" value="${item + 1}"/> --%>
							<c:if test="${ev['class'] == 'class model.EventoPrivado'}">

									<a  id="${ev.id}-${ev.duracion}#${ev.strFecha}" class="dragEvento"  name="${ev.getEstado() }"
		  								href="${pageContext.request.contextPath}/verEventoPrivado.htm?id=${ev.id}" 
		  								style="height:${40*ev.duracion+5*(ev.duracion-1)}px;" >
		  								<span class='glyphicon glyphicon-pushpin' aria-hidden='true' style="float: right;"></span>
		  								<div class="descripcionEvento" id="${ev.getEstado() }">
			  								${ev.nombre} 
											<div class="horaEvento"><fmt:formatDate value="${ev.horaInicio}" pattern="HH:mm"/>-<fmt:formatDate value="${ev.horaFin}" pattern="HH:mm"/></div>									
										</div>
									</a>											
									
							</c:if>
							
							<c:if test="${ev['class'] == 'class model.EventoReunion'}">
								
									<a id="${ev.id}-${ev.duracion}#${ev.strFecha}" name="${ev.getEstado() }"
	  									href="${pageContext.request.contextPath}/verEventoReunion.htm?id=${ev.id}" 
	  								 	style="height:${40*ev.duracion+5*(ev.duracion-1)}px;"
	  									<c:if test="${usuario.id == ev.usuario.id}">
	   										class="dragEvento"
	   									</c:if>
	   									<c:if test="${usuario.id != ev.usuario.id}"> 
	   										class="noDragEvento"
	   									</c:if>
	   									>
	   									<!-- Hago la segunda  para tener una clase para usar el hover -->
	   									<span class='glyphicon glyphicon-pushpin' aria-hidden='true' style="float: right;"></span>
		   								<div class="descripcionEvento">
			   								${ev.nombre} 
											<div class="horaEvento"><fmt:formatDate value="${ev.horaInicio}" pattern="HH:mm"/>-<fmt:formatDate value="${ev.horaFin}" pattern="HH:mm"/></div>
		   								</div>
	  								</a>
										
							</c:if>			
															
						</c:if>
					
					</c:forEach>

															
						<div id="divHora"></div>
					</c:forEach>
				</div>	
			</c:forEach>		
		</div>
	</div>
</div>

	<div id="navegarSemanas">

		<div id="semanaAtras">
			<a href='<c:url value="/cargarAgenda.htm?semana=-1" />' class="boton"  type="button">
	      			<span class="glyphicon glyphicon-arrow-left"></span> <fmt:message key="boton.agenda.anterior"/>
			</a>
		</div>
		<div id="semanaAdelante">
			<a href='<c:url value="/cargarAgenda.htm?semana=1" />' class="boton" type="button">
	      			<span class="glyphicon glyphicon-arrow-right"></span> <fmt:message key="boton.agenda.siguiente"/>
			</a>
		</div>
	</div>
<div class="content">	
	<%@include file="../jspf/bottom.jspf"%>
</div>	
	
	<script type="text/javascript">
 		cargarMapaHorario();
  		getCompartidos();
	</script>		
</body>
</html>
