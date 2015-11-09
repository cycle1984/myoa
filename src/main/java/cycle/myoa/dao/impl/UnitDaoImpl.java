package cycle.myoa.dao.impl;

import org.springframework.stereotype.Repository;

import cycle.myoa.base.BaseDaoImpl;
import cycle.myoa.dao.UnitDao;
import cycle.myoa.domain.Unit;

@Repository("unitDao")
public class UnitDaoImpl extends BaseDaoImpl<Unit> implements UnitDao {

}
