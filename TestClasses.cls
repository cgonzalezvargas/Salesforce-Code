/*
* Testing Salesforce Code: notation @isTest on class and methods
* Salesforce Records that are created in test methods are not committed to the database
* Whenever the tests are done the changes are rolled back, and there's no need to clean up data
*/

//Code coverage for 75% of the code is needed to push to production

//Each org can save up to 6MB of Apex code, ***test code isnt counted toward this limit

//To access org data within the org (pre-existing) annotate @isTest(SeeAllData=true)

//SOSL searches made within tests return empty, use Test.setFixedSearchResults()

//Example of testing code

////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
///////////////////////////////////           CLASS TEST       \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


public class TemperatureConverter 
{
    // Takes a Fahrenheit temperature and returns the Celsius equivalent.
    public static Decimal FahrenheitToCelsius(Decimal fh) {
        Decimal cs = (fh - 32) * 5/9;
        return cs.setScale(2);
    }
}

//Test suite for this class

@isTest
private class TemperatureConverterTest 
{
    @isTest static void testWarmTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius);
    }
    @isTest static void testFreezingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(32);
        System.assertEquals(0,celsius);
    }
    @isTest static void testBoilingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);        
        System.assertEquals(100,celsius,'Boiling point temperature is not expected.');
    } 
    @isTest static void testNegativeTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,celsius);
    }
}

//Another class example

public class TaskUtil 
{
    public static String getTaskPriority(String leadState) {
        // Validate input
        if (String.isBlank(leadState) || leadState.length() > 2) {
            return null;
        }
        String taskPriority;
        if (leadState == 'CA') {
             taskPriority = 'High'; 
        } else {
             taskPriority = 'Normal';
        }
        return taskPriority;
    }
}
//Test class for the code above
@isTest
private class TaskUtilTest {
    @isTest static void testTaskPriority() {
        String pri = TaskUtil.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
    @isTest static void testTaskHighPriority() {
        String pri = TaskUtil.getTaskPriority('CA');
        System.assertEquals('High', pri);
    }
    @isTest static void testTaskPriorityInvalid() {
        String pri = TaskUtil.getTaskPriority('Montana');
        System.assertEquals(null, pri);
    }
}

//Create and install a simple Apex class to test if a date is within proper range


public class VerifyDate 
{
	
	//method to handle potential checks against two dates
	public static Date CheckDates(Date date1, Date date2) 
    {
		//if date2 is within the next 30 days of date1, use date2.  Otherwise use the end of the month
		if(DateWithin30Days(date1,date2)) {
			return date2;
		} else {
			return SetEndOfMonthDate(date1);
		}
	}
	
	//method to check if date2 is within the next 30 days of date1
	private static Boolean DateWithin30Days(Date date1, Date date2) 
    {
		//check for date2 being in the past
        	if( date2 < date1) { return false; }
        
        	//check that date2 is within (>=) 30 days of date1
        	Date date30Days = date1.addDays(30); //create a date 30 days away from date1
		if( date2 >= date30Days ) { return false; }
		else { return true; }
	}

	//method to return the end of the month of a given date
	private static Date SetEndOfMonthDate(Date date1) 
    {
		Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
		return lastDay;
	}

}

@isTest(SeeAllData=false)
private class TestVerifyDate 
{
    @isTest static void testVerifyDateWithin30()
    {
        Date date1 = Date.newInstance(2001,3,21);
        Date date2 = Date.newInstance(2001,3,27);
        Date verifyDate = Date.newInstance(2001,3,27);
        Date inputDate = VerifyDate.CheckDates(date1,date2);
            System.assertEquals(verifyDate,inputDate);
    } 
    @isTest static void testVerifyDateAbove30()
    {
        Date date1 = Date.newInstance(2001,3,21);
        Date date2 = Date.newInstance(2001,4,22);
        Date verifyDate = Date.newInstance(2001,3,31);
        Date inputDate = VerifyDate.CheckDates(date1,date2);
            System.assertEquals(verifyDate,inputDate);
    } 
    @isTest static void testVerifyDateBelow30()
    {
        Date date1 = Date.newInstance(2001,3,21);
        Date date2 = Date.newInstance(2001,2,22);
        Date verifyDate = Date.newInstance(2001,3,31);
        Date inputDate = VerifyDate.CheckDates(date1,date2);
            System.assertEquals(verifyDate,inputDate);
    }
    

}

@isTest
private class TestVerifyDate {
    @isTest static void testCheckDates() 
    {
        
        Date test_date1 = VerifyDate.CheckDates(Date.newInstance(2022, 9, 5), System.today());
        Date test_date2 = VerifyDate.CheckDates(Date.newInstance(2022, 9, 14), System.today() + 100);
        Date test_date3 = VerifyDate.CheckDates(System.today(), System.today()-1);
    }
}