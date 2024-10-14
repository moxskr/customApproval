@IsTest
class ApprovalProcessTemplateRepoTest {
	@IsTest
	static void testApprovalProcessTemplateRepo() {
		System.runAs(new User(Id = UserInfo.getUserId())) {
			Approval_Process_Template__c template = new Approval_Process_Template__c();
			template.Name = 'Test Approval Process';
			template.Object_Type__c = 'Account';
			template.Entry_Criteria__c = 'CONTAINS(Name, \'test\')';

			insert template;

			Approval_Process_Template_Step__c templateStep = new Approval_Process_Template_Step__c();
			templateStep.Approval_Process_Template__c = template.Id;
			templateStep.Order__c = 1;
			templateStep.Type__c = 'User';
			templateStep.Member_Id__c = UserInfo.getUserId();

			insert templateStep;

			Approval_Process_Template_Action__c templateAction = new Approval_Process_Template_Action__c();
			templateAction.Approval_Process_Template__c = template.Id;
			templateAction.Order__c = 1;
			templateAction.Type__c = 'Update';
			templateAction.Is_Approved_Action__c = true;
			templateAction.Action_JSON__c = '{"description": "Approved"}';

			insert templateAction;

			Test.startTest();

			ApprovalProcessTemplateRepository repo = new ApprovalProcessTemplateRepositoryImpl();

			List<ApprovalProcessTemplate> accountTemplates = repo.listByObjectName('Account');
			List<ApprovalProcessTemplate> opportunityTemplates = repo.listByObjectName(
				'Opportunity'
			);

			Test.stopTest();

			Assert.isTrue(accountTemplates.size() > 0);
			Assert.isTrue(opportunityTemplates.size() == 0);
		}
	}
}
