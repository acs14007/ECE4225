# project name
name task1
# execution graph
job 2 -d "1"  -post { extract_vars "$wdir" n2_des.out 2 }  -o n2_des "sdevice pp2_des.cmd"
job 6 -d "1"  -post { extract_vars "$wdir" n6_des.out 6 }  -o n6_des "sdevice pp6_des.cmd"
job 7 -d "1"  -post { extract_vars "$wdir" n7_des.out 7 }  -o n7_des "sdevice pp7_des.cmd"
job 1   -post {  extract_vars "$wdir" n1_fps.out 1; catch {os_cp "$wdir/n1_mdr.cmd" "$wdir/n1_msh.cmd"}; catch {os_cp "$wdir/n1_mdr.bnd" "$wdir/n1_msh.bnd"} }  -o n1_fps "sprocess -u -b n1_fps.cmd"
check sprocess_fps.cmd 1604699308
check sdevice_des.cmd 1604698603
check global_tooldb 1526577858
check gtree.dat 1604696725
# included files
