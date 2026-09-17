class sequence1 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence1)
function new(string name="sequence1");
super.new(name);
endfunction
task body();
 req=seq_item::type_id::create("req");
 start_item(req);
  assert(req.randomize() with { AWVALID==1; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
   
endtask
endclass

class sequence2 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence2)
function new(string name="sequence2");
super.new(name);
endfunction
task body();
repeat(50)  begin
 req=seq_item::type_id::create("req");
 start_item(req);
  assert(req.randomize() with { AWADDR inside {0,4,8,12,16,20,24,28,32,36,60}; AWVALID==1; WVALID==0;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);

 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
end 
endtask
endclass

//writing into readonly regs
class sequence3 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence3)
function new(string name="sequence3");
super.new(name);
endfunction
task body();
repeat(10) begin
 req=seq_item::type_id::create("req");
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
 start_item(req);
  assert(req.randomize() with {AWADDR inside {40,44,48}; AWVALID==1; WVALID==0;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
end
endtask
endclass

//writing into R/W and W regs
class sequence4 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence4)
function new(string name="sequence4");
super.new(name);
endfunction
task body();
repeat(10) begin
 req=seq_item::type_id::create("req");
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
 start_item(req);
  assert(req.randomize() with {AWADDR inside {0,4,8,12,16,20,24,28,32,36,52,56,60}; AWVALID==1; WVALID==0;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
end
endtask
endclass

//writing into unaligned addr
class sequence5 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence5)
function new(string name="sequence5");
super.new(name);
endfunction
task body();
repeat(5) begin
 req=seq_item::type_id::create("req");
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
 start_item(req);
  assert(req.randomize() with {AWADDR inside {[0:63]}; AWADDR[1:0]!=2'b00; AWVALID==1; WVALID==0;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
end
endtask
endclass

//write in outofbound regs
class sequence6 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence6)
function new(string name="sequence6");
super.new(name);
endfunction
task body();
repeat(50) begin
 req=seq_item::type_id::create("req");
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==1;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
 start_item(req);
  assert(req.randomize() with { AWADDR>63; AWVALID==1; WVALID==0;trans_type==1;BREADY==1; ARVALID==0; } )
 finish_item(req);
end
endtask
endclass

//read in W/R and R regs
class sequence7 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence7)
function new(string name="sequence7");
super.new(name);
endfunction
task body();
 req=seq_item::type_id::create("req");
 repeat(10) begin
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==0;trans_type==0;BREADY==0;ARADDR inside {0,4,8,12,16,20,24,28,32,36,40,44,48,60}; ARVALID==1;RREADY==1; } )
 finish_item(req);end
endtask

endclass

//read in writeonly
class sequence8 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence8)
function new(string name="sequence8");
super.new(name);
endfunction
task body();
 req=seq_item::type_id::create("req");
 repeat(10) begin
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==0;trans_type==0;BREADY==0;ARADDR inside {52,56}; ARVALID==1;RREADY==1; } )
 finish_item(req);end
endtask

endclass

//read in outofbound
class sequence9 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence9)
function new(string name="sequence9");
super.new(name);
endfunction
task body();
 req=seq_item::type_id::create("req");
 repeat(10) begin
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==0;trans_type==0;BREADY==0;ARADDR>63; ARVALID==1;RREADY==1; } )
 finish_item(req);end
endtask

endclass

//read in unaligned addr
class sequence10 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence10)
function new(string name="sequence10");
super.new(name);
endfunction
task body();
 req=seq_item::type_id::create("req");
 repeat(10) begin
 start_item(req);
  assert(req.randomize() with { AWVALID==0; WVALID==0;trans_type==0;BREADY==0;ARADDR inside {[0:63]}; ARADDR[1:0]!=2'b00; ARVALID==1;RREADY==1; } )
 finish_item(req);end
endtask

endclass

