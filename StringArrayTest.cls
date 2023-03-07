public class StringArrayTest 
{
    public static List<String> generateStringArray(Integer N)
    {
        Integer count = 0;
        List<String> listOfStrings = new List<String>();
        while(count < N)
        {
            String test = 'Test ' + count;
            listOfStrings.add(test);
            count++;
        }
        for(Integer i = 0; i<listOfStrings.size();i++)
        {
            System.debug(listOfStrings[i]);
        }
        return listOfStrings;
    }

}