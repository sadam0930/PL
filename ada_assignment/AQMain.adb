with Text_Io;
with Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

use Text_Io;
use Ada.Float_Text_IO;

with AdaptiveQuad;

procedure AQMain is
	package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
	use FloatFunctions;

	Eps : constant Float :=  0.000001;

	function MyF(x : Float) return Float is
	begin
		return Sin(x);
	end MyF;

	package AQuad is new AdaptiveQuad(MyF);

	task ReadPairs;
	task ComputeArea is 
		entry getInterval(A, B : Float);
		entry done();
	end ComputeArea;

	task body ReadPairs is
		A, B : Float;
		for i in 1...5 loop
			-- toDo: read values A and B using Get procedure
			-- toDo: feed A and B to ComputeArea (call entry)
			ComputeArea.getInterval(A, B);
		end loop;
		ComputeArea.done();
	end ReadPairs;

	task body ComputeArea is
		notDone : boolean := true; -- ada booleans?
		while notDone loop
			select 
				accept getInterval(A, B : Float) do
					--toDo: save values into local variables
				end getInterval;
			or
				accept done() do
					notDone := false;
				end done;

			--toDo: call AQuad
			--toDo: when Aquad return, pass result to PrintResult
		end loop;
	end ComputeArea;

begin
	put_line("hello");
end AQMain;