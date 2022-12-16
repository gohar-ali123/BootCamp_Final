using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Q1
{
    class Program
    {
        enum Months
        {
            January=1,
            February,
            March,   
            April,
            May,
            june,
            july,
            August,
            September,
            Octuber, 
            November,
            December 
        }

        static void Main(string[] args)
        {
            Console.Write("Enter day: ");
            int day = Convert.ToInt32(Console.ReadLine());  //gets day as input from user

            Console.Write("Enter month name: ");
            string monthName = Console.ReadLine();  //gets month name as input from the user

            Console.Write("Enter year: ");
            int year = Convert.ToInt32(Console.ReadLine()); //gets year as input from user


            int month = (int) Enum.Parse(typeof(Months), monthName); //converts month name to Months enum and assigns its value to variable month

            Console.WriteLine("\nDate: " + month + "-" + day + "-" + year);   //Displays date in required format
        }
    }
}
