package cycle.myoa.dao.impl;

import java.util.Collection;

import org.springframework.stereotype.Repository;

import cycle.myoa.base.BaseDaoImpl;
import cycle.myoa.dao.MyResourceDao;
import cycle.myoa.domain.MyResource;

@Repository("myResourceDao")
public class MyResourceDaoImpl extends BaseDaoImpl<MyResource> implements
		MyResourceDao {

	@SuppressWarnings("unchecked")
	@Override
	public Collection<String> getAllMyResourceUrls() {
		return getCurrentSession().createQuery("SELECT DISTINCT r.url FROM MyResource r where r.url IS NOT NULL").list();
	}

}
