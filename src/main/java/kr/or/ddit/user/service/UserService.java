package kr.or.ddit.user.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.user.dao.UserDao;
import kr.or.ddit.user.dao.UserDaoI;
import kr.or.ddit.user.vo.PageVo;
import kr.or.ddit.user.vo.UserVo;

@Service("userService")
public class UserService implements UserServiceI{
	
	@Resource(name="userDao")
	private UserDao userDao;
	
	@Override
	public List<UserVo> selectAllUser() {
		return userDao.selectAllUser();
	}

	@Override
	public UserVo selectUser(String userid) {
		return userDao.selectUser(userid);
	}

	@Override
	public Map<String, Object> selectPagingUser(PageVo vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<UserVo> userList = userDao.selectPagingUser(vo);
		int userCnt = userDao.selectAlluserCnt();
		
		map.put("userList", userList);
		map.put("userCnt", userCnt);
		map.put("pagination", (int)Math.ceil((double)userDao.selectAlluserCnt() / vo.getPageSize()) );
		
		return map;
	}

	@Override
	public int modifyUser(UserVo userVo) {
		
		return userDao.modifyUser(userVo);
	}

	@Override
	public int insertUser(UserVo userVo) {
		return userDao.insertUser(userVo);
	}

	@Override
	public int deleteUser(String userid) {
		
		return userDao.deleteUser(userid);
	}

	@Override
	public Map<String, Object> selectPagingUserid(PageVo vo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<UserVo> userList = userDao.selectPagingUserid(vo);
		int userCnt = userDao.selectUserid(vo.getUserid());
		
		map.put("userList", userList);
		map.put("userCnt", userCnt);
		
		return map;
	}

	@Override
	public Map<String, Object> selectPagingUsernm(PageVo vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		List<UserVo> userList = userDao.selectPagingUsernm(vo);
		int userCnt = userDao.selectnm(vo.getUsernm());
		
		map.put("userList", userList);
		map.put("userCnt", userCnt);
		
		return map;
	}

	@Override
	public Map<String, Object> selectPagingalias(PageVo vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		List<UserVo> userList = userDao.selectPagingalias(vo);
		int userCnt = userDao.selectalias(vo.getAlias());
		
		map.put("userList", userList);
		map.put("userCnt", userCnt);
		
		return map;
	}

	
	
}