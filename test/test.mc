include "../src/models/modelVisualizer.mc"


mexpr
let string2string = (lam b. b) in
let eqString = setEqual eqchar in
let char2string = (lam b. [b]) in

-- create your DFA
let states = ["s0","s1","s2","s3"] in
let transitions = [
("s0","s1",'1'),
("s1","s1",'1'),
("s1","s2",'0'),
("s2","s1",'1'),
("s2","s3",'0'),
("s3","s1",'1')
] in

let startState = "s0" in
let acceptStates = ["s3"] in

let dfa = dfaConstr states transitions startState acceptStates eqString eqchar in

-- create your directed graph
let digraph = foldr (lam e. lam g. digraphAddEdge e.0 e.1 e.2 g) 
(foldr digraphAddVertex (digraphEmpty eqchar eqi) ['A','B','C','D','E']) 
            [('A','B',2),('A','C',5),('B','C',2),('B','D',4),('C','D',5),('C','E',5),('E','D',2)] in

-- create your graph
let graph = foldr (lam e. lam g. graphAddEdge e.0 e.1 e.2 g) 
(foldr graphAddVertex (graphEmpty eqi eqString) [1,2,3,4]) [(1,2,""),(3,2,""),(1,3,""),(3,4,"")] in

let nfaStates = ["a","b","c","d","e","f"] in
let nfaTransitions = [("a","b",'1'),("b","c",'0'),("c","d",'2'),("c","e",'2'),("d","a",'1'),("e","f",'1')] in
let nfaStartState = "a" in
let nfaAcceptStates = ["a"] in
	

-- create your NFA
let nfa = nfaConstr nfaStates nfaTransitions nfaStartState nfaAcceptStates eqString eqchar in

-- create your BTree
let btree = btreeConstr (Node(2, Node(3, Nil (), Leaf 4), Leaf 5)) eqi in

let circuit = Circuit (
            
            Series [
            
            Series [
            Component ("battery","V1",11.0),
            Component ("resistor","R3",1.4),
            Component ("resistor","R1",1.4),
            Component ("battery","V2",11.0),
            Component ("resistor","R2",1.4)
            ],
            Parallel [
            Component ("battery","V3",0.0),
            Component ("resistor", "R4",0.0)
            ],
            Component("ground","g",(None ())),
            Component("battery","V6",0.0),
            Close ()
        ]) in

visualize [
	-- accepted by the DFA
    circuit
	--DFA(dfa,"1001010",string2string, char2string,"LR",[("s0","start state"),("s3","accept state")]),
	-- DFA without simulation
	--DFA(dfa,"",string2string, char2string,"LR",[]),
	-- not accepted by the DFA
	--DFA(dfa,"101110",string2string, char2string,"LR",[]),
	-- not accepted by the DFA
	--DFA(dfa,"1010001",string2string, char2string,"LR",[]),
	--Digraph(digraph, char2string,int2string,"LR",[]),
	--Graph(graph,int2string,string2string,"LR",[]),
	--BTree(btree, int2string,"TB",[(2,"Two"),(3,"Three"),(4,"Four"),(5,"Five")]),
	--NFA(nfa, "1021", string2string, char2string,"LR",[]),
	--NFA(nfa, "1011", string2string, char2string,"LR",[])
	
]
