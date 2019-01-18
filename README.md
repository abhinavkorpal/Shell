# ShellScript
A shell script is a computer program designed to be run by the Unix shell, a command-line interpreter. The various dialects of shell scripts are considered to be scripting languages. Typical operations performed by shell scripts include file manipulation, program execution, and printing text. A script which sets up the environment, runs the program, and does any necessary cleanup, logging, etc. is called a wrapper.

The term is also used more generally to mean the automated mode of running an operating system shell; in specific operating systems they are called other things such as batch files (MSDos-Win95 stream, OS/2), command procedures (VMS), and shell scripts (Windows NT stream and third-party derivatives like 4NT—article is at cmd.exe), and mainframe operating systems are associated with a number of terms.

The typical Unix/Linux/Posix-compliant installation includes the Korn Shell (ksh) in several possible versions such as ksh88, Korn Shell '93 and others. The oldest shell still in common use is the Bourne shell (sh); Unix systems invariably also include the C Shell (csh), Bourne Again Shell (bash), a remote shell (rsh), a secure shell for SSL telnet connections (ssh), and a shell which is a main component of the Tcl/Tk installation usually called tclsh; wish is a GUI-based Tcl/Tk shell. The C and Tcl shells have syntax quite similar to that of said programming languages, and the Korn shells and Bash are developments of the Bourne shell, which is based on the ALGOL language with elements of a number of others added as well. On the other hand, the various shells plus tools like awk, sed, grep, and BASIC, Lisp, C and so forth contributed to the Perl programming language.

Other shells available on a machine or available for download and/or purchase include ash, msh, ysh, zsh (a particularly common enhanced Korn Shell), the Tenex C Shell (tcsh), a Perl-like shell (psh) and others. Related programs such as shells based on Python, Ruby, C, Java, Perl, Pascal, Rexx &c in various forms are also widely available. Another somewhat common shell is osh, whose manual page states it "is an enhanced, backward-compatible port of the standard command interpreter from Sixth Edition UNIX."

Windows-Unix interoperability software such as the MKS Toolkit, Cygwin, UWIN, Interix and others make the above shells and Unix programming available on Windows systems, providing functionality all the way down to signals and other inter-process communication, system calls and APIs. The Hamilton C Shell is a Windows shell that is very similar to the Unix C Shell. Microsoft distributes Windows Services for UNIX for use with its NT-based operating systems in particular, which have a Posix environmental subsystem.

7. Loops for, while and until

In this section you'll find for, while and until loops.

The for loop is a little bit different from other programming languages. Basically, it let's you iterate over a series of 'words' within a string.

The while executes a piece of code if the control expression is true, and only stops when it is false (or a explicit break is found within the executed code.

The until loop is almost equal to the while loop, except that the code is executed while the control expression evaluates to false.

If you suspect that while and until are very similar you are right.

7.1 For sample
```shell
         #!/bin/bash
        for i in $( ls ); do
            echo item: $i
        done
```
```shell
output:
         item: README.md
```
On the second line, we declare i to be the variable that will take the different values contained in $( ls ).

The third line could be longer if needed, or there could be more lines before the done (4).

'done' (4) indicates that the code that used the value of $i has finished and $i can take a new value.

This script has very little sense, but a more useful way to use the for loop would be to use it to match only certain files on the previous example

7.2 C-like for
fiesh suggested adding this form of looping. It's a for loop more similar to C/perl... for.
```shell
         #!/bin/bash
        for i in `seq 1 10`;
        do
                echo $i
        done    
 ```
 ```shell
 output:
         1
         2
         3
         4
         5
         6
         7
         8
         9
         10
```
7.3 While sample
```shell
          #!/bin/bash 
         COUNTER=0
         while [  $COUNTER -lt 10 ]; do
             echo The counter is $COUNTER
             let COUNTER=COUNTER+1 
         done
```
```shell
output:
         The counter is 0
         The counter is 1
         The counter is 2
         The counter is 3
         The counter is 4
         The counter is 5
         The counter is 6
         The counter is 7
         The counter is 8
         The counter is 9
```
This script 'emulates' the well known (C, Pascal, perl, etc) 'for' structure

7.4 Until sample
```shell
          #!/bin/bash 
         COUNTER=20
         until [  $COUNTER -lt 10 ]; do
             echo COUNTER $COUNTER
             let COUNTER-=1
         done
```

8. Functions

As in almost any programming language, you can use functions to group pieces of code in a more logical way or practice the divine art of recursion.

Declaring a function is just a matter of writing function my_func { my_code }.

Calling a function is just like calling another program, you just write its name.

8.1 Functions sample
```shell
            #!/bin/bash 
           function quit {
               exit
           }
           function hello {
               echo Hello!
           }
           hello
           quit
           echo foo 
```    
Lines 2-4 contain the 'quit' function. Lines 5-7 contain the 'hello' function If you are not absolutely sure about what this script does, please try it!.

Notice that a functions don't need to be declared in any specific order.

When running the script you'll notice that first: the function 'hello' is called, second the 'quit' function, and the program never reaches line 10.

8.2 Functions with parameters sample
```shell
                 #!/bin/bash 
                function quit {
                   exit
                }  
                function e {
                    echo $1 
                }  
                e Hello
                e World
                quit
                echo foo 
```
           
This script is almost identically to the previous one. The main difference is the funcion 'e'. This function, prints the first argument it receives. Arguments, within funtions, are treated in the same manner as arguments given to the script.

9. User interfaces

9.1 Using select to make simple menus
```shell
            #!/bin/bash
           OPTIONS="Hello Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "Hello" ]; then
                echo Hello World
               else
                clear
                echo bad option
               fi
           done
 ```
If you run this script you'll see that it is a programmer's dream for text based menus. You'll probably notice that it's very similar to the 'for' construction, only rather than looping for each 'word' in $OPTIONS, it prompts the user.

9.2 Using the command line
```shell
           #!/bin/bash        
          if [ -z "$1" ]; then 
              echo usage: $0 directory
              exit
          fi
          SRCD=$1
          TGTD="/var/backups/"
          OF=home-$(date +%Y%m%d).tgz
          tar -cZf $TGTD$OF $SRCD
```  
What this script does should be clear to you. The expression in the first conditional tests if the program has received an argument ($1) and quits if it didn't, showing the user a little usage message. The rest of the script should be clear at this point.

10. Misc
10.1 Reading user input with read
In many ocations you may want to prompt the user for some input, and there are several ways to achive this. This is one of those ways. As a variant, you can get multiple values with read, this example may clarify this.
```shell
#!/bin/bash
echo Please, enter your name
read NAME 
echo "Hi $NAME!"

echo Please, enter your firstname and lastname
read FN LN 
echo "Hi $FN $LN"
```

```shell
output:
         Please, enter your name
         abhinav
         Hi abhinav!
         Please, enter your firstname and lastname
         abhinav korpal
         Hi abhinav korpal
```
10.4 Getting the return value of a program
In bash, the return value of a program is stored in a special variable called $?.

This illustrates how to capture the return value of a program, I assume that the directory dada does not exist. (This was also suggested by mike)
```shell
         #!/bin/bash
        cd /dada &> /dev/null
        echo rv: $?
        cd $(pwd) &> /dev/null
        echo rv: $?
```
```shell
output:
         rv: 1
         rv: 0
```
10.5 Capturing a commands output
This little scripts show all tables from all databases (assuming you got MySQL installed). Also, consider changing the 'mysql' command to use a valid username and password.

         #!/bin/bash
        DBS=`mysql -uroot  -e"show databases"`
        for b in $DBS ;
        do
                mysql -uroot -e"show tables from $b"
        done
