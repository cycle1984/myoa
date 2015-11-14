package cycle.myoa.test;

import java.io.InputStream;
import java.util.List;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;

import cycle.myoa.utils.Installer;


@Component
public class PublicWork {

	@Resource
	private RepositoryService repositoryService;
	
	public void a1(){
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream("bpmn/work1.zip");
		Deployment deployment = repositoryService.createDeployment()
				.addZipInputStream(new ZipInputStream(inputStream))
				.deploy();
		System.out.println(deployment.getId());
	}
	
	public void a2(){
		ProcessDefinition pdList =  repositoryService.createProcessDefinitionQuery().singleResult();
	}
	public static void main(String[] args) {
		ApplicationContext ac = new ClassPathXmlApplicationContext("spring/applicationContext.xml");
		PublicWork publicWork = (PublicWork) ac.getBean("publicWork");
		publicWork.a1();
	}
}
