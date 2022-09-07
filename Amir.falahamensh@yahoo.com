- 👋 Hi, I’m @Armanneda
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...

<!---
Armanneda/Armanneda is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
using System;
using System.Collections.Generic;

namespace Part6
{
    class Program
    {
        static void Main(string[] args)
        {
            List<string> students = new List<string>();
     
            while (true)
            {
                menu();
                string select = Console.ReadLine();
                switch (select)
                {
                    case "1":
                        addStudent(students);
                        break;
                    case "2":
                        editStudent(students);

                        break;
                    case "3":
                        deleteStudent(students);
                        break;
                    case "4":
                        printStudents(students);

                        break;
                    case "5":
                        searchStudent(students);

                        break;

                    case "6":

                        return;

                    default:
                        Console.WriteLine("input invalid");
                        break;
                }
            }

        }

        static void searchStudent(List<string> students)
        {
            List<string> result = new List<string>();
            Console.Clear();
            Console.WriteLine("Enter Search");
            string search = Console.ReadLine();
            for (int i = 0; i < students.Count; i++)
            {
                string[] info = students[i].Split(',');
                if (info[1].StartsWith(search))
                {
                    result.Add(students[i]);
                }

            }

            printStudents(result);
     
        }

        static void deleteStudent(List<string> students)
        {
            Console.Clear();
            Console.WriteLine("Enter Search");
            string search = Console.ReadLine();

            int index = findIndex(students, search);
            if (index != -1)
            {

                students.RemoveAt(index);
                Console.WriteLine("Delete Operatoin Successful");

            }
            else
            {
                Console.WriteLine("Student Not Found");
            }

            Console.ReadKey();
        }

        static void editStudent(List<string> students)
        {
            Console.Clear();
            Console.WriteLine("Enter Search");
            string search = Console.ReadLine();

            int index = findIndex(students,search);
                if (index != -1)
            {
                string format = studentFormatter();
                students[index] = format;
                Console.WriteLine("Update Operatoin Successful");

            }
            else
                {
                    Console.WriteLine("Student Not Found");
                }
         
            Console.ReadKey();
        }

        static string studentFormatter()
        {
            Console.WriteLine("Enter Name");
            string name = Console.ReadLine();
            Console.WriteLine("Enter Surname");
            string surname = Console.ReadLine();
            Console.WriteLine("Enter Age");
            string age = Console.ReadLine();
            string format = $"{name},{surname},{age}";
            return format;
        }

        static void printStudents(List<string> students)
        {
            Console.Clear();
            for (int i = 0; i < students.Count; i++)
            {
                string[] info = students[i].Split(',');
                Console.WriteLine("Name      =  " + info[0]);
                Console.WriteLine("Surname   =  " + info[1]);
                Console.WriteLine("Age       =  " + info[2]);
                Console.WriteLine("***********************************");
            }
            Console.ReadKey();
        }

        static void addStudent(List<string> students)
        {
            Console.Clear();
            string format = studentFormatter();
            students.Add(format);
            Console.WriteLine("Add Operatoin Successful");
            Console.ReadKey();
        }


        static int findIndex(List<string> array,string search)
        {
            int index = -1;
            for (int i = 0; i < array.Count; i++)
            {
                string[] info = array[i].Split(',');
                if (info[1] == search)
                {
                    index = i;
                }
            }
            return index;
        }

        static void menu()
        {
            Console.Clear();
            Console.WriteLine("1)Add Student");
            Console.WriteLine("2)Edit Student");
            Console.WriteLine("3)Delete Student");
            Console.WriteLine("4)Print Students");
            Console.WriteLine("5)Search Students");
            Console.WriteLine("6)Exit");
        }
    }
}
