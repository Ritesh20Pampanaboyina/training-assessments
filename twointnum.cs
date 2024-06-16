using System;
public class question1
{
    public static void Main()
{
    int x, y;
    Console.Write("\n\n");
    Console.Write("check whether two integers are equal or not");
    Console.Write("\n\n");
    Console.Write("enter first number:");
    x = Convert.ToInt32(Console.ReadLine());
    Console.Write("enter the second number:");
    y = Convert.ToInt32(Console.ReadLine());
    if(x == y)
    Console.Writeline("{0} and {1} are equal.\n",x,y);
    else
    Console.WriteLine("{0} and {1} are not equal.\n",x,y);
}
}