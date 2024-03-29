package cn.roothub.web.front;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.roothub.dto.PageDataBody;
import cn.roothub.dto.Result;
import cn.roothub.dto.TopicExecution;
import cn.roothub.entity.Node;
import cn.roothub.entity.Reply;
import cn.roothub.entity.Topic;
import cn.roothub.entity.User;
import cn.roothub.exception.ApiAssert;
import cn.roothub.entity.Tab;
import cn.roothub.service.CollectService;
import cn.roothub.service.NodeService;
import cn.roothub.service.NoticeService;
import cn.roothub.service.ReplyService;
import cn.roothub.service.NodeTabService;
import cn.roothub.service.TopicService;
import cn.roothub.service.UserService;
import cn.roothub.service.TabService;

@Controller
public class TopicController extends BaseController{

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UserService rootUserService;
	@Autowired
	private TopicService rootTopicService;
	@Autowired
	private NodeTabService rootSectionService;
	@Autowired
	private ReplyService rootReplyService;
	@Autowired
	private CollectService collectDaoService;
	@Autowired
	private NoticeService rootNoticeService;
	@Autowired
	private TabService tabService;
	@Autowired
	private NodeService nodeService;

	/**
	 * 话题详情
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/topic/{id}", method = RequestMethod.GET)
	private String detail(@PathVariable Integer id, Model model,@RequestParam(value = "p", defaultValue = "1") Integer p,HttpServletRequest request) {
		Topic topic = rootTopicService.findByTopicId(id);
		User user = getUser(request);
		topic.setViewCount(topic.getViewCount()+ 1);
		rootTopicService.updateTopic(topic);//更新话题数据
		//分页查询回复
		PageDataBody<Reply> replyPage = rootReplyService.page(p, 50, id);
		int countByTid = collectDaoService.countByTid(id);//话题被收藏的数量
		int countTopicByUserName = 0;
		int countCollect = 0;
		int notReadNotice = 0;
		if(user != null) {
			countTopicByUserName = rootTopicService.countByUserName(user.getUserName());//用户发布的主题的数量
			countCollect = collectDaoService.count(user.getUserId());//用户收藏话题的数量
			notReadNotice = rootNoticeService.countNotReadNotice(user.getUserName());//统计未读通知的数量
		}
		//BaseEntity baseEntity = new BaseEntity();
		//model.addAttribute("baseEntity", baseEntity);
		model.addAttribute("topic", topic);
		model.addAttribute("replyPage", replyPage);
		model.addAttribute("user", user);
		model.addAttribute("countByTid", countByTid);
		request.setAttribute("countTopicByUserName", countTopicByUserName);
		request.setAttribute("countCollect", countCollect);
		request.setAttribute("notReadNotice", notReadNotice);
		return "topic/detail";
	}

	/**
	 * 发布话题
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/topic/create", method = RequestMethod.GET)
	private String create(String n,HttpServletRequest request){
		List<Tab> tabList = tabService.selectAll();
		List<Node> nodeList = nodeService.findAll(null, null);
		request.setAttribute("tabList", tabList);
		request.setAttribute("nodeList", nodeList);
		request.setAttribute("node", n);
		return "topic/create";
	}

	/**
	 * 发布话题逻辑
	 * @param title
	 * @param content
	 * @param nodeTitle
	 * @param tag:标签，暂时只能输入一个
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/topic/save", method = RequestMethod.POST)
	@ResponseBody
	private Result<TopicExecution> save(String title, String content, /*String tab,*/ /*String nodeCode,*/String nodeTitle, String tag, HttpServletRequest request){
		User user = getUser(request);
		ApiAssert.notNull(user, "请先登录");
		ApiAssert.notNull(title, "标题不能为空");
		// ApiAssert.notNull(tab, "板块不能为空");
		// ApiAssert.notNull(nodeCode, "节点不能为空");
		// ApiAssert.notNull(tag, "标签不能为空");
		//TopicExecution saveTopic = rootTopicService.saveTopic(topic);
		if(StringUtils.isEmpty(tag)) tag = null;
		TopicExecution saveTopic = rootTopicService.createTopic(title, content, null, null, nodeTitle, tag ,user);
		//logger.debug(saveTopic.toString());
		return new Result<TopicExecution>(true, saveTopic);
	}

	/**
	 * 删除话题
	 * @param id
	 * @return
	 */

	@RequestMapping(value = "topic/delete",method = RequestMethod.GET)
	@ResponseBody
	public Result<String> delete(@RequestParam("id") Integer id){
		Topic topic = rootTopicService.findById(id);
		topic.setIsDelete(!topic.getIsDelete());
		topic.setUpdateDate(new Date());
		return new Result<>(true, "删除成功！");
	}

	/**
	 * 根据标签分页查找话题
	 * @param name
	 * @param model
	 * @param p
	 * @return
	 */
	@RequestMapping(value = "/tag/{name}", method = RequestMethod.GET)
	private String tag(@PathVariable String name, Model model,@RequestParam(value = "p", defaultValue = "1") Integer p) {
		PageDataBody<Topic> pageByTag = rootTopicService.pageByTag(name, p, 20);
		model.addAttribute("tagName", name);
		model.addAttribute("pageByTag", pageByTag);
		return "tag/detail";
	}
}
