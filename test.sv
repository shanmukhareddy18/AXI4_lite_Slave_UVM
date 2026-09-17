class test extends uvm_test;
`uvm_component_utils(test)
function new(string name="test",uvm_component parent);
super.new(name,parent);
endfunction
env e;
axi_config cf;
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 e=env::type_id::create("e",this);
 cf=axi_config::type_id::create("cf",this);
uvm_config_db#(virtual inf)::get(this,"","vif",cf.intrf);
uvm_config_db#(axi_config)::set(this,"*","config",cf);
endfunction


function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
endfunction

sequence1 s1;
sequence2 s2;
sequence3 s3;
sequence4 s4;
sequence5 s5;
sequence6 s6;
sequence7 s7;
sequence8 s8;
sequence9 s9;
sequence10 s10;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s1=sequence1::type_id::create("s1");
  s2=sequence2::type_id::create("s2");
  s3=sequence3::type_id::create("s3");
  s4=sequence4::type_id::create("s4");
  s5=sequence5::type_id::create("s5");
  s6=sequence6::type_id::create("s5");
  s7=sequence7::type_id::create("s7");
  s8=sequence8::type_id::create("s7");
  s9=sequence9::type_id::create("s7");
  s10=sequence10::type_id::create("s7");
  fork
   // s1.start(e.aa.seqr);
   // s2.start(e.aa.ws);
    s3.start(e.aa.ws);
    s4.start(e.aa.ws);
    s5.start(e.aa.ws);
    s6.start(e.aa.ws);
    s7.start(e.aa.rs);
    s8.start(e.aa.rs);
    s9.start(e.aa.rs);
    s10.start(e.aa.rs);
  join
  #50;
  phase.drop_objection(this);
endtask
endclass
