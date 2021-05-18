/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_5381(char*, char *);
extern void execute_5382(char*, char *);
extern void execute_5383(char*, char *);
extern void execute_5373(char*, char *);
extern void execute_5374(char*, char *);
extern void execute_5375(char*, char *);
extern void execute_5376(char*, char *);
extern void execute_5377(char*, char *);
extern void execute_5378(char*, char *);
extern void execute_5379(char*, char *);
extern void execute_5380(char*, char *);
extern void execute_702(char*, char *);
extern void execute_39(char*, char *);
extern void execute_695(char*, char *);
extern void execute_696(char*, char *);
extern void execute_697(char*, char *);
extern void execute_698(char*, char *);
extern void execute_699(char*, char *);
extern void execute_700(char*, char *);
extern void execute_701(char*, char *);
extern void execute_679(char*, char *);
extern void execute_680(char*, char *);
extern void execute_681(char*, char *);
extern void execute_682(char*, char *);
extern void execute_683(char*, char *);
extern void execute_684(char*, char *);
extern void execute_358(char*, char *);
extern void execute_359(char*, char *);
extern void execute_119(char*, char *);
extern void execute_120(char*, char *);
extern void execute_60(char*, char *);
extern void execute_61(char*, char *);
extern void execute_45(char*, char *);
extern void execute_46(char*, char *);
extern void execute_47(char*, char *);
extern void execute_686(char*, char *);
extern void execute_687(char*, char *);
extern void execute_688(char*, char *);
extern void execute_689(char*, char *);
extern void execute_690(char*, char *);
extern void execute_691(char*, char *);
extern void execute_692(char*, char *);
extern void execute_693(char*, char *);
extern void execute_694(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[46] = {(funcp)execute_5381, (funcp)execute_5382, (funcp)execute_5383, (funcp)execute_5373, (funcp)execute_5374, (funcp)execute_5375, (funcp)execute_5376, (funcp)execute_5377, (funcp)execute_5378, (funcp)execute_5379, (funcp)execute_5380, (funcp)execute_702, (funcp)execute_39, (funcp)execute_695, (funcp)execute_696, (funcp)execute_697, (funcp)execute_698, (funcp)execute_699, (funcp)execute_700, (funcp)execute_701, (funcp)execute_679, (funcp)execute_680, (funcp)execute_681, (funcp)execute_682, (funcp)execute_683, (funcp)execute_684, (funcp)execute_358, (funcp)execute_359, (funcp)execute_119, (funcp)execute_120, (funcp)execute_60, (funcp)execute_61, (funcp)execute_45, (funcp)execute_46, (funcp)execute_47, (funcp)execute_686, (funcp)execute_687, (funcp)execute_688, (funcp)execute_689, (funcp)execute_690, (funcp)execute_691, (funcp)execute_692, (funcp)execute_693, (funcp)execute_694, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 46;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/pipelinedModInv_TB_behav/xsim.reloc",  (void **)funcTab, 46);
	iki_vhdl_file_variable_register(dp + 715248);
	iki_vhdl_file_variable_register(dp + 715304);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/pipelinedModInv_TB_behav/xsim.reloc");
}

void simulate(char *dp)
{
	iki_schedule_processes_at_time_zero(dp, "xsim.dir/pipelinedModInv_TB_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/pipelinedModInv_TB_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/pipelinedModInv_TB_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/pipelinedModInv_TB_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
