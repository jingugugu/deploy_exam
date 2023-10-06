package dao;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;
import org.junit.jupiter.api.Test;

public class BoardTests {
    @Test
    public void testBoardInsert() { // 글 생성
        for (int i = 1; i <= 100; i++) {
            BoardDAO boardDAO = BoardDAO.getInstance();
            BoardDTO boardDTO = new BoardDTO();
            boardDTO.setMemberId("test" + i);
            boardDTO.setSubject("제목" + i);
            boardDTO.setContent("내용" + i);
            boardDTO.setName("작성자" + i);
            boardDTO.setHit(1);
            boardDTO.setIp("12312");
            boardDTO.setAddDate("2020-01-01");
            boardDAO.insertBoard(boardDTO);
        }
    }

    @Test // 아래의 메서드는 테스트 코드라는 것을 알려주는 어노테이션
    public void testGetBoardByNum() { // 글 상세페이지 불러오기
        // 테스트 메서드는 public void으로 시작하고 매개변수를 선언하지 않음
        int num = 5; // 테이블에 존재하는 primary key 1 번에

        BoardDAO boardDAO = BoardDAO.getInstance();
        BoardDTO boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO);
    }

    @Test
    public void testUpdateBoard() {
        int num = 99;
        BoardDAO boardDAO = BoardDAO.getInstance();

        BoardDTO boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO); // 수정전 출력


        boardDTO.setSubject("제목 수정");
        boardDTO.setContent("내용 수정");
        boardDTO.setName("작성자 수정");
        boardDAO.updateBoard(boardDTO);

        // 수정후 데이터 출력
        System.out.println(boardDTO);
    }

    @Test
    public void testDeleteBoard() {
        int num = 97;
        BoardDAO boardDAO = BoardDAO.getInstance();

        BoardDTO boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO); // 수정전 출력

        boardDAO.deleteBoard(num); // 지우고

        boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO); // 지우고 출력

    }
}
