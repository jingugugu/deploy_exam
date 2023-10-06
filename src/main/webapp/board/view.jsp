<%@ page import="mvc.model.BoardDTO" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
  BoardDTO board = (BoardDTO) request.getAttribute("board");
  String pageNum = request.getParameter("pageNum");
  String sessionMemberId = (String) session.getAttribute("sessionMemberId");
%>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <meta charset="utf-8">
    <title>view</title>
</head>
<body>
  <jsp:include page="../inc/menu.jsp" />
  <div class="jumbotron">
    <div class="container">
      <h1 class="display-3">게시판</h1>
    </div>
  </div>

  <div class="container">
    <div class="form-group row">
      <label class="col-sm-2 control-label">성명</label>
      <div class="col-sm-3">
        <%=board.getName()%>
      </div>
    </div>

    <div class="form-group row">
      <label class="col-sm-2 control-label">제목</label>
      <div class="col-sm-5">
        <%=board.getSubject()%>
      </div>
    </div>

      <div class="form-group row">
        <label class="col-sm-2 control-label">내용</label>
        <div class="col-sm-8" style="word-break: break-all;">
          <%=board.getContent()%>
        </div>
    </div>
      <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
          <%
            if (sessionMemberId != null && sessionMemberId.equals(board.getMemberId())) { // 수정 권한 주기
//          if(sessionMemberId.equals(board.getMemberId()) && sessionMemberId != null) {
// 위치만 바꿨는데 이건 비회원일 떈 오류가 남, and 연산자라서 두개 조건을 다 봄 sessionMemberId 가 null 이면 null값에 equals를 할수 없으니 false 라서 뒤에 조건은 보지 않음 그래서 에러 발생
          %>
          <form name="frmView" method="post">
            <input type="hidden" name="pageNum" value="<%=pageNum%>">
            <input type="hidden" name="num" value="<%=board.getNum()%>">
          </form>
            <span class="btn btn-danger btn-remove">삭제</span>
            <span class="btn btn-success btn-modify">수정</span>
            <%
              }
            %>
            <a href="./boardList.do?pageNum=<%=pageNum%>" class="btn btn-primary">목록</a>
        </div>
      </div>
      <hr>
    </div>
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        const btnModify = document.querySelector('.btn-modify');
        const btnRemove = document.querySelector('.btn-remove');
        const frmView = document.querySelector('form[name=frmView]');

        btnModify.addEventListener('click', function () {
          frmView.action = './boardModifyForm.do';
          frmView.submit();
        });
        btnRemove.addEventListener('click', function () {
          if (confirm("해당 게시글을 삭제하시겠습니까?")) {
            frmView.action = './boardRemoveAction.do';
            frmView.submit();
          }
        });
      });
    </script>
    <jsp:include page="../inc/footer.jsp" />
</body>
</html>
