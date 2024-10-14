public inherited sharing class ApprovalProcessTemplateAction {
	private Id id;
	private Integer order;
	private String type;
	private String actionJSON;
	private Boolean isApprovedAction;

	public Id getId() {
		return this.id;
	}

	public void setId(Id id) {
		this.id = id;
	}

	public Integer getOrder() {
		return this.order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getActionJSON() {
		return this.actionJSON;
	}

	public void setActionJSON(String actionJSON) {
		this.actionJSON = actionJSON;
	}

	public Boolean getIsApprovedAction() {
		return this.isApprovedAction;
	}

	public void setIsApprovedAction(Boolean isApprovedAction) {
		this.isApprovedAction = isApprovedAction;
	}
}
