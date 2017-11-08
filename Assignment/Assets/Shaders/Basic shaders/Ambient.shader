Shader "Custom/Ambient"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
 
        [Header(Ambient)]
        _Ambient ("Intensity", Range(0., 1.)) = 0.1
        _AmbColor ("Color", color) = (1., 1., 1., 1.)
    }
 
    SubShader
    {
        Pass
        {
            Tags { "RenderType"="Opaque" "Queue"="Geometry" "LightMode"="ForwardBase" }
 
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
 
            // Change "shader_feature" with "pragma_compile" if you want set this keyword from c# code
            #pragma shader_feature __ _SPEC_ON
 
            #include "UnityCG.cginc"
 
            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                float3 worldNormal : TEXCOORD2;
            };
 
            v2f vert(appdata_base v)
            {
                v2f o;
                //World position
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
 
                // Clip position
                o.pos = mul(UNITY_MATRIX_VP, float4(o.worldPos, 1.));
 
                // Normal in WorldSpace
                o.worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
 
                o.uv = v.texcoord;
 
                return o;
            }
 
            sampler2D _MainTex;

            //Ambient
            fixed _Ambient;
            fixed4 _AmbColor;
 
            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 c = tex2D(_MainTex, i.uv);

                // Compute ambient lighting
                fixed4 amb = _Ambient * _AmbColor;
                fixed4 light =amb;
                c.rgb *= light.rgb;
                return c;
            }
            ENDCG
        }
    }
	FallBack "Ambient"
}