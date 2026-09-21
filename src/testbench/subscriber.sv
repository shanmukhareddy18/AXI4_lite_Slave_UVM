class subscriber extends uvm_subscriber #(seq_item);
`uvm_component_utils(subscriber)
uvm_analysis_imp #(seq_item,subscriber) inp_ap;
uvm_analysis_imp_out #(seq_item,subscriber) out_ap;
seq_item inp_tx;
seq_item out_tx;

covergroup cg1;
 awaddr: coverpoint inp_tx.AWADDR {
	bins rw={[0:39]};
	bins r={[40:51]};
	bins w={[52:59]};
	bins rw_at3C={[60:63]};
	bins OFB={[64:$]};
	}
 awaddr_alignment: coverpoint inp_tx.AWADDR[1:0] {
	bins alig={2'b00};
	bins unali={2'b01,2'b10,2'b11};
	}

 awaddrXaddr_align: cross awaddr,awaddr_alignment;

 coverpoint inp_tx.AWPROT; 
endgroup
covergroup cg2;
 wr_strb: coverpoint inp_tx.WSTRB;
endgroup

covergroup cg3;
 coverpoint out_tx.BRESP{
     bins okay={2'b00};
     bins slverr={2'b10};
     bins decerr={2'b11};

}
endgroup
covergroup cg4;
   araddr: coverpoint inp_tx.ARADDR {
	bins rw={[0:39]};
	bins r={[40:51]};
	bins w={[52:59]};
	bins rwat3C={[60:63]};
	bins OFB={[64:$]};
		}
   alignVSunalign: coverpoint inp_tx.ARADDR[1:0] {
	bins align={2'b00};
	bins unalign={2'b01,2'b10,2'b11};
		}
endgroup
covergroup cg5;
 rresp: coverpoint out_tx.RRESP {
	bins okay={2'b00};
	bins slverr={2'b10};
	bins decerr={2'b11};
		}
endgroup 
function new(string name="subscriber",uvm_component parent);
super.new(name,parent);
inp_ap=new("inp_ap",this);
out_ap=new("out_ap",this);
cg1=new();
cg2=new();
cg3=new();
cg4=new();
cg5=new();
endfunction

function void write(seq_item tr);
 inp_tx=tr;
 sampling();
endfunction
function void write_out(seq_item tr);
 out_tx=tr;
 sampling();
endfunction

 function void sampling();
    if(inp_tx == null || out_tx == null) begin
    return;
  end
    if(inp_tx.AWVALID && out_tx.AWREADY) begin
      cg1.sample();
    end

    if(inp_tx.WVALID && out_tx.WREADY) begin
      cg2.sample();
    end

    if(out_tx.BVALID && inp_tx.BREADY) begin
      cg3.sample();
    end

    if(inp_tx.ARVALID && out_tx.ARREADY) begin
      cg4.sample();
    end

    if(out_tx.RVALID && inp_tx.RREADY) begin
      cg5.sample();
    end
endfunction
endclass
