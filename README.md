# le.cho-arduino-clion
Set of Cmake scripts which let you use CLion as an external editor for arduino sketches.

Created and tested on Windows 7 + ARDUINO 1.6.10<br/>
No warranty it will work on other OSes(yet) or with older versions of Arduino IDE.

## HOWTO:
1. Create a project using default Arduino IDE
2. In Arduino IDE select board/variation/upload method you want to use
3. Copy content of this repo into the root of newly created project
4. Open project in CLion
5. In *CMakeLists.txt* set **ARDUINO_HOME** to the root of your Arduino installation<br/>
   (On Windows replace all '\' in path with '\\\' or '/')
6. In *CMakeLists.txt* set **ARDUINO_CPU** to one of the [CPU definitions](https://github.com/olegrak/le.cho-arduino-clion/wiki/CPU-definitions) or keep as is in case you're not sure what to put there
7. Reload Cmake project
8. Put *#include &lt;Arduino.h&gt;* at the begining of your .ino sketch then **save** the file

At this point you're done. I usually also remove 'BuildAll' and 'DUMMY' run configurations since they're useless.</br>
You're interested in the next two run configurations:<br/>
&emsp;&emsp;**VERIFY_PROJECT**  - Compile<br/>
&emsp;&emsp;**UPLOAD_TO_BOARD** - Compile & upload to board using current Arduino IDE settings<br/>
  
Please use **'BUILD'(CTRL+F9)** option with the configurations above, but not 'Run' or 'Debug'.

Enjoy :)
