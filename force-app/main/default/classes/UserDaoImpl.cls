public inherited sharing class UserDaoImpl implements UserDao {
	public Map<Id, List<Id>> getUserIdsByRoleIds(Set<Id> roleIds) {
		Map<Id, List<Id>> userIdsByRoleIds = new Map<Id, List<Id>>();

		List<User> users = [
			SELECT Id, UserRoleId
			FROM User
			WHERE UserRoleId IN :roleIds
		];

		for (User user : users) {
			if (userIdsByRoleIds.containsKey(user.UserRoleId)) {
				userIdsByRoleIds.get(user.UserRoleId).add(user.Id);
			} else {
				userIdsByRoleIds.put(user.UserRoleId, new List<Id>{ user.Id });
			}

			return userIdsByRoleIds;
		}

        return userIdsByRoleIds;
	}
}
