﻿Shader "Unlit/Always On Top Transparent"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Transparent"  "IgnoreProjector"="True" "RenderType"="Transparent" }
		LOD 100
		ZTest Always
		Cull off
		Lighting off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_FOG_COORDS(1)
				float4 color : COLOR;
			};

			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				o.color = v.color;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = i.color;
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
