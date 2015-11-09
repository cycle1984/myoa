package cycle.myoa.service;

import java.util.Collection;

import cycle.myoa.base.BaseService;
import cycle.myoa.domain.MyResource;

public interface MyResourceService extends BaseService<MyResource>{

	Collection<String> getAllMyResourceUrls();

}
