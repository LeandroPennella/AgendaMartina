<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
<jsp:include page="header.jsp" />
	<script type="text/javascript">

		var listaInvitados = [];
		
		$(function() {
			
			<c:forEach var="inv" items="${invitaciones}">
				listaInvitados.push({id: "${inv.usuario.id}" , nombre:  "${inv.usuario.nombreUSR}" + " (${inv.usuario.nombreREAL} ${inv.usuario.apellido})" , estado:  "${inv.estado}"});
     	    </c:forEach>
     	    console.log(listaInvitados)
 			inicializar()
		});	
		
	
			

	  function inicializar() {
	 		refreshInvitados(listaInvitados)
	 		
		  $('#datepicker').datepicker({ dateFormat: 'dd/mm/yy' }).val();
		  
		  $(document).on('click', '.btnBorrar', function() {
				var value = $(this).attr('name');
				var usuario = {}
				usuario.id = value 
				console.log(value);
				
				desinvitar(value);
			}
		  );

			var idUsuarios = [];
			 var selID;
			$( "#invitadosPosibles" ).autocomplete({
		      source: function(request, response) {
		    	 
			      $.ajax({
						url: '<c:url value="/services/coincidenciasUSR/" />'+request.term,
						type: "GET",
						dataType: "json",
						success: function(data) {
							var nombres = [];
							
							
							for(var i=0; i<data.length; i++) {
								var estaInvitado = false;
								
								for(var j=0; j<listaInvitados.length; j++) {
									if(listaInvitados[j].id == data[i].id) {	
										estaInvitado = true;
										break;
									}
								}
								if(!estaInvitado) {
									nombres.push(data[i].nombreUSR + " ("+ data[i].nombreREAL +" "+ data[i].apellido +")");
									idUsuarios[data[i].nombreUSR   + " ("+ data[i].nombreREAL +" "+ data[i].apellido + ")"] = data[i].id;
									selID = data[i].id;
								}
							}
							response(nombres.slice(0,5));
						}
			      });
		      },
		      minLength: 1,
		      select: function( event, ui ) {
		    	  console.log("!!!!!!")
		    	  var usr = ui.item.label;
		    	  console.log(idUsuarios[usr])  
		    	  
		    	 
		    	  
		    			  
		    	 listaInvitados.push({id: idUsuarios[usr], nombre: ui.item.label, estado: "pendiente"});
		    	  refreshInvitados(listaInvitados);
		    	  $(this).val('');
	 		      return false;
		      }
			});
				
	}
	  
// 	  RECORDAR QUE EL RefreshInvitados DE EDITAR NO ES EL MISMO QUE NUEVO!!!!


	  function refreshInvitados(listaInvitados)
	  {
		  console.log(listaInvitados);
	    	var dibujarTabla = "<table class='table text-center'> <thead><th colspan='3' class='text-center'><fmt:message key='label.invitados' /></th></thead>";
	    	
	  	for(i=0; i<listaInvitados.length; i++)	
	  	{
	  		var usr={}
	  		usr = listaInvitados[i];

	  		dibujarTabla +="<tr><td>";
		
		  	if(usr.estado == "Pendiente"){
				dibujarTabla += "<span class='glyphicon glyphicon-record' aria-hidden='true'></span>";
				estado = "<td><fmt:message key='select.Pendiente'/></td>";
			}else if(usr.estado == "Rechazado"){
				dibujarTabla += "<span class='glyphicon glyphicon-ban-circle' aria-hidden='true'></span>";
				estado = "<td><fmt:message key='select.Rechazado'/></td>";
			}else{
				dibujarTabla += "<span class='glyphicon glyphicon-ok-circle' aria-hidden='true'></span>";
				estado = "<td><fmt:message key='select.Confirmado'/></td>";
			}
	  		
	  		dibujarTabla += "</td><td><strong>"+usr.nombre+"</strong></td>"; 
	  		dibujarTabla +=  estado;
	  		
	  		if ('${USRActual.id}' == '${eventoReunion.usuario.id}'){
	  			dibujarTabla += "<td><button type='button' class='btnBorrar btn btn-danger' name='"+ usr.id +"'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span></button></td>";
	  		}
	  		dibujarTabla += "</tr>";
	  	}
	  	dibujarTabla += "</table>";
	  	
	  	for(i=0; i<listaInvitados.length; i++)
	  	{
	  		console.log(listaInvitados);
	  		dibujarTabla += "<input type='hidden'name=invitado_" + listaInvitados[i].id + " value=" + listaInvitados[i].id + "></>"
	  	}
	  	$("#InvitadosSeleccionados").html(dibujarTabla);
	  }
	  
	  
		function desinvitar(id) {
			console.log(listaInvitados)
		  	for(i=0; i<listaInvitados.length; i++)
		  	{
		  		if(listaInvitados[i].id == id){
		  			listaInvitados = jQuery.grep(listaInvitados, function( a ) {
		  			  return a !== listaInvitados[i]
		  			});
		  		}
		  	}
		  	refreshInvitados(listaInvitados)
		  	
		}

	</script>		
	
