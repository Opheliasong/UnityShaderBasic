Shader "Study/Chapter2/LerpSurface" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo2 (RGB)", 2d) = "white" {}
        _BlendFactor("BlendRange", Range(0, 1)) = 0
        [Toggle]_BlendActive("BlendActive", float) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
        sampler2D _MainTex2;

		struct Input {
			float2 uv_MainTex;
            float2 uv_MainTex2;
		};

		fixed4 _Color;
        fixed _BlendFactor;
        fixed _BlendActive;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D(_MainTex2, IN.uv_MainTex);
			//o.Albedo = lerp( c.rgb , d.rgb , _BlendFactor);
            o.Albedo = lerp(d.rgb, c.rgb, (c.a * _BlendActive));
			// Metallic and smoothness come from slider variables
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
