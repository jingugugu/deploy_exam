<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/15
  Time: 5:15 PM
  To change this template use File | Settings | File Templates.
  회원 탈퇴
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="../inc/dbconn.jsp" %>
  <%
    request.setCharacterEncoding("UTF-8");

    String sessionMemberId = (String) session.getAttribute("sessionMemberId");

    PreparedStatement preparedStatement = null;
    String sql = "DELETE FROM member WHERE memberId = ?";
    preparedStatement = connection.prepareStatement(sql);
    preparedStatement.setString(1, sessionMemberId);
    preparedStatement.executeUpdate();

    session.invalidate();

    response.sendRedirect("resultMember.jsp");
  %>
