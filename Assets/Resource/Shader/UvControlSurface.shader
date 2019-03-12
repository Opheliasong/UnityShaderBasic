Shader "Study/Chapter6/UvShader" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MoveSpeed("Move Speed", float) = 1
        _ColorChangeFactor("Change color var", float) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
        float _MoveSpeed;
        float _ColorChangeFactor;

		struct Input {
			float2 uv_MainTex;
		};
        
		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			
            // warping the deefault uv
            //fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // moved by time
            fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x, IN.uv_MainTex.y + _Time.y * _MoveSpeed));

            //o.Emission = c.rgb;
            //o.Emission = float3(sin(_Time.z) * _ChangeColorFactor, sin(_Time.y) * _ChangeColorFactor, 1);
            o.Emission = float3(sin(_Time.z) * _ColorChangeFactor, sin(_Time.y) * _ColorChangeFactor, tan(_Time.y) * _ColorChangeFactor);
            //o.Emission = sin(_Time.x);
			//o.Albedo = IN.uv_MainTex.y;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
