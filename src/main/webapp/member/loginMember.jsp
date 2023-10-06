<%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/15
  Time: 11:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<html>
<head>
    <title>로그인</title>
</head>
<body>
<jsp:include page="../inc/menu.jsp" />
    <div class="jumbotron">
        <div class="container">
            <div class="row">
                <h3 class="form-signin-heading">Please sing in </h3>
                <%
                    String error = request.getParameter("error");
                    if(error != null) {
                        out.println("<div class='alert alert-danger'>");
                        out.println("아이디와 비밀번호를 확인해 주세요");
                        out.println("</div>");
                    }
                %>
                <form class="frmlogin" action="./processLoginMember.jsp" method="post">
                    <div class="form-group">
                        <label for="memberId" class="sr-only">User Id</label>
                        <input type="text" name="memberId" id="memberId" class="form-control" placeholder="ID" required autofocus>
                    </div>
                    <div class="form-group">
                        <label for="passwd" class="sr-only">Password</label>
                        <input type="password" name="passwd" id="passwd" class="form-control" placeholder="Password" required>
                    </div>
                    <button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
