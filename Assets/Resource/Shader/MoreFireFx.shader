Shader "Study/Chapter6/MoreEffFireFx" {
	Properties {		
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)", 2D) = "black" {}
        _RiffleVar("Riffle value", Range(0, 1))  = 1
        _OffsetX ("Offset X Axis", Range(0, 1)) = 0
        _OffSetY("Offset Y Axis", Range(0, 1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
        sampler2D _MainTex2;
        fixed _RiffleVar;
        fixed _OffsetX;
        fixed _OffSetY;

		struct Input {
			float2 uv_MainTex;
            float2 uv_MainTex2;
		};

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
            fixed4 d = tex2D (_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y - _Time.y));
            //fixed4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y));
            d.rgb = d.rgb * _RiffleVar;

			//fixed4 c = tex2D (_MainTex, IN.uv_MainTex + d.r);
            fixed4 c = tex2D(_MainTex, float2((IN.uv_MainTex.x + d.r) - _OffsetX, (IN.uv_MainTex.y + d.r) - _OffSetY));
			
            o.Albedo = c.rgb;
            //o.Albedo = d.rgb;

            //o.Alpha = d.a;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
