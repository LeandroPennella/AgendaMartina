<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="today" class="java.util.Date" scope="session" />

<link rel="shortcut icon" id="favicon" type="image/x-icon" href="http://calendar.google.com/googlecalendar/images/favicon_v2010_${today.date}.ico">
<link href="${pageContext.request.contextPath}/css/base.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title><fmt:message key="titulo.miAgenda" /></title>

<%-- <c:set var="language" value="${not empty idioma ? idioma : not empty idioma ? idioma : pageContext.request.locale}" scope="session" /> --%>
<%-- <fmt:setLocale value="${idioma}" scope="session" /> --%>

	<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="css/base.css" rel="stylesheet" type="text/css"/>
	<link href="jq/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<script src="datepicker/js/jquery-1.9.1.min.js"></script>    
    <link type="text/css" href="css/bootstrap-timepicker.min.css" />
              
	<script type="text/javascript" src='<c:url value="/jq/jquery-1.10.2.js" />'></script>
	<script type="text/javascript" src='<c:url value="/jq/jquery-ui.js" />'></script>	

<script type="text/javascript">

$(function() {
    $( "#datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
  });
$(function() {
    $( "#datepicker2" ).datepicker({ dateFormat: 'dd/mm/yy' });
  });
</script>