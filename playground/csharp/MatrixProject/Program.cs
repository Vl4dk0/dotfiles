namespace MatrixProject;

class Program
{
    static void Main(string[] args)
    {
        try
        {
            var matrixA = new Matrix(new double[,] { { 1, 2, 3 }, { 4, 5, 6 } });
            var matrixB = new Matrix(new double[,] { { 7, 8 }, { 9, 10 }, { 11, 12 } });

            Console.WriteLine("Matrix A:");
            Console.WriteLine(matrixA);
            Console.WriteLine();
            Console.WriteLine("Matrix B:");
            Console.WriteLine(matrixB);
            Console.WriteLine();

            // Matrix multiplication
            Console.WriteLine("Matrix A * Matrix B:");
            var resultMul = matrixA * matrixB;
            Console.WriteLine(resultMul);
            Console.WriteLine();

            // Scalar addition
            Console.WriteLine("Matrix A + 10:");
            var resultAddScalar = matrixA + 10;
            Console.WriteLine(resultAddScalar);
            Console.WriteLine();

            // Matrix addition with a symmetrical matrix
            var matrixC = new Matrix(new double[,] { { 10, 20, 30 }, { 40, 50, 60 } });
            Console.WriteLine("Matrix A + Matrix C:");
            var resultAddMatrix = matrixA + matrixC;
            Console.WriteLine(resultAddMatrix);
            Console.WriteLine();

            // Demonstrating dimension mismatch error for addition
            Console.WriteLine("Trying to add Matrix A + Matrix B (this should fail)...");
            try
            {
                var fail = matrixA + matrixB;
            }
            catch (ArgumentException e)
            {
                Console.WriteLine($"  Error caught: {e.Message}");
            }
        }
        catch (Exception e)
        {
            Console.WriteLine($"An unexpected error occurred: {e.Message}");
        }
    }
}

