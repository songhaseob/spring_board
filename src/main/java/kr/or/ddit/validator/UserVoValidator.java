package kr.or.ddit.validator;

import java.io.FileInputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.user.vo.UserVo;

public class UserVoValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		
		return UserVo.class.isAssignableFrom(clazz);// uservo로 부터 파생이 되는지 확인하는 것
	}

	@Override
	public void validate(Object target, Errors errors) {
		UserVo userVo = (UserVo)target;
		// 검증로직을 기술
		// 에러로 판단되는 상황을 체크하여 errors에 추가
		
		//  userid 길이가 5글자 이상(5글자 허용)
		
		if(userVo.getUserid().length() < 5) {
			errors.rejectValue("userid", "length");
		}
		
	}
	
}
