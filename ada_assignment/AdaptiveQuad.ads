generic 
	-- type T is limited private;
	with function F(X : Float) return Float;
package AdaptiveQuad is
	function AQuad(A, B, Eps : Float) return Float;
end AdaptiveQuad;