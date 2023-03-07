/*
* Working with Maps
*/

public class Tea
{
    public static void orderTea()
    {
        Map <String, String> teaTypes = new Map <String, String>();
        teaTypes.put('Black', 'Earthly');
        teaTypes.put('White', 'Sweet');
        teaTypes.put('Herbal', 'Sweet');
        system.debug(teaTypes);

        String flavorProfile = teaTypes.get('Herbal');
        System.debug('The flavorProfile of Herbal is: ' + flavorProfile);
        return flavorProfile;
    }
}