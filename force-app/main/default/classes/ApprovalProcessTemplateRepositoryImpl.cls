public inherited sharing class ApprovalProcessTemplateRepositoryImpl implements ApprovalProcessTemplateRepository {
	public List<ApprovalProcessTemplate> listByObjectName(String objectName) {
		List<ApprovalProcessTemplate> approvalProcessTemplates = new List<ApprovalProcessTemplate>();

		List<Approval_Process_Template__c> templateSObjects = [
			SELECT
				Id,
				Name,
				Entry_Criteria__c,
				Object_Type__c,
				(
					SELECT Id, Order__c, Type__c, Member_Id__c
					FROM Approval_Process_Template_Steps__r
				),
				(
					SELECT Id, Order__c, Type__c, Is_Approved_Action__c, Action_JSON__c
					FROM Approval_Process_Template_Actions__r
				)
			FROM Approval_Process_Template__c
			WHERE Object_Type__c = :objectName
		];

		for (Approval_Process_Template__c templateSObject : templateSObjects) {
			approvalProcessTemplates.add(this.createTemplateFromSObject(templateSObject));
		}

		return approvalProcessTemplates;
	}

	private ApprovalProcessTemplate createTemplateFromSObject(
		Approval_Process_Template__c templateSObject
	) {
		ApprovalProcessTemplate template = new ApprovalProcessTemplate();

		template.setId(templateSObject.Id);
		template.setName(templateSObject.Name);
		template.setObjectType(templateSObject.Object_Type__c);
		template.setEntryCriteria(templateSObject.Entry_Criteria__c);

		for (
			Approval_Process_Template_Step__c templateStepSObject : templateSObject.Approval_Process_Template_Steps__r
		) {
			template.addStep(this.createTemplateStepFromSObject(templateStepSObject));
		}

		for (
			Approval_Process_Template_Action__c templateActionSObject : templateSObject.Approval_Process_Template_Actions__r
		) {
			template.addAction(this.createTemplateActionFromSObject(templateActionSObject));
		}

		return template;
	}

	private ApprovalProcessTemplateStep createTemplateStepFromSObject(
		Approval_Process_Template_Step__c templateStepSObject
	) {
		ApprovalProcessTemplateStep templateStep = new ApprovalProcessTemplateStep();

		templateStep.setId(templateStepSObject.Id);
		templateStep.setOrder((Integer) templateStepSObject.Order__c);
		templateStep.setType(templateStepSObject.Type__c);
		templateStep.setMemberId(templateStepSObject.Member_Id__c);

		return templateStep;
	}

	private ApprovalProcessTemplateAction createTemplateActionFromSObject(
		Approval_Process_Template_Action__c templateActionSObject
	) {
		ApprovalProcessTemplateAction templateAction = new ApprovalProcessTemplateAction();

		templateAction.setId(templateActionSObject.Id);
		templateAction.setOrder((Integer) templateActionSObject.Order__c);
		templateAction.setType(templateActionSObject.Type__c);
		templateAction.setIsApprovedAction(templateActionSObject.Is_Approved_Action__c);
		templateAction.setActionJSON(templateActionSObject.Action_JSON__c);

		return templateAction;
	}
}
