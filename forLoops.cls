/*
* Iteration through lists and data types using the for loop
*/

/*
* for (data_type variable_name : list_name or set_name)
* {
*  Loop_body
* } 
*/

List<String> tea = new List<String>{'Black Tea', 'Green Tea', 'Chai Tea'};
for (String t : tea)
{
    System.debug('We  have ' + t);
}