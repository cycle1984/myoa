package cycle.myoa.proccess.action;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cycle.myoa.base.BaseAction;
import cycle.myoa.domain.easyui.Grid;
import cycle.myoa.domain.easyui.Json;
import cycle.myoa.domain.model.ProcessDefinitionModel;

/**
 * 流程定义
 * @author jyj
 *
 */
@Controller("processDefinitionAction")
@Scope("prototype")
public class ProcessDefinitionAction extends BaseAction<ProcessDefinitionModel>{

	private static final long serialVersionUID = 5053008869710463942L;

	@Resource
	private RepositoryService repositoryService;
	
	
	/**
	 * 分页查询流程定义列表
	 */
	public void listGrid(){
		Grid grid = new Grid();
		/*
		 * 查询出来放到model，转换成json
		 */
		List<ProcessDefinition> pdList = repositoryService.createProcessDefinitionQuery().listPage(page-1, rows);//获得当前页显示的数据
		List<ProcessDefinitionModel> pdmList = new ArrayList<ProcessDefinitionModel>();
		for (ProcessDefinition processDefinition : pdList) {
			ProcessDefinitionModel pdm = new ProcessDefinitionModel();
			BeanUtils.copyProperties(processDefinition, pdm);
			pdmList.add(pdm);
		}
		grid.setTotal(repositoryService.createProcessDefinitionQuery().count());//总记录数
		grid.setRows(pdmList);
		writeJson(grid);
	}
	
	public void delete(){
		Json json = new Json();
		//获取部署id
		String[] nids = ids.split(",");
		try {
			for (String deploymentId : nids) {
				repositoryService.deleteDeployment(deploymentId, true);
			}
			json.setMsg("成功删除【" + nids.length + "】条数据！");
			// json.setObj(o);
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("删除失败,可能单位还存在用户");
		}
		writeJson(json);
		
	}
	
	/**
	 * 查看资源文件（bpmn文件和png图片文件）
	 * @throws IOException 
	 */
	public void viewResource() throws IOException{
		//1.获得流程定义
		ProcessDefinition pd = repositoryService.createProcessDefinitionQuery().processDefinitionId(model.getId()).singleResult();
		System.out.println(pd.getId());
		//2.读取资源流
		InputStream inputStream = repositoryService.getResourceAsStream(pd.getDeploymentId(),pd.getDiagramResourceName());
		//3.输出资源内容到页面
		byte[] b = new byte[1024];
		int len = -1;
		while((len=inputStream.read(b, 0, 1024))!=-1){
			response.getOutputStream().write(b, 0, len);
		}
		
	}
}

