#! /bin/bash

export IM_TOP="$(cd "$(dirname "$0")" && pwd)"
export IM_FATHER=$$

#TODO: Through the signal, kill the parent process, stop compiling.
trap "__trap_crash__" TERM
function __trap_crash__ (){
	echo "------------------Crash-Trap-------------------"
	exit 1
}
function __crash__ (){
	kill -s TERM $IM_FATHER
	exit 1 # In the pipeline for project, this is needed.
}

#TODO: In this way, similar to shared memory, sub-script changes can be passed to the parent script.
export __crash_file__=$IM_TOP/crash_flag
function __get_crash_flag__ (){
	local r=$(cat $__crash_file__)
	echo $r
}
function __set_crash_flag__ (){
	echo 1 > $__crash_file__
}
function __init_crash_flag__ (){
	echo 0 > $__crash_file__
}

function deal_test (){
	__crash__
}

#TODO: In project , useful.
#__init_crash_flag__
#__set_crash_flag__
#if [ "$(__get_crash_flag__)" = "1" ];then
	#__crash__
#fi

echo before
: | deal_test
echo after

#end of file

