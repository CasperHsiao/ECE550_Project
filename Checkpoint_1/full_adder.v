module full_adder(a, b, ci, s, co);
	input a, b, ci;
	
	output s, co;
	
	wire m, n, p;
	
	xor(m, a, b);
	xor(s, m, ci);
	and(n, m, ci);
	and(p, a, b);
	or(co, n, p);
	
endmodule
