initialize-release
size: aSize amount: anAmount
	size := aSize.
	self
		in: #(#input);
		out:
			{{#output.
			size}};
		state:
			{{#main.
			[ :i :in :out | 
			1 to: anAmount do: [ :k | out at: k put: (in at: k) ].
			self next: #main with: i % size + 1 ].
			{{#input.
			nil.
			anAmount}.
			{#output.
			[ :i | i ].
			anAmount}}}}.
	self next: #main with: 1