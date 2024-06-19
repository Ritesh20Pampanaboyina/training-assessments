using System;


namespace cc1
{
    class program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine(RemoveCharacter("python", 1));
            Console.WriteLine(RemoveCharacter("python", 0));
            Console.WriteLine(RemoveCharacter("python", 4));
            Console.ReadLine();

        }
        static string RemoveCharacter(string str, int position)
        {
            if (position < 0 || position >= str.Length)
            {
                throw new ArgumentOutOfRangeException(nameof(position));
            }
            return str.Remove(position, 1);

        }
    }
}