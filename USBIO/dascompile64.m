
githubpath = 'I:\Users\togt\Documents\GitHub\';
githubpath = [githubpath 'Mouse\USBIO'];

mex(['-L' githubpath ], '-lUSBIO', 'dasinit.cpp' )

mex(['-L' githubpath ], '-lUSBIO', 'dasbita.cpp' )
mex(['-L' githubpath ], '-lUSBIO', 'dasbitb.cpp' )

mex(['-L' githubpath ], '-lUSBIO', 'dasworda.cpp' )
mex(['-L' githubpath ], '-lUSBIO', 'daswordb.cpp' )