</head>
<body>

	<c:import url="/views/navbar.jsp"></c:import>
	<div class="content">	
		<div class="container">
			<center>
				<h1><fmt:message key="titulo.editarEventoReunion"/></span></h1>

				<b><a href='<c:url value="/cargarAgenda.htm?semana=0" />'><fmt:message key="general.volverAAgenda"/></a><br/></b>
				
				<c:if test="${USRActual.id == eventoReunion.usuario.id}">
					<form:form method="POST" commandName="eventoReunion" action="editarEventoReunion.htm">
						<b><fmt:message key="label.creador" />: <fmt:message key="label.vos" /></b>

						<div id="creador" class="panel panel-default">
						
							<div class="panel-heading">
								<h3 class="panel-title"><fmt:message key="label.eventoReunion" /><span class='glyphicon glyphicon-cog' aria-hidden='true' style="float: right;"></h3>
							</div>
							
							<div class="panel-body">
								<c:if test="${eventoReunion.hayError == true }">
									<blockquote>
										<p style="color: red;" > <b><fmt:message key="error.evento.general"/></b></p>
									</blockquote>	
								</c:if>			  
								<div class="form-group">
									<form class="form-horizontal">
										<form:hidden path="id"/>
										<form:hidden path="idUsuario"/>
										<form:hidden path="usuario.id"/>
										<div class="form-group">
											<label for="nombre" class="col-sm-2 control-label"><fmt:message key="label.nombre" /></label>
											<div class="col-sm-10">
												<form:input path="nombre" type="text" class="form-control"/>
												<form:errors path="nombre" cssStyle="color: red" />
											</div>
											<br><br>
											<div class="Row" align="center">
												<label for="strFecha" class="col-sm-2 control-label"><fmt:message key="label.fecha" /></label>
												<div class="col-sm-2">
													<form:input id="datepicker" path="strFecha" type="text" class="form-control" placeholder="DD/MM/AAAA"/>
													<form:errors path="strFecha" cssStyle="color: red" />
												</div>
												<label for="strHoraInicio" class="col-sm-2 control-label"><fmt:message key="label.horaInicio" /></label>
												<div class="col-sm-2">
<%-- 													<form:input path="strHoraInicio" type="text" class="form-control" placeholder="HH:MM:ss" onblur="CheckTime(this)"/> --%>
											    		<form:select path="strHoraInicio" class="form-control">
															<c:forEach var="i" items="${horas}">
																<form:option value="${i}" label="${i}" />
															</c:forEach>
														</form:select>
													<form:errors path="strHoraInicio" cssStyle="color: red" />
												</div>		
												<label for="strHoraFin" class="col-sm-2 control-label"><fmt:message key="label.horaFin" /></label>
												<div class="col-sm-2">
