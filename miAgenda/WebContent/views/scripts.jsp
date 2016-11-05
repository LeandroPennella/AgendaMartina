<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    
	<script type="text/javascript">

/////////// 	EVENTOS		///////////


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
	  
	  
	  
	  
///////////     REUNION   ///////////////	  

	  function inicializarEditarReunion() {
	 		refreshInvitados(listaInvitados)
	 		
		  $('#datepicker').datepicker({ dateFormat: 'dd/mm/yy' }).val();
		  
		  $(document).on('click', '.btnBorrar', function() {
				var value = $(this).attr('name');
				var usuario = {}
				usuario.id = value 
				console.log(value);
				
				desinvitarReunion(value);
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
									idUsuarios[data[i].nombreUSR] = data[i].id;
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
		    	  console.log(selID)
		    	  listaInvitados.push({id: selID, nombre: ui.item.label, estado: "pendiente"});
		    	  refreshInvitadosReunion(listaInvitados);
		    	
		      }
			});
		    
				
	}
	  
// 	  RECORDAR QUE EL RefreshInvitados DE EDITAR NO ES EL MISMO QUE NUEVO!!!!


	  function refreshInvitadosReunion(listaInvitados)
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
	  
	  
		function desinvitarReunion(id) {
			console.log(listaInvitados)
		  	for(i=0; i<listaInvitados.length; i++)
		  	{
		  		if(listaInvitados[i].id == id){
		  			listaInvitados = jQuery.grep(listaInvitados, function( a ) {
		  			  return a !== listaInvitados[i]
		  			});
		  		}
		  	}
			refreshInvitadosReunion(listaInvitados)
		}
		
	  
/////////// 	AGENDA		///////////	  


				function reiniciarValores() {
					<c:forEach var="dia" items="${eventosXDia}">
						<c:forEach var="ev" items="${dia}">		

							var nombreEvento = "${ev.id}-${ev.duracion}#${ev.strFecha}"		
							
							
							document.getElementById(nombreEvento).style.zIndex= 10;
							document.getElementById(nombreEvento).style.left = "0%";
							document.getElementById(nombreEvento).style.width= 100 + "%";
							
				     	</c:forEach>
				     </c:forEach>		  
				}
			 
			 
			 function cambiarEnMapaHorario(nombreEvento, nuevaPos, duracion){			 
				 
				var auxId; 
				var auxFecha; 
		  		
		  		
				 for(var h=0; h < mapaHorario.length; h++) {
					 for(var e = 0; e< mapaHorario[h].length; e++){
							if(mapaHorario[h][e].name == nombreEvento){
								auxId = mapaHorario[h][e].id; 
								auxFecha = mapaHorario[h][e].fecha;
								mapaHorario[h].splice(e,1);
						} 
					 }	
				}
			 
		  		duracion = parseInt(duracion);
			  	 for(var i=0; i < duracion ; i++) {
			  		mapaHorario[nuevaPos + i].push({id: auxId, name: nombreEvento ,fecha: auxFecha});
	            }
			  	 
			 }

				
				
				
				
				function cargarMapaHorario() {
					
					for(var i=0; i<48; i++) {
						mapaHorario[i] = [];
					}

					<c:forEach var="dia" items="${eventosXDia}">
						<c:forEach var="ev" items="${dia}">		
			       			var horaInicio = "${ev.horaInicio}".substring(11, 16);
			       			var posicion = getPosicionXHora(horaInicio) 
			       			
				       		<c:forEach var="duracion" begin="0" end="${ev.duracion-1}" >
				       		
				       		var duracion = parseInt("${duracion}")
				       		
 				       			mapaHorario[posicion + duracion].push({id: "${dia}", name: "${ev.id}-${ev.duracion}",fecha: "${ev.strFecha}"});
				   
				       		</c:forEach>
				     	</c:forEach>
			     	</c:forEach>			     	
				}
				
				
				function getPosicionXHora(horaInicio) {
				
					lista = getHorasXPosicion()
					
					for(var i=0; i< lista.length; ++i)
					{
						if(lista[i].hora == horaInicio)
						{
							return lista[i].posicion;
						}
					}
				}

				
				
				
				function getPosicion(evento) {
					 var d = document.getElementById(evento);
// 					 var topPos = d.offsetTop;
					 
					 var topPos = $(d).offset().top
					return Math.floor((topPos - techo) / row);
				}
				
				function getDuracion(evento) {
					return evento.substring(evento.indexOf("-") + 1, evento.indexOf("#"));
				}
				
				function getId(evento) {
					return evento.substring(0, evento.indexOf("-"));
				}	
				
				function getDia(evento) {
					return evento.name.substring(evento.name.indexOf("#")+1);
				}	
			
				function getNuevaHora(top)
				{
					lista = getHorasXPosicion()
					for(var i=0; i< lista.length; ++i)
					{
						if(i == top)
						{
							return lista[i].hora;
						}
					}
				}
				
				function getHorasXPosicion()
				{
					var horas = []; 
					var item = 0
					'<c:forEach var="hora" items="${listaHorarios}">'
						horas.push({hora:"${hora}", posicion: item});
						item++;
					'</c:forEach>'
					
					return horas;
				}		
				
	

				function getCompartidos(){
					var diasSemana = []
					var compartir = []
					var x = 0
					var aux = [];
					
					'<c:forEach var="dia" items="${fechasSemana}">'
						diasSemana.push({numeroDia: x, dia: "${dia}"});
						x++;
					'</c:forEach>'
					
					for(var i=0; i<7; i++) {
						compartir[i] = [];
					}
					
					for(var d = 0; d < diasSemana.length; d++){
						for(var h=0; h < mapaHorario.length; h++) {
							if(mapaHorario[h].length > 1){			//SI HAY MAS DE UN EVENTO EN ESA HORA
								aux = []
								for(var e = 0; e< mapaHorario[h].length; e++){
									if(mapaHorario[h][e].fecha == diasSemana[d].dia){
										
								
										var idEvento = mapaHorario[h][e].name.substring(0, mapaHorario[h][e].name.indexOf("-"))
					 					var dur = mapaHorario[h][e].name.substring( mapaHorario[h][e].name.indexOf("-") + 1, mapaHorario[h][e].name.length);
										var nom = mapaHorario[h][e].name + "#" +  mapaHorario[h][e].fecha
										aux.push({id:idEvento, duracion: parseInt(dur), nombre: nom});
									
									}
								}	
								if (aux.length > 1){
									aux.sort(function (a, b) {
										return parseInt(b.duracion) - parseInt(a.duracion);
						        	});									
									compartir[d].push(aux)	
								}
							}
						}
					}
 					console.log(compartir)
					acomodar(compartir)
				}



				function acomodar(listaCompartidos){
					for(var a = 0; a < listaCompartidos.length; a++){
						
						for(var b = 0; b < listaCompartidos[a].length; b++){
							for(var c = 0; c < listaCompartidos[a][b].length; c++){
	 							
	 							var nombreEvento = listaCompartidos[a][b][c].nombre;
	 							var cant = listaCompartidos[a][b][c].length;
	 							var ancho = 100 - (c*15 + variante)
	 							var variante = (listaCompartidos[a][b][c].id).substring(1,1);

 	 							document.getElementById(nombreEvento).style.zIndex= c + 1;
 	 							document.getElementById(nombreEvento).style.left = c*15 + variante + "%"
  	 							document.getElementById(nombreEvento).style.width= ancho + "%";
							}	
						}					
					}
					
				}

	</script>
	