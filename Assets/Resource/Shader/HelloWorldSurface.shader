Shader "Study/Chapter1/HelloWorldSurface" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
        _RangeProperty("Ranged Value", Range(0, 1)) = 0.5
        _FloatProperty("Fixed value", float) = 0.5
        _TestColor("Color Pick", Color) = (1, 1, 1, 1)
        _Brightness("Brightness", Range(-1, 1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows noambient

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
        half4 _TestColor;
        half _Brightness;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
            float4 worldColor = float4(0.25, 0.25, 1, 0.5);
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * worldColor;
			o.Albedo = _TestColor.rgb + _Brightness;
            //o.Emission = _TestColor.rgb;

			// Metallic and smoothness come from slider variables
			o.Alpha = c.a;
            //o.Alpha = 0.5;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
