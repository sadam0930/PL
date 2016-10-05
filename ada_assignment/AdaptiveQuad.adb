package body AdaptiveQuad is

	function SimpsonsRule(A, B : Float) return Float is
	C, H3 : Float;
	begin
		C := (A+B)/2.0;
		H3 := abs(B-A)/6.0;
		return H3*(F(A) + 4.0*F(C) + F(B));
	end SimpsonsRule;

	function RecAQuad(A, B, Eps, whole: Float) return Float is
	C, left, right, leftResult, rightResult : Float;
	begin
		C := (A+B)/2.0;
		left := SimpsonsRule(A,C);
		right := SimpsonsRule(C,B);
		if abs(left + right - whole) <= 15.0*Eps then
			return left + right + (left + right - whole)/15.0;
		else
			declare
				task computeLeft;
				task computeRight;
				
				task body computeLeft is
				begin
					leftResult := RecAQuad(A, C, Eps/2.0, left);
				end computeLeft;
				
				task body computeRight is
				begin
					rightResult := RecAQuad(C, B, Eps/2.0, right);
				end computeRight;
			begin
				null;
			end;
		end if; 
		return leftResult + rightResult;
	end RecAQuad;

	function AQuad(A, B, Eps : Float) return Float is
	begin
		return RecAQuad(A, B, Eps, SimpsonsRule(A, B));
	end AQuad;

end AdaptiveQuad;