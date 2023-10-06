<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원가입</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원가입</h1>
		</div>
	</div>
	<div class="container">
		<form name="frmMember" action="./processAddMember.jsp" method="post">
			<div class="form-group row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-10">
					<input type="text" name="memberId">
					<span class="memberIdCheck"></span>
					<br><input type="button" name="btnIsDuplication" value="팝업 아이디 중복 확인">
					<br><input type="button" name="btnIsDuplication2nd" value="ajax 아이디 중복 확인">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input type="text" name="passwd" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호 확인</label>
				<div class="col-sm-3">
					<input type="text" name="passwd" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이름</label>
				<div class="col-sm-3">
					<input type="text" name="memberName" class="form-control">
				</div>
			</div>
			<div class="form-group  row">
			<label class="col-sm-2">성별</label>
			<div class="col-sm-10">
				<input name="gender" type="radio" value="남"> 남
				<input name="gender" type="radio" value="여"> 여
			</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-4  ">
					<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6">
					<select name="birthmm">
						<option value="">월</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
					</select> <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4">
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50">@
					<select name="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">연락처</label>
				<div class="col-sm-3">
					<input type="text" name="phone" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-10">
					<input type="text" name="zipCode">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소 1</label>
				<div class="col-sm-10">
					<input type="text" name="address01">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소 2</label>
				<div class="col-sm-10">
					<input type="text" name="address02">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-10">
					<input type="submit" class="btn btn-primary" value="등록">
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
<script>
	document.addEventListener("DOMContentLoaded", function () {
		const frmMember = document.frmMember; // 폼을 들고옴

		// 1. 팝업을 이용한 id 중복확인
		// 팝업을 띠우는 이유는 현재 페이지에서 데이터베이스에 중복 조회를 하려면 페이지 새로고침 이외에는 방법이 없음
		const btnIsDuplication = document.querySelector('input[name=btnIsDuplication]');
		btnIsDuplication.addEventListener('click', function () {
			const memberId = frmMember.memberId.value; // 아이디 inpu에 있는 값
			if (memberId === "") {
				alert('아이디를 입력해 주세요.');
				frmMember.memberId.focus();
				return;
			}
			// 아이디 중복 확인을 위해 팝업을 띄움 , idCheck : 창을 여러개 안띄우고 새로고침해서 띄우기 위해
			window.open('popupIdCheck.jsp?id=' + memberId, 'idCheck', 'width = 500, height = 500, top = 100, left = 200, location = no');
		});
		// 2. ajax를 이용한 중복확인
		const xhr = new XMLHttpRequest(); // XMLHttpRequest 객체 생성
		const btnIsDuplication2nd = document.querySelector('input[name=btnIsDuplication2nd]');
		btnIsDuplication2nd.addEventListener('click', function () {
			const memberId = frmMember.memberId.value; // 아이디 input에 있는 값
			xhr.open('GET', 'ajaxIdCheck.jsp?id=' + memberId); // http 요청 초기화 통신 방식과 url tjfwjd
			xhr.send(); // url에 요청을 보냄
			// 이벤트 등록 XMLHttpRequest 객체의 readyState 프로퍼티 값이 변할 때마다 자동으로 호출
			xhr.onreadystatechange = () => {
				// readtState 프로퍼티의 값이 DONE : 요청한 데이터의 처리가 완료되어 응답할 준비가 완료됨
				if (xhr.readyState !== XMLHttpRequest.DONE) return;

				if (xhr.status === 200) { // 서버 에 문서가 존재함
					// console.log(xhr.respanse);
					const json = JSON.parse(xhr.response);
					if(memberId === "") {
						alert('아이디를 입력해 주세요.')
						return;
					}
					if(json.result === 'true') {
						alert('사용 불가능한 아이디 입니다.')
					}
					else {
						alert('사용 가능한 아이디 입니다.')
					}
				}
				else {
					// 서버에 문서가 존재하지 않음
					console.error('Error', xhr.status, xhr.statusText);
				}
			}
		});
		// 3. ajax를 이용한 실시간 Id 중복확인
		// 2번에서 작업된 파일을 이용
		const inputId = document.querySelector('input[name=memberId]');
		inputId.addEventListener('keyup', function () {
			const id = frmMember.memberId.value; // 아이디 input에 있는 값
			const memberIdCheck = document.querySelector('.memberIdCheck'); // 결과 문자열이 표현될 영역
			xhr.open('GET', 'ajaxIdCheck.jsp?id=' + id); // http 요청 초기화, 통신 방식과 url tjfwjd
			xhr.send(); // url에 요청을 보냄
			// 이벤트 등록 XMLHttpRequest 객체의 readyState 프로퍼티 값이 변할 때마다 자동으로 호출
			xhr.onreadystatechange = () => {
				// readtState 프로퍼티의 값이 DONE : 요청한 데이터의 처리가 완료되어 응답할 준비가 완료됨
				if (xhr.readyState !== XMLHttpRequest.DONE) return;

				if (xhr.status === 200) { // 서버 에 문서가 존재함
					// console.log(xhr.response);
					const json = JSON.parse(xhr.response);
					if (json.result === 'true') {
						memberIdCheck.style.color = 'red';
						memberIdCheck.innerHTML = '사용 불가능한 아이디 입니다.';
					} else {
						memberIdCheck.style.color = 'green';
						memberIdCheck.innerHTML = '사용 가능한 아이디 입니다.'
					}
				}
			};
		});
	});
</script>
</html>