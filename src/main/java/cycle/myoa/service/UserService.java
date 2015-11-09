package cycle.myoa.service;

import cycle.myoa.base.BaseService;
import cycle.myoa.domain.User;

public interface UserService extends BaseService<User>{

	public User login(String loginName,String pwd);//使用账号密码登录

	public User searchByLoginName(String loginN);
}
