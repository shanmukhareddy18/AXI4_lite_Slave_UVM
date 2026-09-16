/*class driver extends uvm_driver #(seq_item);
`uvm_component_utils(driver)
function new(string name="driver",uvm_component parent);
 super.new(name,parent);
endfunction


virtual inf.DRV vif;
axi_config cf;
bit addr_done;
bit data_done;
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 uvm_config_db#(axi_config)::get(this,"","config",cf);
 vif=cf.intrf;
endfunction

task run_phase(uvm_phase phase);
repeat(2) @(vif.drv_cb); 
forever begin
	 seq_item_port.get_next_item(req);
          @(vif.drv_cb);
`uvm_info("DRV",$sformatf("AWADDR=%b ,AWPROT=%b ,AWVALID=%b ,WDATA=%b ,WVALID=%b ,WSTRB=%b ,BREADY=%b ,ARADDR=%b ,ARPROT=%b ,ARVALID=%b ,RREADY=%b",
               req.AWADDR,req.AWPROT,req.AWVALID,req.WDATA,req.WVALID,req.WSTRB,req.BREADY,req.ARADDR,req.ARPROT,req.ARVALID,req.RREADY),UVM_NONE)
       fork
         begin
          if(req.trans_type==1 || req.trans_type==2)
             write_trans();
         end
         begin
          if(req.trans_type==0 || req.trans_type==2)
	     read_trans(); 
         end
       join
      seq_item_port.item_done(); 
end
endtask

task write_trans();
fork
 begin
  vif.drv_cb.AWADDR<=1;
  vif.drv_cb.AWPROT<=req.AWPROT;
  vif.drv_cb.AWVALID<=req.AWVALID;
  if(req.AWVALID)begin
   do @(vif.drv_cb);
    while(!vif.drv_cb.AWREADY); 
   addr_done=1;
   @(vif.drv_cb);
   vif.drv_cb.AWVALID<=0; end
 end
 begin
  vif.drv_cb.WDATA<=req.WDATA;
  vif.drv_cb.WSTRB<=4'b1111;
  vif.drv_cb.WVALID<=req.WVALID;
  if(req.WVALID)begin
    do @(vif.drv_cb); 
     while(!vif.drv_cb.WREADY); 
    data_done=1;
    @(vif.drv_cb);
    vif.drv_cb.WVALID<=0; end
end
join
   vif.drv_cb.BREADY<=req.BREADY;
   if(req.BREADY && addr_done && data_done)begin
     do @(vif.drv_cb); 
     while(!vif.drv_cb.BVALID); 
   addr_done=0;
   data_done=0;  
 end
endtask

task read_trans();
fork
 begin
  vif.drv_cb.ARADDR<=1;
  vif.drv_cb.ARPROT<=req.ARPROT;
  vif.drv_cb.ARVALID<=req.ARVALID;
  if(req.ARVALID)begin
    do   @(vif.drv_cb);
   while(!vif.drv_cb.ARREADY);
   vif.drv_cb.ARVALID<=0; end
 end
 begin
   vif.drv_cb.RREADY<=req.RREADY;
  if(req.RREADY)begin
   do @(vif.drv_cb);
    while(!vif.drv_cb.RVALID);end
 end
join
endtask

endclass*/

class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  virtual inf.DRV vif;
  axi_config cf;
  bit addr_done;
  bit data_done;
  uvm_seq_item_pull_port #(seq_item) wr_item_port;
  uvm_seq_item_pull_port #(seq_item) rd_item_port;
  function new(string name="driver", uvm_component parent);
    super.new(name,parent);
    wr_item_port = new("wr_item_port", this);
    rd_item_port = new("rd_item_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(axi_config)::get(this,"","config",cf);
    vif = cf.intrf;
  endfunction

  seq_item req_wr;
  seq_item req_rd;
task run_phase(uvm_phase phase);
    repeat(2) @(vif.drv_cb);
    fork
     begin
       forever begin
        wr_item_port.get_next_item(req_wr);
        write_trans(req_wr);
        wr_item_port.item_done();
       end
     end
     begin
       forever begin
        rd_item_port.get_next_item(req_rd);
        read_trans(req_rd);
        rd_item_port.item_done();
       end
     end
    join
 endtask

task write_trans(seq_item req);
fork
 begin
  vif.drv_cb.AWADDR<=32'h28;
  vif.drv_cb.AWPROT<=req.AWPROT;
  vif.drv_cb.AWVALID<=req.AWVALID;
  if(req.AWVALID)begin
   do @(vif.drv_cb);
    while(!vif.drv_cb.AWREADY);
   addr_done=1;
   vif.drv_cb.AWVALID<=0; end
 end
 begin
  vif.drv_cb.WDATA<=req.WDATA;
  vif.drv_cb.WSTRB<=req.WSTRB;
  vif.drv_cb.WVALID<=req.WVALID;
  if(req.WVALID)begin
    do @(vif.drv_cb);
     while(!vif.drv_cb.WREADY);
    data_done=1;
    vif.drv_cb.WVALID<=0; end
end
join
   vif.drv_cb.BREADY<=req.BREADY;
   if(req.BREADY && addr_done && data_done)begin
     do @(vif.drv_cb);
     while(!vif.drv_cb.BVALID);
   addr_done=0;
   data_done=0;
 end
  
endtask

task read_trans(seq_item req);
  fork
   begin
     vif.drv_cb.ARADDR<=32'h28;
    vif.drv_cb.ARPROT<=req.ARPROT;
    vif.drv_cb.ARVALID<=req.ARVALID;
    if(req.ARVALID)begin
      do   @(vif.drv_cb);
      while(!vif.drv_cb.ARREADY);
     vif.drv_cb.ARVALID<=0; end
   end
   begin
    vif.drv_cb.RREADY<=req.RREADY;
    if(req.RREADY)begin
     do @(vif.drv_cb);
     while(!vif.drv_cb.RVALID);end
   end
 join
  
endtask
endclass
