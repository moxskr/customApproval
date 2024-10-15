@IsTest
class ApprovalProcessTemplateTest {
	@IsTest
	static void testApprovalProcessTemplate() {
		System.runAs(new User(Id = UserInfo.getUserId())) {
			ApprovalProcessTemplate inst = new ApprovalProcessTemplate();

			Test.startTest();

			inst.setName('Test Approval Process');
			inst.setObjectType('Account');
			inst.setEntryCriteria('CONTAINS(Name, \'test\')');
			inst.setOrder(1);

			Boolean resultPositive = inst.isEntryCriteriaSatisfied(
				new Account(Name = 'test account 1')
			);
			Boolean resultNegative = inst.isEntryCriteriaSatisfied(new Account(Name = 'account 1'));

			Test.stopTest();

			Assert.areEqual('Test Approval Process', inst.getName());
			Assert.areEqual('Account', inst.getObjectType());
			Assert.areEqual('CONTAINS(Name, \'test\')', inst.getEntryCriteria());
			Assert.areEqual(1, inst.getOrder());
			Assert.isTrue(resultPositive);
			Assert.isFalse(resultNegative);
		}
	}

	@IsTest
	static void testApprovalProcessTemplateNegative() {
		System.runAs(new User(Id = UserInfo.getUserId())) {
			ApprovalProcessTemplate template = new ApprovalProcessTemplate();

			Test.startTest();

			template.setName('Test Approval Process');
			template.setObjectType('Account');
			template.setEntryCriteria('CONTAINS(Name, \'test\')');
			template.setOrder(1);

			Boolean resultPositive = template.isEntryCriteriaSatisfied(
				new Account(Name = 'test account 1')
			);

			try {
				template.isEntryCriteriaSatisfied(new Opportunity(Name = 'account 1'));

				Assert.fail('ApprovalProcessTemplateException expected');
			} catch (ApprovalProcessTemplate.ApprovalProcessTemplateException exc) {
				Assert.areEqual(
					'Object types of approval process template and context record are not the same',
					exc.getMessage()
				);
			}

			Test.stopTest();

			Assert.isTrue(resultPositive);
		}
	}

	@IsTest
	static void testApprovalProcessTemplateGetStepsByTypes() {
		Id testUserId = UserInfo.getUserId();
		Id testRoleId = UserInfo.getUserRoleId();

		System.runAs(new User(Id = UserInfo.getUserId())) {
			ApprovalProcessTemplate template = new ApprovalProcessTemplate();

			ApprovalProcessTemplateStep step1 = new ApprovalProcessTemplateStep();
			ApprovalProcessTemplateStep step2 = new ApprovalProcessTemplateStep();

			step1.setType('User');
			step1.setMemberId(testUserId);
			step1.setOrder(1);

			step2.setType('Role');
			step2.setMemberId(testRoleId);
			step2.setOrder(2);

			template.addStep(step1);
			template.addStep(step2);

			Test.startTest();

			Map<String, List<ApprovalProcessTemplateStep>> stepsByTypes = template.getStepsByMemberTypes();
			Set<Id> roleIds = template.getStepsRoleIds(); 

			Test.stopTest();

			Assert.areEqual(1, stepsByTypes.get('User').size());
			Assert.areEqual(1, stepsByTypes.get('Role').size());
			Assert.areEqual(1, roleIds.size());
			Assert.isTrue(roleIds.contains(testRoleId));
		}
	}

	@IsTest
	static void testApprovalProcessTemplateGetActions() {
		System.runAs(new User(Id = UserInfo.getUserId())) {
			ApprovalProcessTemplate template = new ApprovalProcessTemplate();

			ApprovalProcessTemplateAction action1 = new ApprovalProcessTemplateAction();
			ApprovalProcessTemplateAction action2 = new ApprovalProcessTemplateAction();

			action1.setOrder(1);
			action1.setType('Update');
			action1.setActionJSON('{"Description":"Approved"}');
			action1.setIsApprovedAction(true);

			action2.setOrder(1);
			action2.setType('Update');
			action2.setActionJSON('{"Description":"Rejected"}');
			action2.setIsApprovedAction(false);

			Test.startTest();

			template.addAction(action1);
			template.addAction(action2);

			List<ApprovalProcessTemplateAction> actions = template.getActions();

			Test.stopTest();

			Assert.areEqual(2, actions.size());
		}
	}
}
