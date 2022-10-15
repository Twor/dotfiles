#! /bin/bash
str_arr=(1 2 3 4 5 6 7 8 9 0 A B C D E F)
color="#"

function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(($RANDOM+1000000000)) #增加一个10位的数再求余
    echo $(($num%$max+$min))
}
i=0
while (( $i<6 ))
do
    rnd=$(rand 0 15)
    color=$color${str_arr[$rnd]}
    let "i++"
done

echo $color
# export RAND_COLOR=(echo $color)
