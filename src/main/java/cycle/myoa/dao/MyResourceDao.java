package cycle.myoa.dao;

import java.util.Collection;

import cycle.myoa.base.BaseDao;
import cycle.myoa.domain.MyResource;

public interface MyResourceDao extends BaseDao<MyResource> {

	Collection<String> getAllMyResourceUrls();

}
