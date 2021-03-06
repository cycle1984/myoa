package cycle.myoa.action;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Hibernate;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cycle.myoa.base.BaseAction;
import cycle.myoa.domain.Role;
import cycle.myoa.domain.Unit;
import cycle.myoa.domain.User;
import cycle.myoa.domain.easyui.Grid;
import cycle.myoa.domain.easyui.Json;
import cycle.myoa.utils.HqlFilter;
import cycle.myoa.utils.MyUtils;

/**
 * 用户表action
 * @author jyj
 *
 */

@Controller("userAction")
@Scope("prototype")
public class UserAction extends BaseAction<User> {

	private static final long serialVersionUID = -5934293027052655335L;
	
	private Integer unitId;//前台传过来的单位主键
	private Integer roleId;//前台传过来的角色主键
	
	
	/**
	 * 新增
	 */
	public void save(){
		Json json = new Json();
		if(model!=null){
			User user = new User();
			BeanUtils.copyProperties(model, user);
			user.setCreatedatetime(new Date());//创建时间
			user.setPwd(DigestUtils.md5Hex("jyj123456"));//默认密码
			if(unitId!=null){
				Unit unit = unitService.getById(unitId);
				user.setUnit(unit);
			}
			if(roleId!=null){
				Role role = roleService.getById(roleId);
				user.setRole(role);
			}
			try {
				userService.save(user);
				json.setSuccess(true);
				json.setMsg("新建用户【"+user.getName()+"】成功");
				json.setObj(user);
			} catch (Exception e) {
				json.setMsg("新建失败");
				e.printStackTrace();
			}
		}
		writeJson(json);
	}
	
	/**
	 * 注册
	 */
	public void register(){
		Json json = new Json();
		if(model!=null){
			User user = new User();
			BeanUtils.copyProperties(model, user);
			user.setCreatedatetime(new Date());//创建时间
			user.setPwd(DigestUtils.md5Hex(model.getPwd()));//用户设定的的密码
			if(unitId!=null){//设定所属单位
				Unit unit = unitService.getById(unitId);
				user.setUnit(unit);
			}
			//设定为待审核用户
			Role role = roleService.getByName("待审核用户");
			user.setRole(role);
			try {
				userService.save(user);
				json.setSuccess(true);
				json.setMsg("注册用户【"+user.getName()+"】成功，请联系管理员开通相应权限后再登陆！");
				json.setObj(user);
			} catch (Exception e) {
				json.setMsg("新建失败");
				e.printStackTrace();
			}
		}
		writeJson(json);
	}
	
	/**
	 * 注册功能里的根据登陆名称查询是否存在
	 * 
	 */
	public void searchByLoginName() throws IOException{
		String loginN = model.getLoginName().trim();//去掉前后空格
		if(loginN!=null||!"".equals(loginN)){
			User u = userService.searchByLoginName(loginN);
			if(u!=null){
				response.getWriter().write("false");
			}else{
				response.getWriter().write("true");
			}
		}
	}
	
	
	
	/**
	 * 修改
	 */
	public void edit(){
		Json json = new Json();
		User user = userService.getById(model.getId());
		BeanUtils.copyProperties(model, user,new String[] { "createdatetime","pwd" });//第三个字段为不赋值的数据
		user.setUpdatedatetime(new Date());//设置修改时间
		if(unitId!=null){
			user.setUnit(unitService.getById(unitId));//设置所属单位
		}
		if(roleId!=null){
			user.setRole(roleService.getById(roleId));//设置所属单位
		}
		try {
			userService.update(user);
			json.setSuccess(true);
			json.setMsg("用户【" + user.getName() + "】修改成功");
			json.setObj(user);
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("操作失败");
		}

		writeJson(json);
	}
	
	/**
	 * 删除一批对象
	 */
	public void delete() {
		Json json = new Json();
		System.out.println("ids"+ids);
		String hql = "delete User u where u.id in (";
		String[] nids = ids.split(",");
		for (int i = 0; i < nids.length; i++) {
			if (i > 0) {
				hql += ",";
			}
			hql += "'" + nids[i] + "'";
		}
		hql += ")";
		try {
			int num = userService.executeHql(hql);
			json.setSuccess(true);
			json.setMsg("成功删除【" + num + "】条数据！");
			// json.setObj(o);
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("删除失败");
		}
		writeJson(json);
	}
	
	/**
	 * 分页查询用户
	 * Grid
	 */
	public void listGrid(){
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		hqlFilter.addFilter("QUERY_t#loginName_S_NE", "admin");//添加过滤条件,不显示超级管理员
		grid.setTotal(userService.countByFilter(hqlFilter));//总记录数
		grid.setRows(userService.findByFilter(hqlFilter,page,rows));//获得当前页显示的数据
		writeJson(grid);
	}
	
	/** 登录页面 */
	public String loginUI() throws Exception {
		return "loginUI";
	}
	
	/**
	 * 登陆
	 * @return
	 */
	public void login(){
		Json j = new Json();
		User user = userService.login(model.getLoginName(), model.getPwd());
		if(user!=null){
			if("admin".equals(user.getLoginName())){//是管理员登录的情况
				session.setAttribute("userSession", user);//将用户信息放到session域
				j.setSuccess(true);
				j.setMsg("登录成功!");
			}else{//非管理员登录
				Hibernate.initialize(user.getRole());//强制加载对象内容
				if(user.getRole()!=null){
					Hibernate.initialize(user.getRole().getMyResources());
					Hibernate.initialize(user.getUnit());
				}
				if("待审核用户".equals(user.getRole().getName())){
					j.setMsg("您是待审核用户，请联系管理员开通相应权限后再登陆！");
				}
				session.setAttribute("userSession", user);//将用户信息放到session域
				j.setSuccess(true);
				j.setMsg("登录成功!");
			}
		}else{
			j.setMsg("登陆失败，账号或密码不正确!");
		}
		
		writeJson(j);
	}
	
	/**
	 * 注销、退出
	 * @return
	 */
	public void logout()  throws Exception{
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.removeAttribute("userSession");
		Json j = new Json();
		j.setSuccess(true);
		writeJson(j);
	}
	
	/**
	 * 初始化用户密码jyj123456
	 * @return
	 */
	public void initPassword() throws Exception{
		Json json = new Json();
		Integer[] u_ids = MyUtils.string2Integer(ids);
		try {
			for (int i = 0; i < u_ids.length; i++) {
				User user = userService.getById(u_ids[i]);
				// 2，设置要修改的属性（要使用MD5摘要）
				String md5Digest = DigestUtils.md5Hex("jyj123456");
				user.setPwd(md5Digest);
				// 3，更新到数据库
				userService.update(user);
			}
			json.setSuccess(true);
			json.setMsg("成功重置【"+u_ids.length+"】条数据");
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("重置失败");
		}
		writeJson(json);
	}

	public Integer getUnitId() {
		return unitId;
	}

	public void setUnitId(Integer unitId) {
		this.unitId = unitId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

}
