// 3. Write a C# Sharp program to check the largest number among three given integers.
 
// Sample Input:
// 1,2,3
// 1,3,2
// 1,1,1
// 1,2,2
// Expected Output:
// 3
// 3
// 1
// 2

using system;

public class question3
    {
        public static void main()
        {
            int a, b, c;
            Console.Write("enter first number:");
            a = Convert.ToInt32(Console.ReadLine());
            Console.Write("enter second number:");
            b = Convert.ToInt32(Console.ReadLine());
            Console.Write("enter third number:");
            c = Convert.ToInt32(Console.ReadLine());

            if (a>b)
            {
                if (a>c)
                {
                    Console.Write("The first number is greatest among three. \n\n");
                }
                else
                {
                    Console.Write("the third number is greatest among three. \n\n");
                }
            }
            else if (b>c)
            {
                Console.Write("The second number is greatest among all. \n\n");
            }
            else
            {
                Console.Write("the third number is greatest among all. \n\n");
            }
        }
    }
