examples
sendIdentityReceive
	"A send -> transmit -> receive. "

	"TauCTest new sendIdentityReceive"

	<example>
	| s sender transmit reader |
	s := TauCSystem new.
	sender := TauCTask
		named: 'sender'
		out: #send
		state:
			{{#main.
			[ :send | 
			send at: 1 put: 5.
			Transcript
				show: 'Send 5';
				cr ].
			{{#send . nil . 1}}}}
		world: s.
	transmit := TauCTask
		named: 'transmit'
		in: #read
		out: #send
		state:
			{{#main.
			[ :send :read | 
			send at: 1 put: read first.
			Transcript
				show: 'Transmitted ' , read first printString;
				cr ].
			{{#send . nil . 1}.
			{#read . nil . 1}}}}
		world: s.
	reader := TauCTask
		named: 'reader'
		in: #read
		out: #()
		state:
			{{#main.
			[ :read | 
			Transcript
				show: 'Received ' , read first printString;
				cr ].
			{{#read . nil . 1}}}}
		world: s.
	(sender portNamed: #send) connectTo: (transmit portNamed: #read).
	(transmit portNamed: #send) connectTo: (reader portNamed: #read).
	s fullyConnected.
	s exploreInRoassal