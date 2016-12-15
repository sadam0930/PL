class OInt (x : Int) extends Ordered [OInt] {
	var i = x;
	def compare(that: OInt) = this.i.compare(that.i)
	override def toString() = "<" + i + ">"
}

abstract class OTree[T <: Ordered[T]] extends Ordered [OTree[T]];

case class OLeaf[T <: Ordered[T]] (x : T) extends OTree[T] {
	def compare(that : OTree[T]) = that match {
		case OLeaf(y) => x.compare(y)
		case ONode(_) => -1
	}
}

case class ONode[T <: Ordered[T]] (x : List[OTree[T]]) extends OTree[T] {
	def compare(that : OTree[T]) = that match {
		case OLeaf(_) => 1
		case ONode(y) => compareLists(x, y)
	}

	def compareLists(l1 : List[OTree[T]], l2 : List[OTree[T]]) : Int = (l1, l2) match {
		case (List(), List()) => 0
		case (x::xs, List()) => 1
		case (List(), y::ys) => -1
		case (x::xs, y::ys) => if(x.compare(y) == 0){
			compareLists(xs, ys)
		} else {
			x.compare(y)
		}
	}
}

object Part2 {
	def compareTrees[T <: Ordered[T]] (tree1 : OTree[T], tree2 : OTree[T]) {
		if (tree1.compare(tree2) == 0){
			println("Equal")
		} else if (tree1.compare(tree2) < 0) {
			println("Less")
		} else {
			println("Greater")
		}
	}

	def test() {
	    val tree1 = ONode(List(OLeaf(new OInt(6))))

	    val tree2 = ONode(List(OLeaf(new OInt(3)),
				   OLeaf(new OInt(4)), 
				   ONode(List(OLeaf(new OInt(5)))), 
				   ONode(List(OLeaf(new OInt(6)), 
					      OLeaf(new OInt(7))))));

	    val treeTree1: OTree[OTree[OInt]] = 
	      ONode(List(OLeaf(OLeaf(new OInt(1)))))

	    val treeTree2: OTree[OTree[OInt]] = 
	      ONode(List(OLeaf(OLeaf(new OInt(1))),
			 OLeaf(ONode(List(OLeaf(new OInt(2)), 
					  OLeaf(new OInt(2)))))))

	    print("tree1: ")
	    println(tree1)
	    print("tree2: ")
	    println(tree2)
	    print("treeTree1: ")
	    println(treeTree1)
	    print("treeTree2: ")
	    println(treeTree2)
	    print("Comparing tree1 and tree2: ")
	    compareTrees(tree1, tree2)
	    print("Comparing tree2 and tree2: ")
	    compareTrees(tree2, tree2)
	    print("Comparing tree2 and tree1: ")
	    compareTrees(tree2, tree1)
	    print("Comparing treeTree1 and treeTree2: ")
	    compareTrees(treeTree1, treeTree2)
	    print("Comparing treeTree2 and treeTree2: ")
	    compareTrees(treeTree2, treeTree2)
	    print("Comparing treeTree2 and treeTree1: ")
	    compareTrees(treeTree2, treeTree1)
	}

	def main(args : Array[String]) {
		test();
	}
}