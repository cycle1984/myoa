package cycle.myoa.domain.model;

import java.io.Serializable;

/**
 * 用于模型驱动、json转换、页面显示
 * @author jyj
 *
 */
public class ProcessDefinitionModel implements Serializable {

	private static final long serialVersionUID = 2004178967353875020L;

	private String id;
	private String name;
	private String key;
	private int version;//版本
	private String resourceName;//流程资源名称
	private String deploymentId;//部署ID
	private String diagramResourceName;//流程图名称
	private boolean suspended;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getResourceName() {
		return resourceName;
	}
	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	public String getDeploymentId() {
		return deploymentId;
	}
	public void setDeploymentId(String deploymentId) {
		this.deploymentId = deploymentId;
	}
	public String getDiagramResourceName() {
		return diagramResourceName;
	}
	public void setDiagramResourceName(String diagramResourceName) {
		this.diagramResourceName = diagramResourceName;
	}
	public boolean isSuspended() {
		return suspended;
	}
	public void setSuspended(boolean suspended) {
		this.suspended = suspended;
	}
	@Override
	public String toString() {
		return "ProcessDefinitionModel [id=" + id + ", name=" + name + ", key="
				+ key + ", version=" + version + ", resourceName="
				+ resourceName + ", deploymentId=" + deploymentId
				+ ", diagramResourceName=" + diagramResourceName
				+ ", suspended=" + suspended + "]";
	}
	
}
