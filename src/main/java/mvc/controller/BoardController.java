package mvc.controller;

import mvc.service.BoardService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"*.do"})
public class BoardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp); // 폼으로 들고올때 post, get 들고 올 수 있는데 get으로 들고와도 doPost로 넘어가게 함
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BoardService boardService = BoardService.getInstance(); // 싱글턴에 있는 메서드 하나하나를 사용할려고 전체 데이터를 불러옴
        String RequestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String command = RequestURI.substring(contextPath.length());
        System.out.println("command : " + command); // 파일경로 이름에서 불러옴

        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("utf-8");

        switch (command) {
            case "/boardController/boardList.do" -> { // 등록된 글 목록 페이지 출력하기
                boardService.requestBoardList(req); // requestBoardList 값을 req객체에 저장
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/list.jsp"); // 경로설정
                requestDispatcher.forward(req, resp); // 경로로 보내줘라 req와 resp
                break;
            }
            case "/boardController/boardAddForm.do" -> { // 글 등록 폼 출력하기
                RequestDispatcher requestDispatcher = req.getRequestDispatcher( "../board/addForm.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardAddAction.do" -> { // 새로운 글 등록하기
                boardService.addBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
            case "/boardController/boardView.do" -> { // 선택된 글 상세 페이지 가져오기
                boardService.getBoardView(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/view.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardModifyForm.do" -> { // 글 수정 폼 출력하기
                boardService.getBoardView(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/modifyForm.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardModifyAction.do" -> { // 글 수정하기
                boardService.modifyBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
            case "/boardController/boardRemoveAction.do" -> { // 글 삭제하기
                boardService.removeBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
        }
    }
}
