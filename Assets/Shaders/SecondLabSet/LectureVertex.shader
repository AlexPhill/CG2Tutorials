Shader "Alexander/LectureVertex"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _DisplacementMap("Displacement Texture", 2D) = "black" {}
        _DisplacementStrength("Displacement Str", float) = 1
        _VValue("V Slider Value", Range(-5,5)) = 0.0
        _MValue("M Slider Value", Range(-5,5)) = 0.0
        _ZValue("Z Slider Value", Range(-5,5)) = 0.0
    }
        SubShader
        {
            Pass
            {

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #include "UnityCG.cginc"

            // Physically based Standard lighting model, and enable shadows on all light types
            //#pragma surface surf Standard fullforwardshadows

            struct Input
            {
            float2 uv_MainTex;
            //float viewDir
            };

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL; //collecting normals of model
                float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv :TEXCOORD0;
                float4 wPos : TEXCOORD1;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            half _Glossiness;
            half _Metallic;
            fixed4 _Color;


            sampler2D _MainTex;
            sampler2D _DisplacementMap;
            float _DisplacementStrength;
            half _VValue;
            half _MValue;
            half _ZValue;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                //half rim = 1 - saturate(dot(normalize(IN.viewdir) , o.normal));
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.vertex = UnityObjectToClipPos(v.vertex);


                float displacement = tex2Dlod(_DisplacementMap, float4(o.uv, 0, 0)).r;
                float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
                //temp.xyz += displacement * v.normal * _DisplacementStrength;
                //temp.xyz += displacement  * v.normal * _DisplacementStrength * sin(sqrt(pow(v.vertex.x, 2) + pow(v.vertex.y, 2)));
                temp.xyz += dot((sin((dot(v.vertex.x, _VValue)) + _MValue)), _ZValue);
                o.vertex = UnityObjectToClipPos(temp);

                UNITY_TRANSFER_FOG(o, o.vertex);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
