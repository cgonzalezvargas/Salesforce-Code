public class Tea
{
    public static void orderTea()
    {
        Set<String> teaTypes = new Set <String>();
        teaTypes.add('Black');
        teaTypes.add('White');
        teaTypes.add('Herbal');
        system.debug(teaTypes);
    }

    public static void orderTeaDupe()
    {
        Set<String> teaTypes = new Set <String>{'Black', 'White', 'Herbal'};
        system.debug(teaTypes);
        teaTypes.add('Green');
        teaTypes.add('Black');
        system.debug(teaTypes);
    }
}