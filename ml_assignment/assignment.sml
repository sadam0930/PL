Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(* 1 *)
fun merge (x::xs) (nil) = x::xs
 | merge (nil) (y::ys) = y::ys
 | merge (nil) (nil) = []
 | merge (x::xs) (y::ys) = if x < y 
 							then x::merge (xs) (y::ys) 
 							else y::merge (x::xs) (ys) 

(* 2 *)
fun split [] = ([], [])
 | split [x] = ([x], [])
 | split (x::y::xs) = let val (a, b) = split xs
 					  in (x::a, y::b)
 					  end;

(* 3 *)
fun mergeSort [] = []
 | mergeSort [x] = [x]
 | mergeSort (x::xs) = let val (a, b) = split (x::xs)
		 			   in merge (mergeSort a) (mergeSort b)
		 			   end;

(* 4 *)
fun sort (op <) [] = []
 | sort (op <) [x] = [x]
 | sort (op <) (x::xs) = 
 		let 
			fun merge (x::xs) (nil) = x::xs
			 | merge (nil) (y::ys) = y::ys
			 | merge (nil) (nil) = []
			 | merge (x::xs) (y::ys) = if x < y 
 										then x::merge (xs) (y::ys) 
 										else y::merge (x::xs) (ys)
 			fun split [] = ([], [])
 			 | split [x] = ([x], [])
 			 | split (x::y::xs) = let val (a, b) = split xs
 			 					  in (x::a, y::b)
 			 					  end;
	  		val (a, b) = split (x::xs)
 		in
 			merge (sort (op <) a) (sort (op <) b)
 		end;

(* 5 *)
datatype 'a tree = empty
	| leaf of 'a 
	| node of 'a * 'a tree * 'a tree

(* 6 *)
fun labels empty = [] 
 | labels (leaf x) = [x]
 | labels (node (x, left, right)) = labels left @ [x] @ labels right

(* 7 *)
infix ==

fun replace (op ==) a b empty = empty
 | replace (op ==) a b (leaf c) = if c == a 
 								  then (leaf b) 
 								  else (leaf c)
 | replace (op ==) a b (node (x, left, right)) = if x == a 
 												 then (node (b, replace (op ==) a b left, replace (op ==) a b right))
 												 else (node (x, replace (op ==) a b left, replace (op ==) a b right))

(* 8 *)
fun replaceEmpty a empty = a 
 | replaceEmpty a (leaf b) = (leaf b)
 | replaceEmpty a (node (c, left, right)) = (node (c, replaceEmpty a left, replaceEmpty a right))

(* 9 *)
fun mapTree f empty = f empty
 | mapTree f (leaf a) = f (leaf a)
 | mapTree f (node (a, left, right)) = f (node (a, mapTree f left, mapTree f right))

(* 10 *)
fun sortTree (op <) tree = mapTree (fn 
									empty => empty
									| (leaf a) => (leaf (sort (op <) a))
									| (node (x, left, right)) => (node ((sort (op <) x), left, right))
									) tree