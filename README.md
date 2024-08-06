# Physical Design_2024
## GCC Compilation of C program
Shown below are a series of steps to compile a C program using GCC.
### Step 1
Open the terminal. Make sure you're in the home directory. Open any editor and type a new file "file_name.c" to type the C program. Here the gedit editor is used.<br/>
i. **CODE SNIPPET:**
```c
#include <studio.h>
void main()
{
int i, n=10,sum=0;
for(i=1;i<=n;i++)
sum=sum+1;
printf("Sum from 1 to %d is %d \n",n,sum);
}
```
### Step 2
Save the program. Compile the code using GCC compiler by using the command below.
```
gcc file_name.c
```
### OUTPUT
The output can be observed by opening the .out(output file). By default, the compiler creates the file by the name "a.out" in the same directory.<br/>
It can be changed by using the following command.
```
gcc -o file_name.out file_name.c
```
The image of the C code along with outputs is shown below.<br/>
The output is shown for n being 10,100 and 1000 respectively and the result is stored in "result.out" file.
![c compilation](https://github.com/user-attachments/assets/8a88c9dd-7aa0-4d72-b7a2-01044d654dad)

