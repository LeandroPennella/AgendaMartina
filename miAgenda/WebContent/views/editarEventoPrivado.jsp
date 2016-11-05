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
</head>


<body>

	<c:import url="/views/navbar.jsp"></c:import>
	<div class="content">
		<div class="container" align="center">
			<h1 class="form-signin-heading"><b><fmt:message key="titulo.editarEventoPrivado"/></b></h1>
			<b><a href='<c:url value="/cargarAgenda.htm?semana=0" />'><fmt:message key="general.volverAAgenda"/></a><br/></b>			
			<br><br>
			<c:if test="${eventoPrivado.hayError == true}">
				<blockquote>
					<p style="color: red;" > <b><fmt:message key="error.evento.general"/></b></p>
				</blockquote>	
			</c:if>	
			<form:form method="POST" commandName="eventoPrivado" action="editarEventoPrivado.htm" >
				<form class="form-horizontal">
					<form:hidden path="id"/>
					<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title"><fmt:message key="label.eventoPrivado" /></h3>
					  </div>
					  <div class="panel-body">					
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
						    <label for="horaInicio" class="col-sm-2 control-label"><fmt:message key="label.horaInicio" /></label>
						    <div class="col-sm-2">
<%-- 						     <form:input path="strHoraInicio" type="text" class="form-control" placeholder="HH:MM:ss" onblur="CheckTime(this)"/> --%>
						    		<form:select path="strHoraInicio" class="form-control">
										<c:forEach var="i" items="${horas}">
											<form:option value="${i}" label="${i}" />
										</c:forEach>
									</form:select>						     
						     
						     <form:errors path="strHoraInicio" cssStyle="color: red" />
						    </div>		
	  					   <label for="horaFin" class="col-sm-2 control-label"><fmt:message key="label.horaFin" /></label>
						    <div class="col-sm-2">
<%-- 						     <form:input path="strHoraFin" type="text" class="form-control" placeholder="HH:MM:ss" onchange="CheckTime(this)" onblur="CheckTime(this)"/> --%>
						    		<form:select path="strHoraFin" class="form-control">
										<c:forEach var="i" items="${horas}">
											<form:option value="${i}" label="${i}" />
										</c:forEach>
									</form:select>							     
						     <form:errors path="strHoraFin" cssStyle="color: red" />
						    </div>
						</div>	
						<br><br><br><br>
						<div class="Row" align="center">
							<label for="descripcion" class="col-sm-2 control-label"><fmt:message key="label.descripcion" /></label>
							<div class="col-sm-10">
								<form:textarea path="descripcion" class="form-control" type="text" />
							</div>
						</div>
						<br><br><br>
						<div class="Row" align="center">
						    <label for="direccion" class="col-sm-2 control-label"><fmt:message key="label.direccion" /></label>
						    <div class="col-sm-10">
						    	<form:input path="direccion" type="text" class="form-control"/>
						    </div>
						  </div>
						  <br><br><br>
					  					    
					  <div class="row" align="center">
					      <div class="col-lg-offset-1 col-lg-5">
					     	<form:button id="button1id" name="modificar" class="btn btn-lg btn-success btn-block" value="modificar"><fmt:message key="boton.eventoPrivado.editar" />
					     	<span class='glyphicon glyphicon-pencil' aria-hidden='true' style="float: right;"></span>
					     	</form:button>
					     	</div>
					     	 <div class="col-lg-offset-1 col-lg-5">
					     	 <form:button id="button2id" name="borrar" class="btn btn-lg btn-danger btn-block" value="borrar"><fmt:message key="boton.eventoPrivado.borrar" />
					     	 <span class='glyphicon glyphicon-trash' aria-hidden='true' style="float: right;"></span>
					     	 </form:button>
					      </div>
					 	</div>						
					  </div>			
					</div>
					</div>																								
				</form>	
			</form:form>
		</div>
	</div>
	<div class="content">
<%@include file="../jspf/bottom.jspf"%>
</div>
</body>
</html>





