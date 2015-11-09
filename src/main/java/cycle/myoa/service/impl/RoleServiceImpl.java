package cycle.myoa.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cycle.myoa.base.BaseServiceImpl;
import cycle.myoa.dao.RoleDao;
import cycle.myoa.domain.Role;
import cycle.myoa.service.RoleService;

@Service("roleService")
public class RoleServiceImpl extends BaseServiceImpl<Role> implements
		RoleService {

	@Resource(name="roleDao")
	private RoleDao roleDao;
	
	@Override
	public Role getByName(String name) {
		String hql = "FROM Role r where r.name=:name";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		return roleDao.getByHql(hql,params);
	}

}
