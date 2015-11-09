package cycle.myoa.service.impl;

import org.springframework.stereotype.Service;

import cycle.myoa.base.BaseServiceImpl;
import cycle.myoa.domain.MyFile;
import cycle.myoa.service.MyFileService;

@Service("myFileService")
public class MyFileServiceImpl extends BaseServiceImpl<MyFile> implements
		MyFileService {

}
