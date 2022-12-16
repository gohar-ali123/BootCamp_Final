using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Q2
{
    class Program
    {
        enum Months
        {
            January,
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

            foreach( string monthName in Enum.GetNames(typeof(Months))) //loops through enums, converts them to strings and assigns them to variable "monthName"
            {
                Console.WriteLine("\n\nMonth name: " + monthName);  //displays nas=me of current enum month
                Console.WriteLine("Number of characters: " + monthName.Length); //displays number of characters in current enum month
            }

        }

    }
}
