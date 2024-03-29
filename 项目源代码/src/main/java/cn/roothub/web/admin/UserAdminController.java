package cn.roothub.web.admin;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import cn.roothub.entity.Topic;
import cn.roothub.exception.ApiAssert;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import cn.roothub.dto.Result;
import cn.roothub.entity.Node;
import cn.roothub.entity.User;
import cn.roothub.service.UserService;
import cn.roothub.util.StringUtil;

/**
 * <p></p>
 * @author: miansen.wang
 * @date: 2019-05-01
 */
@Controller
@RequestMapping("/admin/user")
public class UserAdminController {

	@Autowired
	private UserService userService;
	
	/**
	 * 用户列表
	 * @param username
	 * @param email
	 * @param p
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user:list")
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public String list(String username, String email, @RequestParam(value = "p",defaultValue = "1") Integer p, Model model) {
		if(StringUtils.isEmpty(username)) username = null;
		if(StringUtils.isEmpty(email)) email = null;
		model.addAttribute("username", username);
		model.addAttribute("email", email);
		model.addAttribute("p", p);
		model.addAttribute("page", userService.pageForAdmin(username, email, p, 25));
		return "/admin/user/list";
	}

	/**
	 * 同意用户注册
	 * @param id
	 * @return
	 */
	@RequiresPermissions("user:edit")
	@RequestMapping(value = "/agree",method = RequestMethod.GET)
	@ResponseBody
	public Result<String> agree(@RequestParam("id") Integer id){
		User user = userService.findById(id);
		user.agree("1");
		userService.updateUser(user);
		ApiAssert.isTrue(user.getUserType().equals("1"), "已同意该用户注册");
		return new Result<>(true, "已同意该用户注册！");
	}

	/**
	 * 编辑用户界面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user:edit")
	@RequestMapping(value = "/edit",method = RequestMethod.GET)
	public String edit(Integer id, Model model) {
		model.addAttribute("user", userService.findById(id));
		return "/admin/user/edit";
	}



	/**
	 * 编辑用户接口
	 * @param user
	 * @param
	 * @return
	 */
	@RequiresPermissions("user:edit")
	@RequestMapping(value = "/edit",method = RequestMethod.POST)
	@ResponseBody
	public Result<String> edit(User user){
		userService.updateAdmin(user);
		return new Result<>(true, "编辑成功");
	}
	

	@RequiresPermissions("user:delete")
	@RequestMapping(value = "/delete",method = RequestMethod.GET)
	@ResponseBody
	public Result<String> delete(Integer id){
		User user = userService.findById(id);
		user.agree("1");
		userService.updateUser(user);
		ApiAssert.isTrue(user.getUserType().equals("1"), "已同意该用户注册");
		return new Result<>(true, "已同意该用户注册！");
	}
	
	/**
	 * 刷新Token
	 * @return
	 */
	@RequestMapping(value = "/refreshToken",method = RequestMethod.GET)
	@ResponseBody
	public Result<String> refreshToken(){
		return new Result<>(true, StringUtil.getUUID());
	}
	
	/**
	 * 局部日期转换，将 String 类型的时间数据转化为 Date 类型
	 * @param binder
	 * @param request
	 */
	@InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        // 转换日期 注意这里的转化要和传进来的字符串的格式一直 如2015-9-9 就应该为yyyy-MM-dd
        DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
        // CustomDateEditor为自定义日期编辑器
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	
	/**
	 * 锁定用户
	 * 
	 * @param id
	 * @param status
	 * @return
	 */
	@RequiresPermissions("user:edit")
	@RequestMapping(value = "/block",method = RequestMethod.GET)
	@ResponseBody
	public Result<String> block(@RequestParam(value = "id") Integer id, @RequestParam(value = "status") boolean status){
		User user = userService.findById(id);
		if (user == null) {
			return new Result<>(false, "用户不存在");
		}
		user.setIsBlock(status);
		userService.updateUser(user);
		return new Result<>(true, "操作成功");
	}
}
