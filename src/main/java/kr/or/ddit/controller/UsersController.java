package kr.or.ddit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.user.service.UserService;
import kr.or.ddit.user.vo.PageVo;
import kr.or.ddit.user.vo.UserVo;
import kr.or.ddit.utill.FileUtil;
import kr.or.ddit.validator.UserVoValidator;

@RequestMapping("spring")
@Controller
public class UsersController {
	
	private static final Logger logger = LoggerFactory.getLogger(UsersController.class);
	@Resource(name="userService")
	private UserService userService;
	
	// 특정 파라미터의 값이 정해진 값과 일치 할때만 해당 요청을 처리
	@RequestMapping("view")
	public String view() {
		logger.debug("들어왔냐");
		return "login";
	}
	
	@RequestMapping(path="process", method = {RequestMethod.POST})
	public String process(UserVo userVo,HttpSession session, Model model,PageVo pageVo) {
		logger.debug("userVo : {}", userVo);
		
		UserVo dbUser = userService.selectUser(userVo.getUserid());
		if(dbUser != null && userVo.getPass().equals(dbUser.getPass())) {
			session.setAttribute("S_USER", dbUser);
			model.addAttribute("userlist", userService.selectPagingUser(pageVo));
			return "redirect:/spring/paging";
		}else {
			return "redirect:/spring/view";
		}
	}
	
	@RequestMapping("paging")
	public String pagingUser(@RequestParam(defaultValue = "1") int page, 
			                 @RequestParam(defaultValue = "5") int pageSize,
			                 Model model){
		logger.debug("page :{},pageSize:{}", page,pageSize );
		
		PageVo pageVo = new PageVo(page,pageSize);
		
		model.addAllAttributes(userService.selectPagingUser(pageVo));
		
		
		return "/user/pagingUser";
	}
	
	@RequestMapping("insertview")
	public String insertView() {
		return "/user/insertuser";
	}
	
	
	@RequestMapping(path="insertUser",method = RequestMethod.POST)
	public String insertUser(@Valid UserVo userVo, BindingResult result, Model model, MultipartFile file) {
		
		new UserVoValidator().validate(userVo, result);
		
		
		logger.debug("file:{}", file);
		userVo.setFilename(file.getOriginalFilename());
		userVo.setRealfilename(file.getOriginalFilename());
		
		
		
		try {
			String fileExtension = FileUtil.getFileExtension(file.getOriginalFilename());
			String realFileName = "d:/upload/" + UUID.randomUUID().toString()+fileExtension;
			
			file.transferTo(new File(realFileName));
			userVo.setFilename(file.getOriginalFilename());
			
			userVo.setRealfilename(realFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
			int insertCnt = 0;
	
			insertCnt = userService.insertUser(userVo);
			
		
		
		if(insertCnt ==1) {
			return "redirect:/spring/paging";
		}else {
			return "/user/insertuser";
		}
	}
	@RequestMapping(path="realupdateuser",method = RequestMethod.POST)
	public String realUserModify(UserVo userVo, Model model,String userid,MultipartFile file) {
		
		if(file.getSize() == 0) {
			userVo.setFilename(userService.selectUser(userVo.getUserid()).getFilename());
			userVo.setRealfilename(userService.selectUser(userVo.getUserid()).getRealfilename());
		}else {
			
			
			try {
				String fileExtension = FileUtil.getFileExtension(file.getOriginalFilename());
				String realFileName = "d:/upload/" + UUID.randomUUID().toString()+fileExtension;
				
				file.transferTo(new File(realFileName));
				userVo.setFilename(file.getOriginalFilename());
				
				userVo.setRealfilename(realFileName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		int cnt = 0;
		try {
			cnt = userService.modifyUser(userVo);
			
		} catch (Exception e) {
			cnt = 0;
		}
		
		
		if(cnt == 1) {
			return "redirect:/spring/paging";
		}else {
			return "/user/usersupdate";
		}
	}
	
	@RequestMapping("detailuser")
	public String detailUser(String userid, Model model) {
		model.addAttribute("detaillist", userService.selectUser(userid));
		return "/user/users";
	}
	
	@RequestMapping("deleteUser")
	public String deleteUser(String userid, Model model) {
		model.addAttribute(userService.deleteUser(userid));
		return "redirect:/spring/paging";
	}
	
	@RequestMapping(path="updateuser",method = RequestMethod.POST)
	public String UserModify(String userid, Model model) {
		model.addAttribute("modifylist", userService.selectUser(userid));
		return "/user/usersupdate";
	}
	
	
	@RequestMapping(path="profile",method = RequestMethod.GET)
	public void profile(HttpServletResponse resp, String userid,HttpServletRequest req) {
		resp.setContentType("image");
		
		UserVo uservo = userService.selectUser(userid);
		String path = "";
		if(uservo.getRealfilename() == null) {
			path = req.getServletContext().getRealPath("/image/aa.jpg");
		}else {
			path = uservo.getRealfilename();
			
		}
		logger.debug("path : {}",path);
		try {
			FileInputStream fis = new FileInputStream(path);
			ServletOutputStream sos = resp.getOutputStream();
			
			byte[] buff = new byte[512];
			
			while(fis.read(buff) != -1) {
				sos.write(buff);
			}
			
			fis.close();
			sos.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		
	}
	}
	@RequestMapping("profileDownload")
	public void profiledownload(String userid, HttpServletResponse resp) {
		 UserVo userVo = userService.selectUser(userid);

		 String filename = userVo.getFilename();
	      resp.setHeader("Content-Disposition", "attachement; filename=" + filename);
	      
	      String realFilename = userVo.getRealfilename();
	      
	      try {
	         ServletOutputStream sos = resp.getOutputStream();
	         
	         FileInputStream fis = new FileInputStream(new File(realFilename));
	         byte[] buf = new byte[1024];
	         while(fis.read(buf) != -1) {
	            sos.write(buf);
	         }
	         sos.close();
	         fis.close();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	
	
}
