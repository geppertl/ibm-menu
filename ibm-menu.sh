#!/bin/bash
#
## The only purpose is to present daily lunch menu in an easy way.
##
## LG
## 13.11.2015
#
# dependency
# bash, date, curl, grep, tr, sed, awk
#
# Change log:
# 13.11.2015 big bang      ...Friday 13th
# 08.12.2015 GitHub first push
# 13.12.2015 release / first distribution
# 06.04.2016 globus deactivated
# 21.02.2017 test commit
#
#

## var definition -----------------------------------------------------------------------------------------------
DATE=`date +"%d.%m.%Y"`
DAY=( UNKNOWN PONDĚLÍ ÚTERÝ STŘEDA ČTVRTEK PÁTEK SOBOTA NEDĚLE)       # or LC_TIME='cs_CZ.utf8' date '+%A'
TODAY=${DAY[ $(date +"%u") ] }
TITLE='printf "\n- $FUNCNAME - \t\t - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n\n"'
VERSION='printf "\n <> Verze ze dne: 06/04/2016\n"'
CMD_CURL='curl -A "Mozilla/4.0" -Ls'


## sub definition -----------------------------------------------------------------------------------------------

A-Sport() {
URL="http://www.a-sporthotel.cz/menu/"

  eval $TITLE
  eval $CMD_CURL $URL \
    |grep -E '<b>|sipka' \
    |sed 's/<\/td>//g'   \
    |sed 's/<td><b>//g'  \
    |sed 's/<\/b>//g'    \
    |sed 's/<td colspan="2" class="tmain"><img src="\/img\/sipka.gif" alt="" class="sipka" \/>//g'  \
    |sed 's/^          //g' \
    |sed 's/ 17//g;s/ 137//g' \
    |sed 's/ Kč//g' \
    |grep -i -A6 $TODAY |grep -v -i $TODAY
  printf '\n'
}


Bavorska() {
  URL=""

  eval $TITLE
  printf 'Neni dodelane!\n'
  printf '\n'
}


Corrida() {
URL="http://www.lacorrida.cz/zabovresky/denni-menu"

  eval $TITLE ; printf 'Polévka: '
  eval $CMD_CURL $URL |grep field-name \
    |sed 's/">/"> /g' \
    |sed -e 's/<[^>]*>//g' \
    |grep -A5 -i $TODAY \
    |sed 's/^ *//g' \
    |sed -e 's/0,25 l  //g' \
    |sed -e 's/ [0-9]* g  //g' \
    |sed 's/  / /g' \
    |grep -v -i $TODAY
  printf '\n'
}


Eures() {
URL="http://www.eurest-brno.cz/ibm/menu"

  eval $TITLE
  eval $CMD_CURL $URL \
  |grep -A103 -i $(date +%A) |grep -E 'h3|<strong|CZK' \
  |sed -e 's/<strong>.*<\/strong>//g' |sed '/&nbsp;/d' |sed -e 's/<[^>]*>//g' \
  |sed 's/\r/ /g' | tr -d '\n' |sed 's/ CZK/\n/g' \
  |sed 's/^.*Soups/Polévky: \n/g' \
  |sed 's/Menu of the day/\nMenu:\n/g' \
  |sed 's/Special dish //g' \
  |sed 's/Maetless meal //g' \
  |sed 's/Cold dish Cold dish of the day//g' \
  |sed 's/Pizzas/Pizza/g'
  printf '\n'
}


Globus() {

  eval $TITLE
  printf 'Neni dodelane!\n'
  printf '\n'

#URL="https://www.globus.cz/brno/restaurace.html"
#
#  eval $TITLE
#  eval $CMD_CURL $URL \
#  |grep -E 'restaurant__menu-table-day|restaurant__menu-food-name|restaurant__menu-food-price' \
#  |sed -e 's/<[^>]*>//g' |grep -A18 Dnes |tr -d [:cntrl:] |tr -s [:space:] \
#  |sed 's/,–/,-\n/g; s/&nbsp;/ /g ;s/Dnes/Polévky:/g'
#  printf '\n'
}


Kanas() {
URL="http://www.kanas.cz/stranka/jidelna"

  eval $TITLE
  eval $CMD_CURL $URL |grep -E 'h3|jidlo|cena|tab_content' \
    |sed 's/<div class="tab_content" id="tab1">/Restaurace:/;s/<div class="tab_content" id="tab2">/Jídelna:/' \
    |sed -e 's/<[^>]*>//g' \
    |sed "/$TODAY/Id;/Brno/d;/doba/d;/údaje/d" \
    |sed 's/\r/ /g' | tr -d '\n' \
    |sed 's/,-/,-\n/g; s/:/:\n/g; s/Jídelna:/\nJídelna:/' \
    |sed 's/\t//g' \
    |sed 's/   //g;s/^  //g ' \
    |sed 's/Polévky/Polévka:/g;s/Menu/\n Menu:\n/g'
  printf '\n'
}


