using System;

public class question4
{
    public static void Main(string[] args)
    {
        int x;
        int result;

        Console.WriteLine("Enter the number:");
        x = Convert.ToInt32(Console.ReadLine());

        Console.WriteLine("Multiplication table for {0}:", x);
        Console.WriteLine("-----------------------------");

        for (int i = 1; i <= 10; i++)
        {
            result = x * i;
            Console.WriteLine("{0} * {1} = {2}", x, i, result);
        }
    }
}
