public interface UserDao {
	Map<Id, List<Id>> getUserIdsByRoleIds(Set<Id> roleIds);
}
