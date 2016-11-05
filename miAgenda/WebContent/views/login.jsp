<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="css/base.css" rel="stylesheet" type="text/css"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" id="favicon" type="image/x-icon" href="http://calendar.google.com/googlecalendar/images/favicon_v2010_${today.date}.ico">
<link href="${pageContext.request.contextPath}/css/base.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><fmt:message key="titulo.miAgenda"/></title>
</head>
<body>

<br>
	
		<div class="loginmodal-container" align="center"> 
		<img src="img/logo.png" width="80px" height="80px">
	<div class="center-block" >
			<form:form method="POST" commandName="usuario" action="procesarUSR.htm">
	       
	        <h2 class="form-signin-heading"><fmt:message key="titulo.ingreseSusDatos"/></h2>
     			<form:label path="nombreUSR" >
					<fmt:message key="label.nombreUSR" />
				</form:label>
				
				<form:input path="nombreUSR" type="text" class="form-control" placeholder="__________________________________"/>
				<br />
				<form:errors path="nombreUSR" cssStyle="color: red" />
				<br />
				<br />
				<form:label path="password">
					<fmt:message key="label.password" />
				</form:label>
				<form:input path="password" type="password" class="form-control"  placeholder="__________________________________"/>
				<br />
				<form:errors path="password" cssStyle="color: red" />
				<br />
				<c:if test="${usuario.hayError == true}">
					<label style="color: red;font-style: inherit;"><fmt:message key="error.login"/></label>				
				</c:if>
	        	<div class="checkbox">
		          	<label>
		            	<input type="checkbox" value="remember-me" name="rememberSession"> <fmt:message key="label.recuerdame" />
		          	</label>
	        	</div>
	        <button class="btn btn-default btn-lg active" type="submit"><fmt:message key="boton.ingresar" /></button>
			</form:form>
			</div>
			
		</div> 
<!-- 	</div> -->
<div class="content">
<%@include file="../jspf/bottom.jspf"%>
</div>
		
	<div class="bottom"></div>				
</body>
</html>