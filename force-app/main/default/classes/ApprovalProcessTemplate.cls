public inherited sharing class ApprovalProcessTemplate {
	private Id id;
	private String name;
	private String objectType;
	private String entryCriteria;
	private Integer order;
	private List<ApprovalProcessTemplateStep> steps;
	private List<ApprovalProcessTemplateAction> actions;

	public ApprovalProcessTemplate() {
		this.steps = new List<ApprovalProcessTemplateStep>();
		this.actions = new List<ApprovalProcessTemplateAction>();
	}

	public Id getId() {
		return this.id;
	}

	public void setId(Id id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getObjectType() {
		return this.objectType;
	}

	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	public String getEntryCriteria() {
		return this.entryCriteria;
	}

	public void setEntryCriteria(String entryCriteria) {
		this.entryCriteria = entryCriteria;
	}

	public Integer getOrder() {
		return this.order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public Boolean isEntryCriteriaSatisfied(SObject contextRecord) {
		SObjectType contextType = contextRecord.getSObjectType();

		if (contextType.getDescribe().getName() != this.objectType) {
			throw new ApprovalProcessTemplateException(
				'Object types of approval process template and context record are not the same'
			);
		}

		FormulaEval.FormulaInstance formula = Formula.builder()
			.withFormula(this.entryCriteria)
			.withType(contextRecord.getSObjectType())
			.withReturnType(FormulaEval.FormulaReturnType.Boolean)
			.build();

		return (Boolean) formula.evaluate(contextRecord);
	}

	public void addStep(ApprovalProcessTemplateStep step) {
		this.steps.add(step);
	}

	public Map<String, List<ApprovalProcessTemplateStep>> getStepsByMemberTypes() {
		Map<String, List<ApprovalProcessTemplateStep>> stepsByTypes = new Map<String, List<ApprovalProcessTemplateStep>>();

		for (ApprovalProcessTemplateStep step : this.steps) {
			if (stepsByTypes.containsKey(step.getType())) {
				stepsByTypes.get(step.getType()).add(step);
			} else {
				stepsByTypes.put(step.getType(), new List<ApprovalProcessTemplateStep>{ step });
			}
		}

		return stepsByTypes;
	}

	public List<ApprovalProcessTemplateAction> getActions() {
		return this.actions;
	}

	public void addAction(ApprovalProcessTemplateAction action) {
		this.actions.add(action);
	}

	@TestVisible
	private class ApprovalProcessTemplateException extends Exception {
	}
}
