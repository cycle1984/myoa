package cycle.myoa.dao.impl;

import org.springframework.stereotype.Repository;

import cycle.myoa.base.BaseDaoImpl;
import cycle.myoa.dao.DocumentDao;
import cycle.myoa.domain.Document;

@Repository("documentDao")
public class DocumentDaoImpl extends BaseDaoImpl<Document> implements
		DocumentDao {


}
