<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<title><fmt:message key="titulo.miAgenda" /></title>
<link rel="shortcut icon" id="favicon" type="image/x-icon" href="http://calendar.google.com/googlecalendar/images/favicon_v2010_${today.date}.ico">
<link href="${pageContext.request.contextPath}/css/base.css" rel="stylesheet" type="text/css">


<script type="text/javascript">

</script>



<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<img src="img/logo.png" width="70px" height="70px">
			<h4><fmt:message key="titulo.miAgenda" /></h4>
		</div>	
		<c:if test="${usuario.id != null}">	
		<br>
			<ul class="nav navbar-nav navbar-center">
			    <li><b>&emsp;&emsp; &emsp;&emsp; </b></li><li><b>&emsp;&emsp; &emsp;&emsp; </b></li>
				<li class="active" >
					<div class="boton2">
						<a href='<c:url value="/cargarAgenda.htm?semana=0" />'  style="color: white;"><b><fmt:message key="titulo.misEventos" />&emsp;<span class='glyphicon glyphicon-th-list' aria-hidden='true'></span></b></a>					
					</div>
				</li>
				<li><b>&emsp;&emsp;  </b></li>
				<li class="active">
					<div class="boton2">
						<a href='<c:url value="/evento.htm" />'  style="color: white;"><b><fmt:message key="titulo.crearEvento" />&emsp;<span class='glyphicon glyphicon-paperclip' aria-hidden='true'></span></b></a>
					</div>	
				</li>				

			</ul>
			<div>
			<ul class="nav navbar-nav navbar-right">
				<li  class="active">
					<div class="boton2">
						<a href='<c:url value="/logout.htm" />'style="color: white;"><b><fmt:message key="titulo.desloguearme" />&emsp;<span class='glyphicon glyphicon-off' aria-hidden='true'></span></b></a>
					</div>	
				</li><br>
				<li><h4><b style="color: gray;"><fmt:message key="label.saludo" /> &emsp; ${sessionScope.usuario.nombreUSR} !</b></h4></li>
				<li><b>&emsp;&emsp;  </b></li>
			</ul>
			
			</div>
		</c:if>	
		
	</div>	
</nav>  
        


