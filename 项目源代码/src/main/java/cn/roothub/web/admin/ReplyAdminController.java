package cn.roothub.web.admin;

import java.util.Date;
import java.util.Map;

import cn.roothub.exception.ApiAssert;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.roothub.dto.PageDataBody;
import cn.roothub.dto.Result;
import cn.roothub.entity.Reply;
import cn.roothub.service.ReplyService;

/**
 * <p></p>
 * @author: miansen.wang
 * @date: 2019-03-30
 */
@Controller
@RequestMapping("/admin/reply")
public class ReplyAdminController {

	@Autowired
	private ReplyService replyService;
	
	/**
	 * 后台评论列表
	 * @param author: 评论用户
	 * @param topic: 话题
	 * @param startDate: 开始时间
	 * @param endDate: 结束时间
	 * @param p: 页数
	 * @param model
	 * @return
	 */
	@RequiresPermissions("reply:list")
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public String list(@RequestParam(value = "author",required = false) String author,
					   @RequestParam(value = "topic",required = false) String topic,
					   @RequestParam(value = "startDate",required = false) String startDate,
					   @RequestParam(value = "endDate",required = false) String endDate,
					   @RequestParam(value = "p",required = false,defaultValue = "1") Integer p,Model model) {
	    if (StringUtils.isEmpty(author)) author = null;
	    if (StringUtils.isEmpty(topic)) topic = null;
	    if (StringUtils.isEmpty(startDate)) startDate = null;
	    if (StringUtils.isEmpty(endDate)) endDate = null;
	    PageDataBody<Map<String, Object>> page = replyService.pageForAdmin(author, topic, startDate, endDate, p, 25);
	    model.addAttribute("page", page);
	    model.addAttribute("author", author);
	    model.addAttribute("topic", topic);
	    model.addAttribute("startDate", startDate);
	    model.addAttribute("endDate", endDate);
	    model.addAttribute("p", p);
	    return "admin/reply/list";
	}
	
	/**
	 * 后台评论编辑页面
	 * @param id: 评论ID
	 * @param model
	 * @return
	 */
	@RequiresPermissions("reply:edit")
	@RequestMapping(value = "/edit",method = RequestMethod.GET)
	public String edit(@RequestParam(value = "id") Integer id,Model model) {
		Reply reply = replyService.findById(id);
		if(reply.getIsShow())
		{ApiAssert.notTrue(true, "该评论已被屏蔽");
		return "/";}
		else{model.addAttribute("reply", reply);
			model.addAttribute("vEnter", "\n");
			return "admin/reply/edit";}

	}
	
	/**
	 * 后台评论编辑接口
	 * @param id: 评论ID
	 * @param content: 评论内容
	 * @return
	 */
	@RequiresPermissions("reply:edit")
	@RequestMapping(value = "/edit",method = RequestMethod.POST)
	@ResponseBody
	public Result<String> edit(@RequestParam(value = "id") Integer id,
							   @RequestParam(value = "content") String content){
		Reply reply = replyService.findById(id);
		reply.setReplyContent(content);
		reply.setUpdateDate(new Date());
		replyService.update(reply);
		return new Result<>(true, "编辑成功！");
	}


	/**
	 * 删除评论
	 * @param id: 评论ID
	 * @return
	 */
	@RequiresPermissions("reply:delete")
	@RequestMapping(value = "/delete",method = RequestMethod.GET)
	@ResponseBody
	public Result<String>  delete(@RequestParam(value = "id") Integer id){

		Reply reply = replyService.findById(id);
		if(reply.getIsShow() == true)
		{return new Result<>(true, "该评论已被屏蔽，严禁删除！");}
		else
			{replyService.deleteByReplyId(id);
			return new Result<>(true, "删除成功！");}

	}

	/**
	 * 屏蔽评论
	 * @param id: 评论ID
	 * @return
	 */
	@RequiresPermissions("reply:delete")
	@RequestMapping(value = "/block",method = RequestMethod.GET)
	@ResponseBody
	public Result<String> block(@RequestParam(value = "id") Integer id){
		Reply reply = replyService.findById(id);
		reply.setIsShow(!reply.getIsShow());
		reply.setUpdateDate(new Date());
		replyService.update(reply);
		return new Result<>(true, "操作成功！");
	}
}
