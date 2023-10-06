<%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/15
  Time: 10:50 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="../inc/menu.jsp" />
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">회원정보</h1>
        </div>
    </div>
<div class="container">
    <div class="row">
        <h2 class="alert alert-danger">
            <%
                String msg = request.getParameter("msg");

                if(msg != null) {
                    if (msg.equals("0"))
                        out.println("회원정보가 수정되었습니다.");
                    else if (msg.equals("1"))
                        out.println("회원가입을 축하드립니다.");
                    else if (msg.equals("2")){
                        String sessionMemberName = (String) session.getAttribute("sessionMemberName");
                        out.println(sessionMemberName + " 님 환영합니다.");
                    }
                } else {
                    out.println("회원정보가 삭제되었습니다.");
                }
            %>
        </h2>
    </div>
</div>
</body>
</html>
