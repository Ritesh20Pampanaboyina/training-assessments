// 4.  Write a C# Sharp program that prints the multiplication table of a number as input.
// Test Data:
// Enter the number: 5
// Expected Output:
// 5 * 0 = 0
// 5 * 1 = 5
// 5 * 2 = 10
// 5 * 3 = 15
// ....
// 5 * 10 = 50

// like 1
// has context menu

using system;

public class question4
{
    public static void main()
    {
        int x;
        int result;

        Console.WriteLine("Enter the number:");
        x = Convert.ToInt32(Console.ReadLine());
        

        result = x *  1;
        Console.WriteLine("the table is: {0} * {1} = {2}", x, 1,result);

        result = x * 2;
        Console.WriteLine("            : {0} * {1} = {2}", x, 2, result);

        result = x * 3;
        Console.WriteLine("            : {0} * {1} = {2}", x, 3, result);

        result = x * 4;
        Console.WriteLine("            : {0} * {1} = {2}", x, 4, result);

        result = x * 5;
        Console.WriteLine("            : {0} * {1} = {2}", x, 5, result);

        result = x * 6;
        Console.WriteLine("            : {0} * {1} = {2}", x, 6, result);

        result = x * 7;
        Console.WriteLine("            : {0} * {1} = {2}", x, 7, result);

        result = x * 8;
        Console.WriteLine("            : {0} * {1} = {2}", x, 8, result);

        result = x * 9;
        Console.WriteLine("            : {0} * {1} = {2}", x, 9, result);

        result = x * 10;
        Console.WriteLine("            : {0} * {1} = {2}", x, 10, result);

    }
}