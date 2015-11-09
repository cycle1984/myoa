package cycle.myoa.dao.impl;

import org.springframework.stereotype.Repository;

import cycle.myoa.base.BaseDaoImpl;
import cycle.myoa.dao.UserDao;
import cycle.myoa.domain.User;

@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {


}
