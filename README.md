# Design and Development Challenge – Bowling Score
This script will accept a string of bowling scores and calculate the final total. 

## Dependencies
*   BASH 4 is required for some string parsing.

## Limitations
*   Does not validate input
*   Does not limit number of turns or frames

## Usage
No installation is required for this script; instead, simply put it in place and invoke it directly. A string that is between 12 and 22 characters and which represents a bowling score may optionally be provided as an argument. If this is not provided, the script will prompt you for the score.

The script will interpret the following from the provided string:
*   An "X" represents a strike. It will add 10 plus the next two rolls to the total score.
*   A "/" represents a spare. Paired with the preceding roll, it will add 10 plus the next roll to the total score.
*   A "-" represents a miss. It adds nothing to the total score.
*   Any number represents that number of pins knocked over. It will be added to the total score unless superceded by anything described above.

Example uses of the script are as follows:
*   Calculating a score with all strikes:
```
$ ./splits-happen.sh XXXXXXXXXXXX
Your final score was 300.
```
*   Calculating a score with mixed rolls:
```
$ ./splits-happen.sh X7/9-X-88/-6XXX81
Your final score was 167.
```
*   Providing the score in the script (in this case, alternating 5s and spares):
```
$ ./splits-happen.sh 
What was your score?
An "X" will be interpreted as a strike, a "/" as a spare, and a "-" as a miss. Numbers are pins knocked down.
Please enter your scores: 5/5/5/5/5/5/5/5/5/5/5
Your final score was 150.
```
