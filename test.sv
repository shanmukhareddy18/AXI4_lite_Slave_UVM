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

endclass


class test1 extends test;
`uvm_component_utils(test1)
function new(string name="test1",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence1 s1;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s1=sequence1::type_id::create("s1");
  s1.start(e.aa.ws);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test2 extends test;
`uvm_component_utils(test2)
function new(string name="test2",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence2 s2;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s2=sequence2::type_id::create("s2");
  s2.start(e.aa.ws);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test3 extends test;
`uvm_component_utils(test3)
function new(string name="test3",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence3 s3;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s3=sequence3::type_id::create("s3");
  s3.start(e.aa.ws);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test4 extends test;
`uvm_component_utils(test4)
function new(string name="test4",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence7 s7;
sequence4 s4;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s4=sequence4::type_id::create("s4");
  s7=sequence7::type_id::create("s7");
  s4.start(e.aa.ws);
  s7.start(e.aa.rs);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test5 extends test;
`uvm_component_utils(test5)
function new(string name="test5",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence5 s5;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s5=sequence5::type_id::create("s5");
  s5.start(e.aa.ws);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test6 extends test;
`uvm_component_utils(test6)
function new(string name="test6",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence6 s6;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s6=sequence6::type_id::create("s6");
  s6.start(e.aa.ws);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test7 extends test;
`uvm_component_utils(test7)
function new(string name="test7",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence7 s7;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s7=sequence7::type_id::create("s7");
  s7.start(e.aa.rs);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test8 extends test;
`uvm_component_utils(test8)
function new(string name="test8",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence8 s8;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s8=sequence8::type_id::create("s8");
  s8.start(e.aa.rs);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test9 extends test;
`uvm_component_utils(test9)
function new(string name="test9",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence9 s9;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s9=sequence9::type_id::create("s9");
  s9.start(e.aa.rs);
  #50;
  phase.drop_objection(this);
endtask
endclass

class test10 extends test;
`uvm_component_utils(test10)
function new(string name="test10",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

sequence10 s10;
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  s10=sequence10::type_id::create("s10");
  s10.start(e.aa.rs);
  #50;
  phase.drop_objection(this);
endtask
endclass

