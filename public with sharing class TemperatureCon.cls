public with sharing class TemperatureConverter {

    public TemperatureConverter()

    {

        //Takes a Fahrenheit temperature and returns the celsius equvalent

    public static Decimal FahrenheitToCelsius(Decimal fh)

    {

        Decimal cs = (fh-32)*5/9;

        return cs.setScale(2);

    }

 

    }

}

 

public with sharing class VerifyDate

{

    public VerifyDate()

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

}

 

public with sharing class AccountController

{

   public static List<Account> getAllActiveAccounts()

   {

        return [SELECT Id, Name, Active__c FROM Account WHERE Active__c = 'Yes'];

   }

}

 

public with sharing class EmailMIssionSpecialist {

    public EmailMIssionSpecialist()

    {

        public void sendMail(String address, String subject, String body)

        {

            // Create an email message object

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            String[] toAddresses = new String[] {address};

            mail.setToAddresses(toAddresses);

            mail.setSubject(subject);

            mail.setPlainTextBody(body);

            // Pass this email message to the built-in sendEmail method

            // of the Messaging class

            Messaging.SendEmailResult[] results = Messaging.sendEmail(

                                      new Messaging.SingleEmailMessage[] { mail });

            // Call a helper method to inspect the returned results

            inspectResults(results);

         }

         // Helper method

         private static Boolean inspectResults(Messaging.SendEmailResult[] results)

         {

            Boolean sendResult = true;

            // sendEmail returns an array of result objects.

            // Iterate through the list to inspect results.

            // In this class, the methods send only one email,

            // so we should have only one result.

            for (Messaging.SendEmailResult res : results)

            {

               if (res.isSuccess())

               {

                  System.debug('Email sent successfully');

               }

               else

               {

                  sendResult = false;

                  System.debug('The following errors occurred: ' + res.getErrors());                

               }

            }

            return sendResult;

         }

 

    }

}

public with sharing class RandomContactFactory

{

    public RandomContactFactory()

    {

        public static List<Contact> generateRandomContacts(integer genNum,String strlastName)

        {

        integer i = 1;

        List<Contact> conList = new List<Contact>();

        while(genNum >= i)

        {

            Contact con = new Contact(firstName='Schlomo '+i,lastName=strlastName);

            conList.add(con);

            i++;

           

        }

        return conList;

        }

        if(conList.size() >=150)

        {

            insert conList;

        }

    }

}