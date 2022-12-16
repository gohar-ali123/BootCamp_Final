using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Q5
{
    class Program
    {
        enum Operators
        {
            add,
            subtract,
            multiply,
            divide
        }

        static double Calc(double num1, Operators operation, double num2)    //Calculates and returns answer based on the enum operator given as argument
        {
            double answer = 0;

            switch (operation)  //Slects the operation based on the given enum operator argument
            {
                case Operators.add:
                    answer = num1 + num2;
                    break;
                case Operators.subtract:
                    answer = num1 - num2;
                    break;
                case Operators.multiply:
                    answer = num1 * num2;
                    break;
                case Operators.divide:
                    answer = num1 / num2;
                    break;
            }

            return Math.Round(answer, 3);
        }

        static void Main(string[] args)
        {
            Console.WriteLine("Enter value 1: ");
            double num1 = Convert.ToInt32(Console.ReadLine()); //Takes input for value 1 

            Console.WriteLine("\nEnter Operator: ");
            string inputOp = Console.ReadLine();    //Takes operator symbol input as string

            Console.WriteLine("\nEnter value 2: ");
            double num2 = Convert.ToInt32(Console.ReadLine()); ////Takes input for value 2

            //Operators symbol = Operators.add;
            Operators operation = Operators.add;   //Declares the enum operators type variable with name "operation" and assigns initial value of Add.

            switch (inputOp)    //Selects and assigns the enum operator, based on input operator symbol
            {
                case "+":
                    operation = Operators.add;
                    break;
                case "-":
                    operation = Operators.subtract;
                    break;
                case "*":
                    operation = Operators.multiply;
                    break;
                case "/":
                    operation = Operators.divide;
                    break;

            }

            Console.WriteLine("\nAnswer is: " + Calc(num1, operation, num2));      //Calls the Calc() method and displays the answer
        }

    }
}
