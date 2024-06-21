<<<<<<< HEAD
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
=======
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
>>>>>>> 45d8cdfa2b60f0951d15b04d8745574bc46cfc8c
}