<%-- 													<form:input path="strHoraFin" type="text" class="form-control" placeholder="HH:MM:ss" onchange="CheckTime(this)" onblur="CheckTime(this)"/> --%>
											    		<form:select path="strHoraFin" class="form-control">
															<c:forEach var="i" items="${horas}">
																<form:option value="${i}" label="${i}" />
															</c:forEach>
														</form:select>													
													<form:errors path="strHoraFin" cssStyle="color: red" />
												</div>
											</div>	
											<br><br>
											<div class="form-group">
												<label for="temario" class="col-sm-2 control-label"><fmt:message key="label.temario" /></label>
												<div class="col-sm-10">
													<form:textarea path="temario" class="form-control" type="text" />
												</div>
												<br><br><br>
												<label for=sala class="col-sm-2 control-label"><fmt:message key="label.sala" /></label>
												<div class="col-sm-10">								
													<form:select path="idSala" class="form-control">
														<c:forEach var="i" items="${salas}">
															<form:option value="${i.id}" label="${i.descripcion}" />
														</c:forEach>
													</form:select>
												</div>
												<br><br>
	
												<label for=invitadosPosibles class="col-sm-2 control-label"><fmt:message key="label.invitados" /></label>
												<div class="col-sm-10">
													<input id="invitadosPosibles" class="form-control" placeholder='<fmt:message key="label.ingreseInvitados" />' />											
												</div>
												<form:errors path="invitaciones" cssStyle="color: red" />
											<br><br>
												<div id="InvitadosSeleccionados"></div>	
									    	<div class="row" align="center">
										      <div class="col-lg-offset-1 col-lg-5">
										     	<form:button id="button1id" name="modificar" class="btn btn-lg btn-success btn-block" value="modificar"><fmt:message key="boton.eventoReunion.editar" />
										     		<span class='glyphicon glyphicon-pencil' aria-hidden='true' style="float: right;"></span>
										     	</form:button>
										     	</div>
										     	 <div class="col-lg-offset-1 col-lg-5">
										     	 <form:button id="button2id" name="borrar" class="btn btn-lg btn-danger btn-block" value="borrar"><fmt:message key="boton.eventoReunion.borrar" />
										     	 	<span class='glyphicon glyphicon-trash' aria-hidden='true' style="float: right;"></span>
										     	 </form:button>
										      </div>
								  			</div>												
										</div>	
									</div>																									
									</form>												
								</div>
							</div>
						</div>				
					</form:form>	
				</c:if>	
						
					
								 
				<c:if test="${USRActual.id != eventoReunion.usuario.id}">
					<b><fmt:message key="label.creador" />: ${eventoReunion.usuario.nombreUSR}</b>

					<div id="invitado" class="panel panel-default">
					
						<div class="panel-heading">
							<h3 class="panel-title"><fmt:message key="label.eventoReunion" /></h3>
						</div>
						<form:form method="POST" commandName="eventoReunion" action="editarEventoReunion.htm">
							<div class="panel-body">
								<c:if test="${eventoReunion.hayError == true }">
									<blockquote>
										<p style="color: red;" > <b><fmt:message key="error.evento.general"/></b></p>
									</blockquote>	
								</c:if>	
								<div class="form-group">
								<form:hidden path="id"/>
								<form:hidden path="idUsuario"/>
								<form:hidden path="usuario.id"/>
									<form class="form-horizontal">
										<form:hidden path="id"/>
										<form:hidden path="idUsuario"/>
										<form:hidden path="usuario.id"/>
										<div class="form-group">
											<label for="nombre" class="col-sm-2 control-label"><fmt:message key="label.nombre" /></label>
											<div class="col-sm-10">
												<form:input path="nombre" type="text" class="form-control" disabled="true"/>
											</div>
											<br><br>
											<div class="Row" align="center">
												<label for="strFecha" class="col-sm-2 control-label"><fmt:message key="label.fecha" /></label>
												<div class="col-sm-2">
													<form:input path="strFecha" type="text" class="form-control" placeholder="DD/MM/AAAA" disabled="true"/>
												</div>
												<label for="strHoraInicio" class="col-sm-2 control-label"><fmt:message key="label.horaInicio" /></label>
												<div class="col-sm-2">
													<form:input path="strHoraInicio" type="text" class="form-control" placeholder="HH:MM:ss" disabled="true"/>
												</div>		
												<label for="strHoraFin" class="col-sm-2 control-label"><fmt:message key="label.horaFin" /></label>
												<div class="col-sm-2">
													<form:input path="strHoraFin" type="text" class="form-control" placeholder="HH:MM:ss" disabled="true"/>
												</div>
											</div>	
											<br><br>
											<div class="form-group">
												<label for="temario" class="col-sm-2 control-label"><fmt:message key="label.temario" /></label>
												<div class="col-sm-10">
													<form:textarea path="temario" class="form-control" type="text" disabled="true"/>
												</div>
												<br><br><br>
												<label for=sala class="col-sm-2 control-label"><fmt:message key="label.sala" /></label>
												<div class="col-sm-10">								
													<form:select path="idSala" class="form-control" disabled="true">
														<c:forEach var="i" items="${salas}">
															<form:option value="${i.id}" label="${i.descripcion}" />
														</c:forEach>
													</form:select>
												</div>
												<br><br>
											</div>

										<div id="InvitadosSeleccionados" ></div>
										</div>																											
									</form>												
								</div>
							</div>
						</form:form>							
					</div>			
					<form:form method="POST" commandName="eventoReunion" action="editarMiEstadoEvento.htm">
						<div id="invitado" class="panel panel-default">
						
							<div class="panel-heading">
								<h3 class="panel-title"><fmt:message key="label.editarMiEstado" /><span class='glyphicon glyphicon-cog' aria-hidden='true' style="float: right;"></h3>
							</div>
							
							<div class="panel-body">	
								<c:if test="${eventoReunion.hayError == true }">
									<blockquote>
										<p style="color: red;" > <b><fmt:message key="error.evento.general"/></b></p>
									</blockquote>	
								</c:if>								
							
								<c:if test="${eventoReunion.getEstado()  == 'Pendiente'}">
									<span class='glyphicon glyphicon-record' aria-hidden='true'"></span>
								</c:if>
								<c:if test="${eventoReunion.getEstado()  == 'Rechazado'}">
									<span class='glyphicon glyphicon-ban-circle' aria-hidden='true'></span>
								</c:if>
								<c:if test="${eventoReunion.getEstado()  == 'Confirmado'}">
									<span class='glyphicon glyphicon-ok-circle' aria-hidden='true'></span>
								</c:if>	 
								<fmt:message key="label.tuEstado" /> : <fmt:message key="select.${eventoReunion.getEstado()}"/>
								 
								<div class="form-group">
									<form class="form-horizontal">
										<form:hidden path="id"/>
										<form:hidden path="idUsuario"/>
										<form:hidden path="usuario.id"/>									
										<div class="col-sm-offset-1 col-sm-1"  align="center">
							   		
						   				</div>
										<div class="form-group"  align="center">
											<label for=estado class="col-sm-2 control-label"><fmt:message key="label.estado" /></label>
											<div class="col-sm-5"  align="center">	
											
												<c:if test="${eventoReunion.getEstado()  == 'Pendiente'}">
												    <form:select path="estado" class="form-control">
														<form:option value="Confirmado"><fmt:message key="select.confirmado"/></form:option>
														<form:option value="Pendiente"><fmt:message key="select.pendiente"/></form:option>
														<form:option value="Rechazado"><fmt:message key="select.rechazado"/></form:option>
													</form:select>		
												</c:if>	
												<c:if test="${eventoReunion.getEstado()  != 'Pendiente' }">
												    <form:select path="estado" class="form-control" disabled="true">
														<form:option value="Confirmado"><fmt:message key="select.confirmado"/></form:option>
														<form:option value="Pendiente"><fmt:message key="select.pendiente"/></form:option>
														<form:option value="Rechazado"><fmt:message key="select.rechazado"/></form:option>
													</form:select>	
													<form:hidden path="estado" /> 	
												</c:if>	
												
											</div>
										</div>																											
									</form>			
									<br><br>									
								</div>
							    <div class="col-sm-offset-2 col-sm-1"  align="center">
							   		
						   		</div>
							    <div class="col-sm-offset-1 col-sm-5"  align="center">
							   		<form:button id="button1id" name="modificar" class="btn btn-lg btn-primary btn-block" value="modificar"><fmt:message key="boton.eventoReunion.cambiarMiEstado" />
							   			<span class='glyphicon glyphicon-pencil' aria-hidden='true' style="float: right;"></span>
							   		</form:button>
						   		</div>
							</div>
							<div class="row" align="center">

							</div>
							<br><br>	
						</div>					
					</form:form>											
				</c:if>		
			</center>
		</div>
	</div>
<div class="content">
<%@include file="../jspf/bottom.jspf"%>
</div>	
</body>
</html>