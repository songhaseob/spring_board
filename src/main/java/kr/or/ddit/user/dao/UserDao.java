package kr.or.ddit.user.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.user.vo.PageVo;
import kr.or.ddit.user.vo.UserVo;

@Repository("userDao")
public class UserDao implements UserDaoI{

	@Resource(name = "sqlSessionTemplate")
	  
	private SqlSessionTemplate template;
	@Override
	public List<UserVo> selectAllUser() {
		
		return template.selectList("users.selectAllUser");
	}

	@Override
	public UserVo selectUser(String userid) {
		
		return template.selectOne("users.selectUser",userid);
	}

	@Override
	public List<UserVo> selectPagingUser(PageVo vo) {
		
		
		return template.selectList("users.selectPagingUser", vo);
	}

	@Override
	public int selectAlluserCnt() {
		
		return template.selectOne("users.selectAlluserCnt");
	}

	@Override
	public int modifyUser(UserVo userVo) {
		
		return template.update("users.modifyUser", userVo);
	}

	@Override
	public int insertUser(UserVo userVo) {
		
		return template.insert("users.insertUser", userVo);
	}

	@Override
	public int deleteUser(String userid) {
		
		return template.delete("users.deleteUser",userid);
	}
	@Override
	public List<UserVo> selectPagingUserid(PageVo vo) {
		
		return template.selectList("users.selectPagingUserid", vo);
	}
	
	@Override
	public List<UserVo> selectPagingUsernm(PageVo vo) {
		
		return template.selectList("users.selectPagingUsernm", vo);
	}
	@Override
	public List<UserVo> selectPagingalias(PageVo vo) {
		
		return template.selectList("users.selectPagingalias", vo);
		
	}

	@Override
	public int selectUserid(String userid) {
		
		return template.selectOne("users.selectUserid");
		
	}

	@Override
	public int selectnm(String userid) {
		
		return template.selectOne("users.selectnm");
	}

	@Override
	public int selectalias(String userid) {
		
		return template.selectOne("users.selectalias");
	}

	@Override
	public int selectUser() {
		
		return template.selectOne("users.selectUser");
	}
	
}
