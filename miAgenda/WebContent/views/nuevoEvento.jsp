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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<c:import url="/views/navbar.jsp"></c:import> 
<jsp:include page="scripts.jsp" />

	<script type="text/javascript">
	
	var listaInvitados = [];
	
	$(function() {
		<c:forEach var="inv" items="${invitaciones}">
			listaInvitados.push({id: "${inv.usuario.id}" , nombre:  "${inv.usuario.nombreUSR}" + " (${inv.usuario.nombreREAL} ${inv.usuario.apellido})" , estado:  "${inv.estado}"});
	    </c:forEach>
	    
		nuevoEvento();
	});	
			
	  function toggle(elemento) {
	      if(elemento.value=="privado") {
	          document.getElementById("privado").style.display = "block";
	          document.getElementById("reunion").style.display = "none";
	       }else{
	           if(elemento.value=="reunion"){
	               document.getElementById("privado").style.display = "none";
	               document.getElementById("reunion").style.display = "block";
	           }
	        }
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
		
	
	  function nuevoEvento() {
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
									idUsuarios[data[i].nombreUSR  + " ("+ data[i].nombreREAL +" "+ data[i].apellido + ")"] = data[i].id;
								}
							}
							var aux = nombres.nombre 
							response(nombres.slice(0, 5));
						}
			      });
		      },
		      minLength: 1,
		      select: function( event, ui ) {
		    	  var usr = ui.item.label;
		    	  console.log(idUsuarios[usr])
 		    	  listaInvitados.push({id: idUsuarios[usr], nombre: usr, estado: "pendiente"});
 		    	  refreshInvitados(listaInvitados);
 		    	 $(this).val('');
 		    	 return false;
		      }
			});
		  				
	}
	  
	  function refreshInvitados(listaInvitados)
	  {
		  console.log(listaInvitados);
	    	var dibujarTabla = "<table class='table text-center'> <thead><th colspan='3' class='text-center'><fmt:message key='label.invitados' /></th></thead><br>";
	    	
	  	for(i=0; i<listaInvitados.length; i++)
	  	{
	  		var usr={}
	  		usr = listaInvitados[i];
	  		var estado = "select.Pendiente"
	  		
	  		dibujarTabla +=	"<span class='glyphicon glyphicon-user' aria-hidden='true'></span>"; 
// 	  		dibujarTabla += "<tr><td><span class='glyphicon glyphicon-user' aria-hidden='true'></span></td>"; 
	  		
	  		dibujarTabla +="<td>";
			
		  	if(usr.estado == "Pendiente"){
				dibujarTabla += "<span class='glyphicon glyphicon-record' aria-hidden='true'></span>";
			}else if(usr.estado == "Pendiente"){
				dibujarTabla += "<span class='glyphicon glyphicon-ban-circle' aria-hidden='true'></span>";
			}else{
				dibujarTabla += "<span class='glyphicon glyphicon-ok-circle' aria-hidden='true'></span>";
			}
	  		
	  		dibujarTabla += "</td><td><strong>"+usr.nombre+"</strong></td>"; 
	  		
	  		
	  		dibujarTabla +=  "<td><fmt:message key='select.Pendiente'/></td>";
	  		dibujarTabla += "<td><button type='button' class='btnBorrar btn btn-danger' name='"+ usr.id +"'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span></button></td></tr>";
	  	}
	  	dibujarTabla += "</table>";
	  	
	  	for(i=0; i<listaInvitados.length; i++)
	  	{
	  		dibujarTabla += "<input name=invitado_" + listaInvitados[i].id + " value=" + listaInvitados[i].id + " type='hidden'></>"
	  	}
	  	
	  	$("#InvitadosSeleccionados").html(dibujarTabla);
	  }
	  
	  

  </script>

