using System;
public class question
{
    public static void Main()
{
    int x,y,temp;
    Console.Write("enter first number:");
    x = int.Parse(Console.ReadLine());
    Console.Write("enter the second number:");
    y = int.Parse(Console.ReadLine());
    temp=x;
    x=y;
    y=temp;
    Console.Write("After swapping:");
    Console.Write("first number:"+x);
    Console.Write("second number:"+y);
    Console.Read();
}
}
