package kr.or.ddit.user.dao;

import java.util.List;

import kr.or.ddit.user.vo.PageVo;
import kr.or.ddit.user.vo.UserVo;

public interface UserDaoI {
	
	//전체 사용자 정보 조회
	List<UserVo> selectAllUser();
	
	//userid에 해당하는 사용자 한명의 정보 조회
	UserVo selectUser(String userid);
	
	// 사용자 페이징 조회
	List<UserVo> selectPagingUser(PageVo vo);
	
	// 사용자 전체 수 조회
	int selectAlluserCnt();
	// 사용자
	int selectUser();
	
	// 사용자 아이디 수 조회
	int selectUserid(String userid);
	// 사용자 이름 수 조회
	int selectnm(String userid);
	// 사용자 별명 수 조회
	int selectalias(String userid);
	
	// 사용자 정보 수정
	int modifyUser(UserVo userVo);
	
	// 사용자 정보 등록
	int insertUser(UserVo userVo);
	
	// 사용자 정보 삭제
	int deleteUser(String userid);
	
	// 유저 아이디 검색
	List<UserVo> selectPagingUserid(PageVo vo);
	
	// 유저 이름 검색
	List<UserVo> selectPagingUsernm(PageVo vo);
	
	// 유저 이름 검색
	List<UserVo> selectPagingalias(PageVo vo);
}