</head>
<body>
	<div class="content">
	
		<div class="container" align="center"> 
			<h2 class="form-signin-heading"><fmt:message key="label.nuevoEvento" /></h2>
			<fieldset class="form-group">
			    <dl>
			        <dt><label><fmt:message key="label.tipoDeEvento" /></label></dt>
			        <dd>
				        <div class="btn-group" data-toggle="buttons">
				        	<label class="btn btn-default">  
				            	<input type="radio" name="tipoEvento" onclick="toggle(this)" value="privado">&emsp; &emsp;<span class='glyphicon glyphicon-lock' aria-hidden='true'"></span> &emsp;<fmt:message key="label.privado" /> &emsp; &emsp; &emsp;							           
				            </label>
				            <label class="btn btn-default">
				            	<input type="radio"  name="tipoEvento" onclick="toggle(this)" value="reunion" >&emsp; &emsp;<span class='glyphicon glyphicon-glass' aria-hidden='true'"></span>&emsp;<fmt:message key="label.reunion" /> &emsp; &emsp; &emsp;
				            </label>
				        </div>
			        </dd>
			    </dl>
			</fieldset>
	
			
			<c:if test="${eventoPrivado.hayError == true || eventoReunion.hayError == true }">
				<blockquote>
					<p style="color: red;" > <b><fmt:message key="error.evento.general"/></b></p>
				</blockquote>	
			</c:if>		

			<div id="privado" style="display:none">						
				<form:form method="POST" commandName="eventoPrivado" action="nuevoEventoPrivado.htm">
			        		
					
					<form class="form-horizontal">


					<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title"><b><fmt:message key="label.eventoPrivado" /></b></h3>
					  </div>
					  <div class="panel-body">
					  <div class="form-group">
					    <label for="nombre" class="col-sm-2 control-label"><fmt:message key="label.nombre" />&emsp;&emsp;<span class='glyphicon glyphicon-flag' aria-hidden='true'></label>
					    <div class="col-sm-10">
					      <form:input path="nombre" type="text" class="form-control"/><br>
					      <form:errors path="nombre" cssStyle="color: red" />
					    </div>
					  	<br><br><br><br>	
						<div class="Row" align="center">
						    <label for="strFecha" class="col-sm-2 control-label"><fmt:message key="label.fecha" />&emsp;&emsp;<span class='glyphicon glyphicon-calendar' aria-hidden='true'></label>
						    <div class="col-sm-2">
						      <form:input id="datepicker" path="strFecha" type="text" class="form-control" placeholder="DD/MM/AAAA"/>
						      <form:errors path="strFecha" cssStyle="color: red" />
						    </div>
						    <label for="horaInicio" class="col-sm-2 control-label"><fmt:message key="label.horaInicio" />&emsp;&emsp;<span class='glyphicon glyphicon-time' aria-hidden='true'></label>
						    <div class="col-sm-2">
<%-- 						     <form:input id="timepicker1" path="strHoraInicio" type="text" class="form-control" placeholder="HH:MM:ss" onblur="CheckTime(this)"/> --%>
						    		<form:select path="strHoraInicio" class="form-control">
										<c:forEach var="i" items="${horas}">
											<form:option value="${i}" label="${i}" />
										</c:forEach>
									</form:select>
						    <form:errors path="strHoraInicio" cssStyle="color: red" />
						    </div>		
	  					   <label for="horaFin" class="col-sm-2 control-label"><fmt:message key="label.horaFin" />&emsp;&emsp;<span class='glyphicon glyphicon-time' aria-hidden='true'></label>
						    <div class="col-sm-2">
<%-- 						     <form:input id="timepicker" path="strHoraFin" type="text" class="form-control" placeholder="HH:MM:ss" onchange="CheckTime(this)" onblur="CheckTime(this)"/> --%>
						    		<form:select path="strHoraFin" class="form-control">
										<c:forEach var="i" items="${horas}">
											<form:option value="${i}" label="${i}" />
										</c:forEach>
									</form:select>
						     <form:errors path="strHoraFin" cssStyle="color: red" />
						    </div>
						</div>	
					  </div>					    
					  
					  <br><br><br><br>				   
						<label for="descripcion" class="col-sm-2 control-label"><fmt:message key="label.descripcion" />&emsp;&emsp;<span class='glyphicon glyphicon-pencil' aria-hidden='true'></label>
						<div class="col-sm-10">
							<form:textarea path="descripcion" class="form-control" type="text" />
						</div>
						<br><br><br><br>
					    <label for="direccion" class="col-sm-2 control-label"><fmt:message key="label.direccion" />&emsp;&emsp;<span class='glyphicon glyphicon-home' aria-hidden='true'></span></label>
					    <div class="col-sm-10">
					    	<form:input path="direccion" type="text" class="form-control"/>
					    </div>
					    <br><br><br><br>
					    <div class="form-group">
					      <div class="col-sm-offset-2 col-sm-10">
					      	<form:button class="btn btn-lg btn-primary btn-block" type="submit"><fmt:message key="label.agregarEvento" />
					      		<span class='glyphicon glyphicon-ok' aria-hidden='true' style="float: right;"></span>
					      	</form:button>
					      </div>
			  		 	</div>						
					  </div>
					</div>
					<br><br>
					</form>	
				</form:form>
			</div>				 
			<div id="reunion" style="display:none">	
				
				<form:form method="POST" commandName="eventoReunion" action="nuevoEventoReunion.htm">		
			
					<form class="form-horizontal">
					

					  <div class="panel panel-default">
						  <div class="panel-heading">
					      	<h3 class="panel-title"><b><fmt:message key="label.eventoReunion" /></b></h3>
						  </div>
						  <div class="panel-body">
						  
							  <div class="form-group">
							    <label for="nombre" class="col-sm-2 control-label"><fmt:message key="label.nombre" />&emsp;&emsp;<span class='glyphicon glyphicon-flag' aria-hidden='true'></label>
							    <div class="col-sm-10">
							      <form:input path="nombre" type="text" class="form-control"/>
							      <span class="error"><form:errors path="nombre" cssStyle="color: red" /></span>
							    </div>
							  	<br><br> <br><br>	
								<div class="Row" align="center">
								    <label for="strFecha" class="col-sm-2 control-label"><fmt:message key="label.fecha" />&emsp;&emsp;<span class='glyphicon glyphicon-calendar' aria-hidden='true'></label>
								    <div class="col-sm-2">
								      <form:input id="datepicker2" path="strFecha" type="text" class="form-control" placeholder="DD/MM/AAAA"/>
								      <form:errors path="strFecha" cssStyle="color: red" />
								    </div>
								    <label for="strHoraInicio" class="col-sm-2 control-label"><fmt:message key="label.horaInicio" />&emsp;&emsp;<span class='glyphicon glyphicon-time' aria-hidden='true'></label>
								    <div class="col-sm-2">
