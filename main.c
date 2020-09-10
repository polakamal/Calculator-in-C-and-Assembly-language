#include <stdio.h>
#include <stdlib.h>


//A function which takes an array and its length and loop over its elements to add their values then return the result.
int add(int array[],int len)
{
    int result =0;
    int i;
    for(i=0;i<len;i++)
    {
        result +=array[i];
    }
    return result;
}


//A function which takes an array and its length and loop over its elements
//to subtract their values from first element in array then return the result.
int subtract(int array[],int len )
{
    int result =array[0];
    int i;
    for(i=1;i<len;i++)
    {
        result -=array[i];
    }
    return result;
}

//A function which takes an array and its length and loop over its elements to multiply their values then return the result.
int multiply(int array [], int len)
{
    int result = 1;
    int i;
    for(i=0;i<len;i++)
    {
        result *=array[i];
    }
    return result;
}




//A function which takes two integers and divide the first over the second one.

int division(int num1, int num2)
{
    int result = num1;
        result /=num2;
    return result;
}




//A function which takes two integers and set the first up to the power to the second.
int power(int num,int pow)
{
    int result =num;
     if(pow<0)
    {
       result =0;
    }
    else if (pow ==0)
    {
        result =1;
    }
    else {
    pow--;
        while (pow!=0)
        {
            result *=num;
            pow--;
        }}
    return result;
}



//A function which takes a number and gets its factor by looping then return the result.
int factorial(int num)
{
    int result=1;
    while(num!=0)
    {
        result *= num;
        num--;
    }
    return result;
}


//A function which takes set of numbers to loop over them and compares to set their maximum then return it.
int maximum(int array [], int len)
{
    int result = array[0];

    int i;
    for(i=1;i<len;i++)
    {
        if(array[i]>result)
            result=array[i];
    }
    return result;
}


//A function which takes set of numbers to loop over them and compares to set their minimum then return it.
int minimum(int array [], int len)
{
    int result = array[0];
    int i;
    for(i=1;i<len;i++)
    {
        if(array[i]<result)
            result=array[i];
    }
    return result;
}


int main()
{     int ap=1;                  //Exit(make another operations) control variable.
      int st_result=0;
      char *name="null";        //Operation's name stored.
      int result;
      int R=0;
      int len=2;
      int array[1000];
      int j=0;
      printf("Welcome to basic calculator.\n\n\n");

      while(ap!=0)
         {

            int op;             //Operation indicator.
            printf("Please enter the number of the operation you desire:\n1-Addition\n2-Subtraction\n3-Multiplication\n4-Division\n5-Power\n6-Factorization\n7-Maximum\n8-Minimum\n9-Show previous operations\n");
            scanf("%d",&op);
            while (op>9||op<1)  //A loop to keep the program operation after finishing one operation and continuing to other operations needed.
                {
                    printf("Please enter a valid number (between 1 and 9)\n");
                    scanf("%d",&op);
                }

            // scanning for one integer for factorial operation .
            if(op==6)
                {
                    if(R==1)
                    {

                    }
                    else
                    {
                    printf("Please enter input value\n");
                    scanf("%d",&array[0]);
                    while(array[0]<=0)
                        {
                            printf("please enter a number greater than zero..\n");

                            scanf("%d",&array[0]);
                        }
                    }
                }
            // scanning for two integer for division and power operations .
            else if(op==4||op==5)
                {
                    printf("Please enter the next input values\n");
                    int i;
                    array[1]=1;
                    for(i=j;i<2;i++)
                        {
                            scanf("%d",&array[i]);
                            if(array[1]==0)
                            {
                                printf("please enter valid number\n");
                                i--;
                            }
                        }
                }
           //printing the previous operation.
            else if(op==9)
                {
                    printf(" the last operation is :%s\t",name);
                    printf(" the last result is :%d\n",st_result);

                }
          // scanning for the other operations
            else
                {
                    printf("Please enter the number of input values\n");
                    scanf("%d",&len);
                    int i;
                    printf("Please enter input values\n");
                    for(i=j;i<len;i++)
                        {
                            scanf("%d",&array[i]);
                        }
                }
        //Operation selection.
            if(op==1)
            {
                result=add(array,len);
                name="addition";
            }
           else if(op==2)
            {
                result=subtract(array,len);
                name="subtract";
            }
            else if(op==3)
            {
                result=multiply(array,len);
                 name="multiply";
            }
             else if(op==4)
            {
                result=division(array[0],array[1]);
                  name="division";
            }
             else if(op==5)
            {
                result=power(array[0],array[1]);
                   name="power";
            }
             else if(op==6)
            {
                result=factorial(array[0]);
                     name="factorial";
            }
             else if(op==7)
            {
                result=maximum(array,len);
                  name="maximum";
            }
             else if(op==8)
            {
                result=minimum(array,len);
                     name="minimum";
            }

        // store previous result .
            if(op!=9)
            {
                st_result=result;
                printf("the result is    %d\n" ,result);
            }

            printf("Enter 0 to exit or Enter any other number to continue... \n");
            scanf("%d",&ap);

            if(ap!=0)
            {
               printf("if you want to use the previous result in another operation enter 1...\n ");
               scanf("%d",&R);
               if(R==1)
               {
                 j=1;
                 array[0]=st_result;
               }
               else
                 j=0;

            }
    }


    return 0;
}
