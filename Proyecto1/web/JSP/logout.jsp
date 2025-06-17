<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%
    // Invalidar la sesión del usuario
    session.invalidate();

    // Redirigir al login después de cerrar sesión
    response.sendRedirect("login.jsp");
%>