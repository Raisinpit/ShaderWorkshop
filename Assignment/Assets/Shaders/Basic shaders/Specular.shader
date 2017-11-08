Shader "Custom/Specular" {
	Properties {
	  _MainTex ("Texture", 2D) = "white" {}
	  _Color ("Main Color", Color) = (1,1,1,1)
	  _SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
	  _SpecPower("Spec Power", Range(0.01,1)) = 0.25
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
			LOD 400
		CGPROGRAM
		#pragma surface surf BlinnPhong

		sampler2D _MainTex;
		fixed4 _Color;
		half _SpecPower;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o){
			fixed4 spec = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = spec.rgb * _Color.rgb;
			o.Gloss = spec.a;
			o.Alpha = spec.a * _Color.a;
			o.Specular = _SpecPower;
		}
		ENDCG
	}
	Fallback "Specular"
}
 