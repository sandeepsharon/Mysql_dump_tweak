#!/bin/bash
if [ $# -eq 2 ]
then
echo "Welcome to MYSQL DUMP TWEAK"
a=`cat $2 | grep -i "create definer" | cut -d" " -f2 | cut -b 10- | rev | cut -b 6- | rev | head -1`
echo "DEFINER CHANGED to $1"
echo "Adding DETERMINISTIC to routines"
echo "Please Wait...."
sed -i "s/CREATE DEFINER=\`$a\`@\`\%\`/CREATE DEFINER=\`$1\`@\`\%\`/g" $2
sed -i "/CREATE DEFINER=\`$1\`@\`\%\` FUNCTION/,/BEGIN/ {s/DETERMINISTIC//gI}" $2
sed -i "/CREATE DEFINER=\`$1\`@\`\%\` PROCEDURE/,/BEGIN/ {s/DETERMINISTIC//gI}" $2
sed -i "/CREATE DEFINER=\`$1\`@\`\%\` FUNCTION/,/BEGIN/ {s/BEGIN/DETERMINISTIC BEGIN/gI}" $2
sed -i "/CREATE DEFINER=\`$1\`@\`\%\` PROCEDURE/,/BEGIN/ {s/BEGIN/DETERMINISTIC BEGIN/gI}" $2
echo "FINISHED"
else 
echo "Provide the DEFINER and then the file path"
fi
