package cycle.myoa.dao.impl;

import org.springframework.stereotype.Repository;

import cycle.myoa.base.BaseDaoImpl;
import cycle.myoa.dao.RoleDao;
import cycle.myoa.domain.Role;

@Repository("roleDao")
public class RoleDaoImpl extends BaseDaoImpl<Role> implements RoleDao {


}
