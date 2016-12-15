import java.util.ArrayList;
import java.util.Iterator;

class ComparableList<T extends A> extends ArrayList<T> implements Comparable<ComparableList<T>> {
	ComparableList() {
        super();
    }

    public ComparableList(ComparableList<T> list) {
        super(list);
    }

	public int compareTo(ComparableList<T> other){
		Iterator<T> i = this.iterator();
		Iterator<T> j = other.iterator();

		while(i.hasNext() && j.hasNext()){
			T left = i.next();
			T right = j.next();
			int comparison = left.compareTo(right);
			if(comparison != 0){
				return comparison;
			}
		}
		//all elements up to now are equal
		if(i.hasNext()){ return 1; }	//this has more elements
		else if(j.hasNext()){ return -1; } //other has more elements
		else { return 0; } 
	}
}

class A {
	int something;
	
	A(int x){
		this.something = x;
	}

	public int getSomething(){
		return something;
	}

	public int compareTo(A other){
		if(this.getSomething() == other.getSomething()) {
			return 0;
		} else if (this.getSomething() < other.getSomething()) {
			return -1;
		} else {
			return 1;
		}
	}

	public String toString(){
		return "A<" + something + "> ";
	}
}

class B extends A {
	int thing2;

	B(int x, int y){
		super(x);
		this.thing2 = y;
	}

	public int getSomething(){
		return something + thing2;
	}

	public int compareTo(B other){
		if(this.getSomething() == other.getSomething()){
			return 0;
		} else if(this.getSomething() < other.getSomething()){
			return -1;
		} else {
			return 1;
		}
	}

	public String toString() {
		return "B<" + something + "," + thing2 + "> ";
    }
}

class Part1 {
	public static void main(String args[]){
		test();
	}

	static <T extends A> void addToCList(T z, ComparableList<T> l){
		l.add(z);
	}

	static void test() {
		ComparableList<A> c1 = new ComparableList<A>();
		ComparableList<A> c2 = new ComparableList<A>();
		for(int i = 0; i < 10; i++) {
		    addToCList(new A(i), c1);
		    addToCList(new A(i), c2);
		}
		
		addToCList(new A(12), c1);
		addToCList(new B(6,6), c2);
		
		addToCList(new B(7,11), c1);
		addToCList(new A(13), c2);

		System.out.print("c1: ");
		System.out.println(c1);
		
		System.out.print("c2: ");
		System.out.println(c2);

		switch (c1.compareTo(c2)) {
		case -1: 
		    System.out.println("c1 < c2");
		    break;
		case 0:
		    System.out.println("c1 = c2");
		    break;
		case 1:
		    System.out.println("c1 > c2");
		    break;
		default:
		    System.out.println("Uh Oh");
		    break;
		}
    }
}