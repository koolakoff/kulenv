#!/bin/bash

ENV_FILE=project_specific/${project}.env
BASH_FILE=project_specific/${project}.bash

if [ -f $BASH_FILE ]
then
    cp $BASH_FILE ~/.bash.${project}
else
    echo "  Error! Cannot install project-specific config. Project $project unrecognized"
fi


test -f ~/.bash.env || echo '#!/bin/bash' >  ~/.bash.env

for var in $(grep -e "^export" ${ENV_FILE} |cut -d' ' -f2 |cut -d= -f1)
do
    str=$(grep -e "$var=" $ENV_FILE)
    if [ -z "$(grep -e $var ~/.bash.env)" ]
    then
        echo "  add to environment ${str/#export /}"
        echo $str >>  ~/.bash.env
    fi
done
