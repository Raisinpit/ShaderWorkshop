 Shader "Example/Diffuse Simple" {
   	  Properties{
	  	_Diffuse ("Intensity", Range(0., 1.)) = 0.1
	  }
	SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float4 color : COLOR;

      };
	  fixed _Diffuse;
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = _Diffuse;
      }
      ENDCG
    }
    Fallback "Diffuse"
  }