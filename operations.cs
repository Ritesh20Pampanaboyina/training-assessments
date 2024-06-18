using System;
public class question3
{
    public static void Main()
{
    int x,y;
    char operation;
    Console.Write("enter first number:");
    x = Convert.ToInt32(Console.ReadLine());
    Console.Write("input operation:");
    operation = Convert.ToChar(Console.ReadLine());
    Console.Write("enter second number:");
    y = Convert.ToInt32(Console.ReadLine());
    if(operation == '+')
    Console.Writeline("{0}+{1}={2}",x,y,x+y);
    else if (operation == '-')
    Console.Writeline("{0}-{1}={2}",x,y,x-y);
    else if(operation == '*')
    Console.Writeline("{0}*{1}={2}",x,y,x*y);
    else if(operation == '/')
    Console.Writeline("{0}/{1}={2}",x,y,x/y);
    else
    Console.Writeline("wrong");
}
}