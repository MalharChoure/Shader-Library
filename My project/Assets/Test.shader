Shader"Custom/ShadowDetectShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue" = "Geometry" }
    

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
#include "UnityCG.cginc"


struct appdata
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};

struct v2f
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
};
#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForward.hlsl"

sampler2D _MainTex;
float4 _MainTex_ST;

            // Function to sample the shadow map
float SampleShadowMap(float2 uv)
{
    DirectionalLightData light = _DirectionalLightDatas[0];
 
    float3 positionWS = posInput.positionWS;
    float3 lightDirWS = -light.forward;
 
// Samples the shadow map and returns shadow attenuation value for the current pixel
    float shadowValue = 0;
    float originValue = 0; // Default to full brightness
#if true // Ensure this macro is defined based on your light setup
                    // Sample the shadow map using the provided UV coordinates
    shadowValue = GetDirectionalShadowAttenuation(
    InitShadowContext(),
    posInput.positionSS,
    positionWS,
    GetNormalForShadowBias(bsdfData),
    light.shadowIndex,
    lightDirWS);
#endif
    if (shadowValue == originValue)
    {
        shadowValue = 1;
    }
    else
    {
        shadowValue = 0;
    }
    return shadowValue;
}



v2f vert(appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    return o;
}

fixed4 frag(v2f i) : SV_Target
{
    // Sample shadow map
    float shadowValue = SampleShadowMap(i.uv);

    // Check if the pixel is in shadow or light
    float lightness = 1.0 - shadowValue; // Inverse of shadow value, higher means brighter

    // Example: If the lightness is below a certain threshold, darken the color
    fixed4 col = tex2D(_MainTex, i.uv) * lightness;

    return col;
}


            ENDCG
        }
    }
}