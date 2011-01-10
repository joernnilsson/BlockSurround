vmap ,f :python BlockSurround('for')<cr>
vmap ,i :python BlockSurround('if')<cr>

python << EOF

def BlockSurround(block):
	import vim
	import re
	buffer = vim.current.buffer
	cLine, cCol = vim.current.window.cursor

	first = int(vim.eval("line(\"'<\")"))
	last = int(vim.eval("line(\"'>\")"))

	# get indent of first line
	indent = re.match("(\s*).*", buffer[first-1]).group(1)

	# indent stuff
	for n in range(first, last+1):
		buffer[n-1] = "\t"+buffer[n-1]

	buffer.append(indent+'}', last);

	if block == 'for':
		buffer.append(indent+'for(var i=0; i<something.length;i++){', first-1);
	elif block == 'if':
		buffer.append(indent+'if(something){', first-1);

EOF

