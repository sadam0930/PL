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
		return Sin(x**2);
	end MyF;

	package AQuad is new AdaptiveQuad(MyF);

	task ReadPairs;
	task ComputeArea is 
		entry getInterval(A, B : Float);
		entry done;
	end ComputeArea;
	task PrintResult is
		entry getResult(A, B, result : Float);
		entry done;
	end PrintResult;

	task body ReadPairs is
		A, B : Float;
	begin
		for i in 1 .. 5 loop
			get(A);
			get(B);

			ComputeArea.getInterval(A, B);
		end loop;
		-- put_line("Read DONE");
		ComputeArea.done;
	end ReadPairs;

	task body ComputeArea is
		notDone : Boolean := true;
		J, K, result : Float;
	begin
		while notDone loop
			select 
				accept getInterval(A, B : Float) do
					J := A;
					K := B;
				end getInterval;

				result := AQuad.AQuad(J, K, Eps);
				PrintResult.getResult(J, K, result);
			or
				accept done do
					notDone := false;
				end done;
			end select;
		end loop;
		-- put_line("Compute DONE");
		PrintResult.done;
	end ComputeArea;

	task body PrintResult is
		notDone : Boolean := true;
		J, K, R : Float;
	begin
		while notDone loop
			select 
				accept getResult(A, B, result : Float) do
					J := A;
					K := B;
					R := result;
				end getResult;

				put("The area under sin(x^2) for x = ");
				put(J);
				put(" to ");
				put(K);
				put(" is ");
				put(R); new_line;
			or
				accept done do
					notDone := false;
				end done;
			end select;
		end loop;
		-- put_line("Print DONE");
	end PrintResult;

begin
	null;
end AQMain;