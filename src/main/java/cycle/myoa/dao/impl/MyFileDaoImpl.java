package cycle.myoa.dao.impl;

import org.springframework.stereotype.Repository;

import cycle.myoa.base.BaseDaoImpl;
import cycle.myoa.dao.MyFileDao;
import cycle.myoa.domain.MyFile;

@Repository("myFileDao")
public class MyFileDaoImpl extends BaseDaoImpl<MyFile> implements MyFileDao {


}
