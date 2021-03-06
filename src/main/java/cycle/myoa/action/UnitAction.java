package cycle.myoa.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cycle.myoa.base.BaseAction;
import cycle.myoa.domain.MyGroup;
import cycle.myoa.domain.Unit;
import cycle.myoa.domain.easyui.Grid;
import cycle.myoa.domain.easyui.Json;
import cycle.myoa.domain.easyui.Tree;
import cycle.myoa.utils.HqlFilter;

/**
 * 单位
 * @author jyj
 *
 */
@Controller("unitAction")
@Scope("prototype")
public class UnitAction extends BaseAction<Unit> {

	private static final long serialVersionUID = -8687505624472476816L;

	private Integer myGroupId;
	/**
	 * 新增
	 */
	public void save(){
		Json json = new Json();
		if(model!=null){
			Unit unit = new Unit();
			BeanUtils.copyProperties(model, unit);
			unit.setCreatedatetime(new Date());
			if(myGroupId!=null){
				MyGroup group = myGroupService.getById(myGroupId);
				unit.setMyGroup(group);
			}
			try {
				unitService.save(unit);
				json.setSuccess(true);
				json.setMsg("新建单位【"+unit.getName()+"】成功");
				json.setObj(unit);
			} catch (Exception e) {
				json.setMsg("新建失败");
				e.printStackTrace();
			}
		}
		writeJson(json);
	}
	
	/**
	 * 编辑
	 */
	public void edit(){
		
		Json json = new Json();
		if(model.getId()!=null){
			Unit u = unitService.getById(model.getId());
			BeanUtils.copyProperties(model, u,new String[] { "createdatetime" });//第三个字段为不赋值的数据
			u.setUpdatedatetime(new Date());
			
			if(myGroupId!=null){
				MyGroup group = myGroupService.getById(myGroupId);
				u.setMyGroup(group);
			}
			try {
				unitService.update(u);
				json.setSuccess(true);
				json.setMsg("单位【"+u.getName()+"】修改成功");
				json.setObj(u);
			} catch (Exception e) {
				json.setMsg("修改失败");
				e.printStackTrace();
			}
		}
		writeJson(json);
	}
	
	/**
	 * 删除一批对象
	 */
	public void delete() {
		Json json = new Json();
	
		String hql = "delete Unit u where u.id in (";
		String[] nids = ids.split(",");
		for (int i = 0; i < nids.length; i++) {
			if (i > 0) {
				hql += ",";
			}
			hql += "'" + nids[i] + "'";
		}
		hql += ")";
		try {
			int num = unitService.executeHql(hql);
			json.setSuccess(true);
			json.setMsg("成功删除【" + num + "】条数据！");
			// json.setObj(o);
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("删除失败,可能单位还存在用户");
		}
		writeJson(json);
	}
	
	/**
	 * grid表格查询所有单位
	 */
	public void listGrid(){
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		grid.setTotal(unitService.countByFilter(hqlFilter));//总记录数
		grid.setRows(unitService.findByFilter(hqlFilter,page,rows));//获得当前页显示的数据
		writeJson(grid);
	}
	
	/**
	 * 根据机构ID获得单位
	 */
	public void getUnitsByMyGroupId(){
		if(myGroupId!=null){
			String hql = "from Unit u where u.myGroup.id="+myGroupId;
			List<Unit> list = unitService.find(hql);
			writeJson(list);
		}
	}
	
	/**
	 *  收文单位菜单
	 */
	public void getUnitTree(){
		
		List<Tree> tree = new ArrayList<Tree>();//用于放树的顶点
		List<Tree> tree2 = new ArrayList<Tree>();//二级节点集合
		Tree node = new Tree();//顶点
		node.setText("全选");//顶点名称
		node.setId(999999);//设置顶点的id
		
		String hql = "from MyGroup";
		List<MyGroup> myGroups = myGroupService.find(hql);//获得所有的机构（类别）
		for (MyGroup myGroup : myGroups) {//遍历二级节点（所有机构）
			Tree node2 = new Tree();//二级节点
			node2.setText(myGroup.getName());
			node2.setId(myGroup.getId());
			node2.setState("closed");//二级菜单默认不展开
			
			List<Tree> tree3 =  new ArrayList<Tree>();//三级节点集合
			Set<Unit> cyUnits = myGroup.getUnits();//获得当前机构下的所有单位
			for (Unit unit : cyUnits) {
				Tree node3 = new Tree();//三级节点
				node3.setText(myGroup.getName());
				node3.setId(myGroup.getId());
				tree3.add(node3);//添加到三级节点树
				
				node2.setChildren(tree3);//将节点设置为当前机构的三级节点
			}
			if(node2.getChildren()!=null){//如果当前机构存在单位（既当前二级节点的子节点不为空）
				tree2.add(node2);//将此节点设置为树的二级节点
			}
		}
		node.setChildren(tree2);//将二级节点集合设为顶点的二级节点
		tree.add(node);
		writeJson(tree);
		
	}

	public Integer getMyGroupId() {
		return myGroupId;
	}

	public void setMyGroupId(Integer myGroupId) {
		this.myGroupId = myGroupId;
	}
	
	
}
