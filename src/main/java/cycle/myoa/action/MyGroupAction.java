package cycle.myoa.action;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cycle.myoa.base.BaseAction;
import cycle.myoa.domain.MyGroup;
import cycle.myoa.domain.easyui.Grid;
import cycle.myoa.domain.easyui.Json;
import cycle.myoa.utils.HqlFilter;

/**
 * 机构、类别、群组action
 * @author jyj
 *
 */
@Controller("myGroupAction")
@Scope("prototype")
public class MyGroupAction extends BaseAction<MyGroup> {

	private static final long serialVersionUID = 7584495575182277526L;

	/**
	 * 新增
	 */
	public void save(){
		Json json = new Json();
		if(model!=null){
			MyGroup group = new MyGroup();
			BeanUtils.copyProperties(model, group);
			try {
				myGroupService.save(group);
				json.setSuccess(true);
				json.setMsg("新建机构【"+group.getName()+"】成功");
				json.setObj(group);
			} catch (Exception e) {
				json.setMsg("新建失败");
				e.printStackTrace();
			}
		}
		writeJson(json);
	}
	
	/**
	 * 修改
	 */
	public void edit(){
		Json json = new Json();
		MyGroup group = myGroupService.getById(model.getId());
		group.setName(model.getName());
		group.setDescription(model.getDescription());
		try {
			myGroupService.update(group);
			json.setSuccess(true);
			json.setMsg("机构【" + group.getName() + "】修改成功");
			json.setObj(group);
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("操作失败");
		}

		writeJson(json);
	}
	
	/**
	 * 删除一批对象
	 */
	public void delete() {
		Json json = new Json();
	
		String hql = "delete MyGroup g where g.id in (";
		String[] nids = ids.split(",");
		for (int i = 0; i < nids.length; i++) {
			if (i > 0) {
				hql += ",";
			}
			hql += "'" + nids[i] + "'";
		}
		hql += ")";
		try {
			int num = myGroupService.executeHql(hql);
			json.setSuccess(true);
			json.setMsg("成功删除【" + num + "】条数据！");
			// json.setObj(o);
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("删除失败");
		}
		writeJson(json);
	}
	
	/**
	 * 分页查询机构
	 * 为Grid准备数据
	 */
	public void listGrid(){
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		grid.setTotal(myGroupService.countByFilter(hqlFilter));//总记录数
		grid.setRows(myGroupService.findByFilter(hqlFilter,page,rows));//获得当前页显示的数据
		writeJson(grid);
	}
	
	/**
	 * 查询出所有机构
	 */
	public void findAll(){
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		writeJson(myGroupService.findByFilter(hqlFilter));
	}
}
