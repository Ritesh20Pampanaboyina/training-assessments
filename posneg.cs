using System;
public class question2
{
    public static void Main()
{
    int num;
    Console.Write("\n\n");
    Console.Write("check whether a number is positive or negative");
    Console.Write("\n\n");
    Console.Write("enter a number:");
    num = Convert.ToInt32(Console.ReadLine());
    if(num>=0)
    Console.Writeline("{0} is a positive number.\n",num);
    else
    Console.Writeline("{0} is a negative number.\n",num);
}
}
