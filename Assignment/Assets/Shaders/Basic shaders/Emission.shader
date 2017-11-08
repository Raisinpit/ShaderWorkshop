Shader "Custom/Emission" {
 Properties {
        _Illumi ("Illumi Color", Color) = (1,1,1,1)
		_IllumiPower ("Intensity",Range(1,10)) = 3
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200
       
        CGPROGRAM
        #pragma surface surf Lambert
 
        fixed4 _Illumi;
		fixed _IllumiPower;	
       
        struct Input {
            float4 color : COLOR;
        };
       
        void surf (Input IN, inout SurfaceOutput o) {
            o.Emission = _Illumi.rgb * _IllumiPower ;
        }
        ENDCG
    }
   
}