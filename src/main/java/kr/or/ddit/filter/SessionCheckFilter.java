package kr.or.ddit.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.user.vo.UserVo;


public class SessionCheckFilter implements Filter {

  
    public SessionCheckFilter() {
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 요청 URI가 S_USER 속성이 세션에 있어야 하는 주소 인치 체크
		HttpServletRequest req =  ((HttpServletRequest)request);
		String uri =  req.getRequestURI();
		
		// session 체크가 필요 없는 주소 : login.jsp, loginController
		if(uri.endsWith("login.jsp") || 
		   uri.endsWith("loginController") || 
		   uri.contains("/css/") || 
		   uri.contains("/js/") || 
		   uri.contains("/image/")) {
		chain.doFilter(request, response);
			
		// 세션 체크가 필요 있는 주소(S_USER속성 확인)
		}else {
			UserVo user = (UserVo)req.getSession().getAttribute("S_USER");
			// user정보가 NULL ==> 로그인을 안함 ==> 로그인 화면으로 이동
			// user정보가 !NULL ==> 로그인을 한상태 ==> 요청처리
			if(user==null) {
				((HttpServletResponse)response).sendRedirect(req.getContextPath()+  "/login.jsp");
			}else {
				chain.doFilter(request, response);
			}
			
		}
		
	}

	public void destroy() {
		
	}
	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
