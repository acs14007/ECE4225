# project name
name part1
# execution graph
job 8   -post { extract_vars "$wdir" n8_des.out 8 }  -o n8_des "sdevice pp8_des.cmd"
job 9   -post { extract_vars "$wdir" n9_des.out 9 }  -o n9_des "sdevice pp9_des.cmd"
job 10   -post { extract_vars "$wdir" n10_des.out 10 }  -o n10_des "sdevice pp10_des.cmd"
job 26   -post { extract_vars "$wdir" n26_des.out 26 }  -o n26_des "sdevice pp26_des.cmd"
job 27   -post { extract_vars "$wdir" n27_des.out 27 }  -o n27_des "sdevice pp27_des.cmd"
job 28   -post { extract_vars "$wdir" n28_des.out 28 }  -o n28_des "sdevice pp28_des.cmd"
job 29   -post { extract_vars "$wdir" n29_des.out 29 }  -o n29_des "sdevice pp29_des.cmd"
job 30   -post { extract_vars "$wdir" n30_des.out 30 }  -o n30_des "sdevice pp30_des.cmd"
job 31   -post { extract_vars "$wdir" n31_des.out 31 }  -o n31_des "sdevice pp31_des.cmd"
job 1   -post { extract_vars "$wdir" n1_dvs.out 1 }  -o n1_dvs "sde -l n1_dvs.cmd"
job 5   -post { extract_vars "$wdir" n5_des.out 5 }  -o n5_des "sdevice pp5_des.cmd"
job 7   -post { extract_vars "$wdir" n7_des.out 7 }  -o n7_des "sdevice pp7_des.cmd"
job 6   -post { extract_vars "$wdir" n6_dvs.out 6 }  -o n6_dvs "sde -l n6_dvs.cmd"
job 4   -post { extract_vars "$wdir" n4_dvs.out 4 }  -o n4_dvs "sde -l n4_dvs.cmd"
job 2   -post { extract_vars "$wdir" n2_des.out 2 }  -o n2_des "sdevice pp2_des.cmd"
check sde_dvs.cmd 1603501830
check sdevice_des.cmd 1603502277
check global_tooldb 1526577858
check gtree.dat 1603502287
# included files