Miki() {
URL="http://mikirestaurant.cz/"

  eval $TITLE ; printf 'Polévka: '
  echo `eval $CMD_CURL $URL \
    |grep -A31 -i $TODAY \
    |grep -A2 -E 'first-col'` \
    |sed -e 's/<[^>]*>//g' |sed 's/A./\n A./g' |sed 's/,-/,- \n/g' |sed 's/ -- //g'  |sed 's/^ //g'
}


Ocean48() {
URL=""

  eval $TITLE
  printf 'Neni dodelane!\n'
  printf '\n'
}


Paladeo() {
URL="http://www.paladeo.cz/menu"

  eval $TITLE
  eval $CMD_CURL $URL |grep -E '<u>|<li>' | grep -A4 -i $TODAY |sed "/$TODAY/Id" |sed -e 's/<[^>]*>//g' \
    |sed 's/&#160;//g' |sed 's/\t */ /g' |sed 's/ Kč//g' |sed 's/^ *//g'
  printf '\n'
}


Purkynka() {
URL="http://www.napurkynce.cz/denni-menu/"

  eval $TITLE
  eval $CMD_CURL $URL \
    |grep '<pre>' |sed 's/<br \/>/\n/g' |sed -e 's/<[^>]*>//g' |sed  's/Polévka/Polévka:/g' \
    |grep -i -A4 $TODAY \
    |sed "s/$TODAY: //g"
  printf '\n'
}


Rebio() {
URL="http://rebio.cz/Rebio-Park/gn.workroom.aspx"

  eval $TITLE ; printf 'Polévka: '
  eval $CMD_CURL $URL | grep -E 'h-today-special|<span><strong>' \
    |sed -e 's/<[^>]*>//g' | sed 's/\t*//g' | grep -v Dnes
  printf '\n Basic menu 95,-\n Rebio menu 110,-\n Těstovinový salát 90,- \n\n'

  # nedokonale, ale lepsi jak nic. ...jinak pdf2txt :]
}


Rubin() {
URL="http://restauracerubin.cz/"

  eval $TITLE
  eval $CMD_CURL $URL |grep menu_  \
    |sed -e 's/<[^>]*>//g' |sed -e 's/^ *//g' |sed 's/\r/ /g' | tr -d '\n' \
    |sed 's/Menu/\nMenu/g'  |sed 's/Labužník/\nLabužník/g' \
    |sed 's/Denní menu/Denní menu\n/g' |sed 's/Týdenní menu/\n\nTýdenní menu/g' |sed 's/Vegi menu:/\n\nVegi menu\n/g' \
    |sed 's/[0-9]*g //g' |sed 's/^ *//g'\ |sed 's/menu/menu:/g'
  printf '\n \n'
}


Velorex() {
URL="http://www.restauracevelorex.cz/poledni-menu/"

  eval $TITLE
  eval $CMD_CURL $URL |grep -E 'h3|bold|cena' \
    |sed -e 's/<[^>]*>//g' |sed 's/&nbsp;Kč/,-/g' |sed 's/\t//g' | tr -d '\n'  \
    |sed 's/Hlavní chod:/\n\nDenní Menu:/g' |sed 's/Menu PLUS:/\nMenu PLUS:/g' |sed 's/Salát:/\nSalát:/g' \
    |sed 's/:/:\n/g'  |sed 's/,-/,- \n/g' |sed 's/(.*)//g' |sed 's/^\. *//g'\
    |head -n13
  printf '\n'
}


All() {
  A-Sport
  Bavorska
  Corrida
  Eures
  Globus
  Kanas
  Miki
  Ocean48
  Paladeo
  Purkynka
  Rebio
  Rubin
  Velorex
}


Update() {
URL="https://raw.github.com/geppertl/ibm-menu/master/ibm-menu.sh"

 eval $VERSION
 printf '\n Update...\n\n'
 curl -fsSL $URL > $0
 chmod +x $0
 ls -la $0
 echo
}


