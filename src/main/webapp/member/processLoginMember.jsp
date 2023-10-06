<%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/15
  Time: 11:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="../inc/dbconn.jsp" %>
<%
    String memberId = request.getParameter("memberId");
    String passwd = request.getParameter("passwd");


    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    String sql = "SELECT * FROM member WHERE memberId=? and passwd=?;"; // member 테이블  안에있는 아이디와 비번이 입력한 아이디와 비번과 같은게 있다면 들고옴
    preparedStatement = connection.prepareStatement(sql);
    preparedStatement.setString(1, memberId);
    preparedStatement.setString(2, passwd);
    resultSet = preparedStatement.executeQuery();

    if(resultSet.next()) {
        String name = resultSet.getString("memberName");
        session.setAttribute("sessionMemberId", memberId);
        session.setAttribute("sessionMemberName", name);
        // 1. 로그인 시에 비회원 상태에서 장바구니에 담은 상품정보의 아이디 정보 업데이트
        sql = "UPDATE cart SET memberId = ? WHERE orderId=?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, memberId);
        preparedStatement.setString(2, orderId);
        preparedStatement.executeUpdate();

        // 2. 회원 아이디는 같고 주문 번호는 다른 장바구니 데이터에 현재 주문 번호로 업데이트
        sql = "UPDATE cart SET orderId = ? WHERE memberId = ? AND orderId != ? ";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, orderId);
        preparedStatement.setString(2, memberId);
        preparedStatement.setString(3, orderId);
        preparedStatement.executeUpdate();
        response.sendRedirect("resultMember.jsp?msg=2");
    }
    else {
        response.sendRedirect("loginMember.jsp?error=1");
    }

    if(resultSet != null) {
        resultSet.close();
    }
    if(preparedStatement != null) {
        preparedStatement.close();
    }
    if(connection != null) {
        connection.close();
    }


%>
</body>
</html>
