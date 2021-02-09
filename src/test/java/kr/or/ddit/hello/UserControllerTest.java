package kr.or.ddit.hello;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.test.config.WebTestConfig;
import kr.or.ddit.user.service.UserService;

public class UserControllerTest extends WebTestConfig{


	  @Resource(name="userService")
	   private UserService userService;
	   
	   @Test
	   public void UserTest() throws Exception{
	      mockMvc.perform(get("/spring/view"))
	      .andExpect(view().name("login"))
	      .andExpect(status().isOk())
	      .andDo(print());
	   }
	   
	   @Test
	   public void PagingTest() throws Exception{
	      mockMvc.perform(get("/spring/paging"))
	                  .andExpect(view().name("/user/pagingUser"))
	                  .andExpect(status().isOk())
	                  .andExpect(model().attributeExists("pagination"))
	                  .andExpect(model().attributeExists("userList"))
	                  .andExpect(model().attributeExists("userCnt"))
	                  .andDo(print());
	   }   
	   
	   @Test
	   public void InsertViewTest() throws Exception{
	      mockMvc.perform(get("/spring/insertview"))
	                  .andExpect(view().name("/user/insertuser"))
	                  .andExpect(status().isOk())
	                  .andDo(print());
	   }   
	
	  

}
