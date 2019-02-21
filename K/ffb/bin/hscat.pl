#!/usr/bin/perl -w
use File::Basename;


$PROG = './hscat';


param();
options();
arguments();
setlines();


open  (INPUT , "|$PROG ");
print INPUT ("$LINES \n");
close (INPUT);


###################################################
sub param{
    $num_of_infile   =  0      ;
    $kind_of_format  =  2      ;
    $mode_of_file    =  1      ;
    $num_of_data     = -1      ;
    $flag_of_trange  =  0      ;
    $interval        =  1      ;
    $mode_operation  =  0      ;
}


###################################################
sub options{
    if($#ARGV==-1){ help(); exit;}
    $_=$ARGV[0];
    while($#ARGV>=0){
	
####[options of IO]
        if (!/^-/     ) { push(@tmp,$_);}
	if (/^-help/  ) { help(); exit; } 
	if (/^-gf/    ) { $kind_of_format  = 1 ; } 
	if (/^-unfmt/ ) { $mode_of_file    = 2 ; } 
	if (/^-data/  ) {
            shift(@ARGV) ; $num_of_data     = $ARGV[0] ; 
            for($i=0;$i<$num_of_data;$i++){
                shift(@ARGV) ; $data_list[$i] = $ARGV[0] ;
                if($#ARGV<=0){ error00(); exit;}
            } 
        } 
	if (/^-range/ ) {
            $flag_of_trange =1  ; 
            shift(@ARGV) ; $tbegin = $ARGV[0] ; 
            shift(@ARGV) ; $tend   = $ARGV[0] ;   
        }
        if (/^-int/   ) { shift(@ARGV) ; $interval = $ARGV[0] ; }
	
	
####[operation mode]
	if (/^-smooth/) {
            $mode_operation = 2 ;  
            shift(@ARGV) ; $num_smooth  = $ARGV[0] ;   
        }
	if (/^-diff/  ) {
            $mode_operation = 3 ;  
            shift(@ARGV) ; $num_diff    = $ARGV[0] ;   
        }
	if (/^-autoco/) {
            $mode_operation = 4 ;
        }
	if (/^-cross/ ) {
            $mode_operation = 5 ;
            shift(@ARGV) ; $num_of_cross   = $ARGV[0] ; 
            for($i=0;$i<($num_of_cross)*2;$i++){
                shift(@ARGV) ; $cross_list[$i] = $ARGV[0] ;
            } 
        } 
	if (/^-power/ ) {
            $mode_operation = 6 ;
        }
	if (/^-coher/ ) {
            $mode_operation = 7 ;
            shift(@ARGV) ; $num_of_coher   = $ARGV[0] ; 
            for($i=0;$i<($num_of_coher)*2;$i++){
                shift(@ARGV) ; $coher_list[$i] = $ARGV[0] ;
            }
        } 

        shift(@ARGV) ;
        $_=$ARGV[0];
    } 
    @ARGV=@tmp;
    if($#ARGV<=0){ error00(); exit;}
}


###################################################
sub arguments{
    while( $#ARGV !=0 ){
	$name_of_infile[$num_of_infile] = $ARGV[0];
	shift(@ARGV) ;
	$num_of_infile ++;
    }
    $name_of_outfile    = $ARGV[0];
}


###################################################
sub setlines{
    ##[Input File]
    $LINES = "$num_of_infile \n"    ;
    for($i=0;$i<$num_of_infile;$i++){
	$LINES = $LINES . "$name_of_infile[$i] \n";
    }
    
    ##[Output File]
    $LINES = $LINES . "$name_of_outfile \n" ;
    
    ##[File Format]
    $LINES = $LINES . "$kind_of_format \n" ;
    if($kind_of_format==1){
	$LINES = $LINES . "$mode_of_file \n";}
    
    ##[Data to be extracted]
    $LINES = $LINES . "$num_of_data \n";
    if($num_of_data!=-1){
	for($i=0;$i<$num_of_data;$i++){
	    $LINES = $LINES . "$data_list[$i] \n";
	}
    }
    
    ##[Set time range]
    $LINES = $LINES . "$flag_of_trange \n" ;
    if($flag_of_trange==1){
	$LINES = $LINES . "$tbegin \n"    ;
	$LINES = $LINES . "$tend   \n"    ;}
    
    ##[Set interval]
    $LINES = $LINES . "$interval \n";
    
    ##[Operation mode]
    $LINES = $LINES . "$mode_operation \n";
    if($mode_operation==2){
	$LINES = $LINES . "$num_smooth  \n"    ;}
    if($mode_operation==3){
	$LINES = $LINES . "$num_diff  \n"    ;}
    if($mode_operation==5){
	$LINES = $LINES . "$num_of_cross  \n"    ;
	for($i=0;$i<$num_of_cross;$i++){
	    $LINES = $LINES . "$cross_list[0+$i*2] $cross_list[1+$i*2] \n";
	}
    }
    if($mode_operation==6){
	$LINES = $LINES . "1    \n"    ;
	$LINES = $LINES . "0    \n"    ;
	$LINES = $LINES . "1    \n"    ;
	$LINES = $LINES . "1024 \n"    ;
	$LINES = $LINES . "0    \n"    ;
	$LINES = $LINES . "1    \n"    ;
    }
    if($mode_operation==7){
	$LINES = $LINES . "$num_of_coher  \n"    ;
	for($i=0;$i<$num_of_coher;$i++){
	    $LINES = $LINES . "$coher_list[0+$i*2] $coher_list[1+$i*2] \n";
	}
	$LINES = $LINES . "0    \n"    ;
	$LINES = $LINES . "1    \n"    ;
	$LINES = $LINES . "1024 \n"    ;
	$LINES = $LINES . "0    \n"    ;
	$LINES = $LINES . "1    \n"    ;
    }
    
    
    ##[terminate hscat]
    $LINES = $LINES . "0\n";
}


###################################################
sub error00{
    print("Invalid arguments.\n");
    print("\n");
    print("\n");
    help();
}


###################################################
sub help{
    my $name=basename($0);
    print(" <Usage>  $name  in-his[s] out-his \n");
    print("\n");
    print(" <Option>\n");
    print("   -gf           : change file format to GF \n");
    print("                 : default format is 'IGOL or SPG' format \n");
    print("   -unfmt        : change mode to unformatted  \n");
    print("                 : default mode is ascii \n");
    print("   -data         : data to be extracted \n");
    print("     (num,list)  : num :number of data \n");
    print("                 : list:list of data number (1,num)\n");
    print("                 : all data will be extracted without this option \n");
    print("   -range (t0,t1): range of time  \n");
    print("                 : t0:start time t1:end time \n");
    print("   -int          : sampling interval \n");
    print("                 : default interval is 1  \n");
    print("\n");
    print(" Options to switch operation  \n");
    print("   -smooth (num) : smooth        (polynomial curve fit)\n");
    print("                 : num: number of points used for curve fitting  \n");
    print("   -diff   (num) : differentiate (polynomial curve fit)\n");
    print("                 : num: number of points used for curve fitting  \n");
    print("   -autoco       : take auto  correlation (time space)\n");
    print("   -cross        : take cross correlation (time space)\n");
    print("      (num,list) : num :number of data \n");
    print("                 : list:list of data pair number (1,num*2)\n");
    print("   -power        : calculate power spectrum \n");
    print("   -coher        : calculate coherence \n");
    print("      (num,list) : num :number of data \n");
    print("                 : list:list of data pair number (1,num*2)\n");
    print("\n");
}