<%-- 								     <form:input path="strHoraInicio" type="text" class="form-control" placeholder="HH:MM:ss" onblur="CheckTime(this)"/> --%>

											<form:select path="strHoraInicio" class="form-control">
												<c:forEach var="i" items="${horas}">
													<form:option value="${i}" label="${i}" />
												</c:forEach>
											</form:select>
											
											
								     <form:errors path="strHoraInicio" cssStyle="color: red" />
								    </div>		
			  					   <label for="strHoraFin" class="col-sm-2 control-label"><fmt:message key="label.horaFin" />&emsp;&emsp;<span class='glyphicon glyphicon-time' aria-hidden='true'></label>
								    <div class="col-sm-2">
<%-- 								     <form:input path="strHoraFin" type="text" class="form-control" placeholder="HH:MM:ss" onchange="CheckTime(this)" onblur="CheckTime(this)"/> --%>
								    		<form:select path="strHoraFin" class="form-control">
												<c:forEach var="i" items="${horas}">
													<form:option value="${i}" label="${i}" />
												</c:forEach>
											</form:select>
								     <form:errors path="strHoraFin" cssStyle="color: red" />
								    </div>
								</div>	
							  </div>					    
				  			  <br><br> <br><br>										  			  
							 <div class="form-group">
								<label for="temario" class="col-sm-2 control-label"><fmt:message key="label.temario" />&emsp;&emsp;<span class='glyphicon glyphicon-bullhorn' aria-hidden='true'></label>
								<div class="col-sm-10">
									<form:textarea path="temario" class="form-control" type="text" />
								</div>
								<br><br> <br><br>	
						   		<div class="form-group" align="center">	
									<label for=sala class="col-sm-2 control-label"><fmt:message key="label.sala" />&emsp;&emsp;<span class='glyphicon glyphicon-home' aria-hidden='true'></span></label>
									<div class="col-sm-10">
										<form:select path="idSala" class="form-control">
											<c:forEach var="i" items="${salas}">
												<form:option value="${i.id}" label="${i.descripcion}" />
											</c:forEach>
										</form:select>
									</div>
								</div>	
								<br><br>
									
									
								<div class="form-group" align="center">
									<form:label path="invitaciones"  class="col-sm-2 control-label">
										<fmt:message key="label.invitados"/>
									</form:label>
									<div class="col-sm-10">
										<div class="col-sm-10">
						
											<input id="invitadosPosibles" path="invitadosPosibles" placeholder='<fmt:message key="label.ingreseInvitados" />' class="form-control"/>
											<span class="'glyphicon glyphicon-search'" aria-hidden='true'></span>
											<form:errors path="invitaciones" cssStyle="color: red" />
											<div id="InvitadosSeleccionados"></div>
						
										</div>

									</div>
								</div>
								
								
								<br>	
							    <div class="form-group" align="center">
							      <div class="col-sm-offset-2 col-sm-10">
							        <form:button class="btn btn-lg btn-primary btn-block" type="submit"><fmt:message key="label.agregarEvento" />
							        	<span class='glyphicon glyphicon-ok' aria-hidden='true' style="float: right;"></span>
							        </form:button>	
							      </div>
						  		</div>						    	
							</div>						
		 				</div>		 				
					</div>			  
				</form>	
			</form:form>
  	 	</div>	
		<hr>
		</div> 
	</div>
<div class="content">
<%@include file="../jspf/bottom.jspf"%>
</div>
</body>
</html>