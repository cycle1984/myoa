package cycle.myoa.service;

import cycle.myoa.base.BaseService;
import cycle.myoa.domain.Role;

public interface RoleService extends BaseService<Role> {

	Role getByName(String name);

}