Help() {
  eval $VERSION

  printf '
 Usage:
 -h  | --help
 -U  | --update

 -A  | --all
 -a -k -p | --A-Sport --Kanas --Paladeo

 Places:
 -a  | --A-Sport
 -b  | --Bavorska
 -c  | --Corrida
 -e  | --Eures
 -g  | --Globus
 -k  | --Kanas
 -ko | --Kotelna
 -m  | --Miki
 -o  | --Ocean48
 -p  | --Paladeo
 -pu | --Purkynka
 -re | --Rebio
 -r  | --Rubin
 -v  | --Velorex

 - Obed, jediny svetly bod v nudne sedem dnu kazdeho IBMera -

 # ToDO - - - - - - - - - - - - - - - - - - - - - - - - - - -

 Meat selection:
 -K  | --kure
 -V  | --veprove
 -H  | --hovezi
 -R  | --ryba
 -G  | --guláš
 -S  | --search [ kure|veprove|hovezi|guláš|salat|spagety ] \n\n'
}


## main ---------------------------------------------------------------------------------------------------------
clear
printf "\n *** $TODAY $DATE ***\n"

 if [ $TODAY == "SOBOTA" ] || [ $TODAY == "NEDĚLE" ] ;then printf "\n Na vikend restaurace menicka nezverejnuji. \n\n" ;exit 1 ;fi

 if [ $# -eq 0 ]; then
   All
 else
   while [ ! $# -eq 0 ]
   do
     case "$1" in
            -a | --A-Sport)
            A-Sport ;;
            -b | --Bavorska)
            Bavorska ;;
            -c | --Corrida)
            Corrida ;;
            -p | --Paladeo)
            Paladeo ;;
            -pu | --Purkynka)
            Purkynka ;;
            -e | --Eures)
            Eures ;;
            -g | --Globus)
            Globus ;;
            -k | --Kanas)
            Kanas ;;
            -ko | --Kotelna)
            Kotelna ;;
            -m | --Miki)
            Miki ;;
            -o | --Ocean48)
            Ocean48 ;;
            -re | --Rebio)
            Rebio ;;
            -r | --Rubin)
            Rubin ;;
            -v | --Velorex)
            Velorex ;;
            -A | --all)
            All ;;
            -h | --help)
            Help ; exit 0 ;;
            -U | --update)
            Update ; exit 0 ;;
      esac
      shift
    done
 fi

exit 0


## poznamky / bordel --------------------------------------------------------------------------------------------

--places
A-Sport     OK
Corrida     OK
Eures       OK
Globus      OK
Kanas       opravit odsazeni
Miki        OK
Paladeo     opravit odsazeni cenovek + umazat Kc
Purkynka    OK
Rubin       OK
Velorex     OK
Bavorska    Neni dodelane!
Rebio       OK ...dodelat full menu z pdf2txt za ceny zavislosti (tvle, to nebude nikdo chtit)
Ocean48     Neni dodelane!
Kotelna     Neni dodelane!



# ToDO ----------------------------------------------------------------------------------------------------------

@LONGTERM
parsovat jednoduzeji z jednoho zdroje
https://www.zomato.com/brno/daily-menus

poucit se z ... a parsovat kultivovaneji :]
http://www.superlectures.com/openalt2015/textove-transformace-sed-tr-awk



1. dependency check / reduce
## add a dependency check curl | perl(web export) | pdf2txt(rebio import)

a INPUT check, povolit vlozit jen parametery, ktere jsou pouzite

## kontrola vstupu dodelat
#if [ $# -ne 1 ]
#    then
#        echo "wrong number of parameters"
#Help
#exit 2
#fi

2. search function as a flag

 Meat:
 -K  | --kure
 -V  | --veprove
 -H  | --hovezi
 -R  | --ryba
 -G  | --guláš

 opt:
 -S  | --search [ kure|veprove|hovezi|guláš|salat|spagety ]          +diakritika


3. email/web
 -E  | --email who@where.xx    hoe@whore.xxx                         send manualy or daily @11 from crontab at laptop
 -W  | --www 8000                            9.xxx IBM public IP from laptop or synology home > anonymIP > smartphone

  ...menu.gedik.cz


4. auto update [DONE]
  if file in URL exists replace the current one
  https://github.com/geppertl/ibm-menu/blob/master/ibm-menu.sh


5. footer
## kdyz vikend, print ze nejsou zverejny menicka a konci [done]

# Obed, jediny svetly bod v modrych dnech IBMera.

# vpatek print PATEK PYCOOO!!!

# Práce snů neexistuje. Práce je popřením člověka v jeho podstatě.

# „Lidi chcou mít aspoň hospodu čistou, když je všude kolem takovej bordel.“

# Nenechte si nikym zkurvit chut. Vzdyt' i ten nejvetsi looser si zaslouzi svych 30minutek poledniho klidu.

# komu se nelibi cool skript, muzete pouzivat neco jako
# https://play.google.com/store/apps/details?id=cz.Menicka.Menicka
