using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Q3
{
    class Program
    {
        enum Items
        {   
            //The values represent the price of the items in $

            shampoo=4,
            faceWash=6,
            shoes=11,
            coat=20,
            jacket=25,
            bed=62

        }

        static void Main(string[] args)
        {
            Console.Write("Please enter the product name: ");
            string prodName = Console.ReadLine();       //Takes product name input from user as a string
            Items prod = (Items)Enum.Parse(typeof(Items), prodName);        //converts the product name from string to Items(enum) type and assigns to enum variable "prod"

            
            int prodPrice = (int) prod;     //type casts prod enum to int and stores the enum value to prodPrice
            
            Console.WriteLine("\nThe price of " + prodName + " is: $" + prodPrice);      //Displays the product price
        }

    }
}
