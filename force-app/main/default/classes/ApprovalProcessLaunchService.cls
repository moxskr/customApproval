public with sharing class ApprovalProcessLaunchService {
	private ApprovalProcessTemplateRepository repo;
	private UserDao userDao;

	public ApprovalProcessLaunchService(ApprovalProcessTemplateRepository repo, UserDao userDao) {
		this.repo = repo;
		this.userDao = userDao;
	}

	public void launchApprovalProcessForRecords(List<SObject> records) {
		Map<Id, ApprovalProcessTemplate> templatesByRecordIds = this.getTemplatesByRecordIds(records);

		if(templatesByRecordIds.isEmpty()) {
			return;
		}

		Map<Id, List<Id>> userIdsByMemberIds = this.getUserIdsByMemberIds(templatesByRecordIds);

		System.debug('templatesByRecordIds >> ' + templatesByRecordIds);
	}

	private Map<Id, ApprovalProcessTemplate> getTemplatesByRecordIds(List<SObject> records) {
		List<ApprovalProcessTemplate> approvalProcessTemplates = this.getApprovalProcessTemplates(records);

		Map<Id, ApprovalProcessTemplate> templatesByRecordIds = new Map<Id, ApprovalProcessTemplate>();
		
		for (SObject record : records) {
			ApprovalProcessTemplate template = this.getTemplateForRecord(
				record,
				approvalProcessTemplates
			);

			if (template != null) {
				templatesByRecordIds.put(record.Id, template);
			}
		}

		return templatesByRecordIds;
	}

	private List<ApprovalProcessTemplate> getApprovalProcessTemplates(List<SObject> records) {
		String objectName = records[0].getSObjectType().getDescribe().getName();

		List<ApprovalProcessTemplate> approvalProcessTemplates = this.repo.listByObjectName(
			objectName
		);

		return approvalProcessTemplates;
	}

	private ApprovalProcessTemplate getTemplateForRecord(
		SObject record,
		List<ApprovalProcessTemplate> approvalProcessTemplates
	) {
		ApprovalProcessTemplate resultTemplate;

		for (ApprovalProcessTemplate template : approvalProcessTemplates) {
			if (template.isEntryCriteriaSatisfied(record)) {
				resultTemplate = template;
			}
		}

		return resultTemplate;
	}

	private Map<Id, List<Id>> getUserIdsByMemberIds(Map<Id, ApprovalProcessTemplate> templatesByRecordIds) {
		Map<Id, List<Id>> userIdsByMemberIds = new Map<Id, List<Id>> ();

		Set<Id> roleIds = this.getRolesFromTemlates(templatesByRecordIds);

		if (!roleIds.isEmpty()) {
			userIdsByMemberIds.putAll(this.userDao.getUserIdsByRoleIds(roleIds));
		}

		return userIdsByMemberIds;
	}

	private Set<Id> getRolesFromTemlates(Map<Id, ApprovalProcessTemplate> templatesByRecordIds) {
		Set<Id> roleIds = new Set<Id> ();

		for (ApprovalProcessTemplate template : templatesByRecordIds.values()) {
			roleIds.addAll(template.getStepsRoleIds());
		}

		return roleIds;
	}
}
