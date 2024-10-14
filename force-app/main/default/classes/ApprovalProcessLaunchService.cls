public with sharing class ApprovalProcessLaunchService {
	private ApprovalProcessTemplateRepository repo;

	public ApprovalProcessLaunchService(ApprovalProcessTemplateRepository repo) {
		this.repo = repo;
	}

	public void launchApprovalProcessForRecords(List<SObject> records) {
		String objectName = records[0].getSObjectType().getDescribe().getName();

		List<ApprovalProcessTemplate> approvalProcessTemplates = this.repo.listByObjectName(
			objectName
		);

        Map<Id, ApprovalProcessTemplate> templatesByRecordIds = new Map<Id, ApprovalProcessTemplate> ();

		for (SObject record : records) {
            ApprovalProcessTemplate template = this.getTemplateForRecord(record, approvalProcessTemplates);

            if(template != null) {
                templatesByRecordIds.put(record.Id, template);
            }
		}

        System.debug('templatesByRecordIds >> ' + templatesByRecordIds);
	}

    private ApprovalProcessTemplate getTemplateForRecord(SObject record, List<ApprovalProcessTemplate> approvalProcessTemplates) {
        ApprovalProcessTemplate resultTemplate;

        for(ApprovalProcessTemplate template : approvalProcessTemplates) {
            if(template.isEntryCriteriaSatisfied(record)) {
                resultTemplate = template;
            }
        }

        return resultTemplate;
    }
}
