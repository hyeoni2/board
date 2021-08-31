package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	//@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();

	//페이징
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	//추가
	public void insert(BoardVO board);
	
	
	public void insertSelectKey(BoardVO board);
	
	//조회
	public BoardVO read(Long bno);
	
	//삭제
	public int delete(Long bno);
	
	//수정
	public int update(BoardVO board);

	//전체데이터 개수처리
	public int getTotalCount(Criteria cri);

}
