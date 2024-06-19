using System;

namespace CC1
{
    class Program
    {
        public static void Main()
        {
            int a, b, c;
            Console.Write("Enter first number: ");
            a = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter second number: ");
            b = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter third number: ");
            c = Convert.ToInt32(Console.ReadLine());

            if (a > b)
            {
                if (a > c)
                {
                    Console.WriteLine("The first number ({0}) is the greatest among all.", a);
                }
                else
                {
                    Console.WriteLine("The third number ({0}) is the greatest among all.", c);
                }
            }
            else if (b > c)
            {
                Console.WriteLine("The second number ({0}) is the greatest among all.", b);
            }
            else
            {
                Console.WriteLine("The third number ({0}) is the greatest among all.", c);
            }
        }
    }
}
