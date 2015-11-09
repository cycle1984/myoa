package cycle.myoa.service.impl;

import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cycle.myoa.base.BaseServiceImpl;
import cycle.myoa.dao.MyResourceDao;
import cycle.myoa.domain.MyResource;
import cycle.myoa.service.MyResourceService;

@Service("myResourceService")
public class MyResourceServiceImpl extends BaseServiceImpl<MyResource>
		implements MyResourceService {

	@Resource(name="myResourceDao")
	private MyResourceDao myResourceDao;
	
	/**
	 * 获取所拥有权限的所有URL
	 */
	@Override
	public Collection<String> getAllMyResourceUrls() {
		
		return myResourceDao.getAllMyResourceUrls();
	}

}
