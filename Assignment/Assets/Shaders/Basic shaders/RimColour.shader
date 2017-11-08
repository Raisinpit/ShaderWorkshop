Shader "Custom/RimColour" {
	Properties {

		_MainTex ("Main Texture", 2D) = "white" {}
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_RimPower("Rim Power", Range(1.0,6.0)) = 3.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		#pragma target 3.0

		sampler2D _MainTex;

		float4 _ColorTint;
		float4 _RimColor;
		float _RimPower;

		struct Input {
			float4 color : Color;
			float2 uv_MainTex;
			float3 viewDir;
		};

      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
          o.Emission = _RimColor.rgb * pow (rim, _RimPower);
      }
		ENDCG
	}
	FallBack "Diffuse"
}
