#!/bin/bash
 
shopt -s dotglob
shopt -s nullglob

fun0(){
	echo 'fun0'
}

fun1(){
	echo 'fun1' > /dev/null 2>&1
}

fun2(){
	echo 'fun2' 
}

fun3(){
	local kq
	
	kq=$(fun0)
	fun1
	fun2
	echo 'fun3'
}

h=$(fun3)

echo "h:""$h"
