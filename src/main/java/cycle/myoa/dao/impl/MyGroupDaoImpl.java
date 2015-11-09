package cycle.myoa.dao.impl;

import org.springframework.stereotype.Repository;

import cycle.myoa.base.BaseDaoImpl;
import cycle.myoa.dao.MyGroupDao;
import cycle.myoa.domain.MyGroup;

@Repository("myGroupDao")
public class MyGroupDaoImpl extends BaseDaoImpl<MyGroup> implements MyGroupDao {


}
