@IsTest
class UserDaoTest {
	@TestSetup
	static void setup() {
        Profile standardUserProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

		UserRole testRole = new UserRole(Name = 'Test Role');

		insert testRole;

		User testUser = new User();

		testUser.Username = 'testuser@testuserdaotest.com';
        testUser.Email = 'testuser@testuserdaotest.com';
        testUser.Alias = 'testu';
        testUser.TimeZoneSidKey = 'GMT';
        testUser.LocaleSidKey = 'en_US';
        testUser.EmailEncodingKey = 'ISO-8859-1';
        testUser.ProfileId = standardUserProfile.Id;
        testUser.LanguageLocaleKey = 'en_US';
		testUser.LastName = 'TestUser';
		testUser.UserRoleId = testRole.Id;

		insert testUser;
	}

	@IsTest
	static void testGetUserIdsByRoleIds() {
		System.runAs(new User(Id = UserInfo.getUserId())) {
			UserDao userDao = new UserDaoImpl();

            Set<Id> roleIds = new Map<Id, UserRole> ([SELECT Id FROM UserRole WHERE Name = 'Test Role']).keySet();

            Test.startTest();

            Map<Id, List<Id>> userIdsByRoleIds = userDao.getUserIdsByRoleIds(roleIds);

            Test.stopTest();

            Assert.areEqual(1, userIdsByRoleIds.size());
		}
	}
}
