<%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/18
  Time: 9:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form method="post" action="/login/LoginServlet">
        <p> 아이디 : <input type="text" name="id"></p>
        <p> 비밀번호 : <input type="password" name="passwd"></p>
        <p><input type="submit" value="전송"></p>
    </form>
</body>
</html>
