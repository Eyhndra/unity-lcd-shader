// Upgrade NOTE: upgraded instancing buffer 'LCD' to new syntax.

// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LCD"
{
	Properties
	{
		_PixelationAmount("PixelationAmount", Float) = 1
		_LCDStrength("LCDStrength", Float) = 1
		[HDR]_Texture1("Texture", 2D) = "white" {}
		_ResolutionX("ResolutionX", Float) = 1920
		_ResolutionY("ResolutionY", Float) = 1080
		_TilingX("TilingX", Float) = 1
		_TilingY("TilingY", Float) = 1
		[HDR]_LCD("LCD", 2D) = "white" {}
		[HDR]_Color("Color", Color) = (0,0,0,0)
		_ColorMask("ColorMask", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color;
		uniform float _ColorMask;
		uniform sampler2D _Texture1;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _ResolutionX;
		uniform float _PixelationAmount;
		uniform sampler2D _LCD;
		uniform float _LCDStrength;

		UNITY_INSTANCING_BUFFER_START(LCD)
			UNITY_DEFINE_INSTANCED_PROP(float, _ResolutionY)
#define _ResolutionY_arr LCD
		UNITY_INSTANCING_BUFFER_END(LCD)

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color25 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 lerpResult23 = lerp( color25 , _Color , _ColorMask);
			float4 color28 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
			float2 appendResult10 = (float2(_TilingX , _TilingY));
			float _ResolutionY_Instance = UNITY_ACCESS_INSTANCED_PROP(_ResolutionY_arr, _ResolutionY);
			float2 appendResult4 = (float2(_ResolutionX , _ResolutionY_Instance));
			float2 temp_output_5_0 = ( appendResult4 * ( 1.0 / ( _PixelationAmount + 1.0 ) ) );
			float4 tex2DNode22 = tex2D( _Texture1, ( floor( ( ( i.uv_texcoord * appendResult10 ) * temp_output_5_0 ) ) / temp_output_5_0 ) );
			float4 tex2DNode14 = tex2D( _LCD, ( ( i.uv_texcoord * temp_output_5_0 ) * appendResult10 ) );
			float lerpResult37 = lerp( 0.0 , tex2DNode22.r , tex2DNode14.r);
			float4 color29 = IsGammaSpace() ? float4(0,1,0,1) : float4(0,1,0,1);
			float lerpResult38 = lerp( 0.0 , tex2DNode22.g , tex2DNode14.g);
			float4 color30 = IsGammaSpace() ? float4(0,0,1,1) : float4(0,0,1,1);
			float lerpResult39 = lerp( 0.0 , tex2DNode22.b , tex2DNode14.b);
			o.Emission = ( ( ( ( ( lerpResult23 * color28 ) * lerpResult37 ) + ( ( lerpResult23 * color29 ) * lerpResult38 ) ) + ( ( lerpResult23 * color30 ) * lerpResult39 ) ) * _LCDStrength ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.RangedFloatNode;3;-2048.947,256.9396;Inherit;False;InstancedProperty;_ResolutionY;ResolutionY;4;0;Create;True;0;0;0;False;0;False;1080;1080;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;7;-1877.947,386.9397;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1672.947,276.9396;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1881.947,215.9396;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1705.947,617.9398;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-2049.947,175.9396;Inherit;False;Property;_ResolutionX;ResolutionX;3;0;Create;True;0;0;0;False;0;False;1920;1920;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;23;-360.939,-526.9027;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;230.619,-597.8234;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;246.6684,-391.8568;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;241.3185,-801.1149;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;575.6014,-297.3112;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;586.3009,-118.0938;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;601.0128,37.04968;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;798.1027,-155.0281;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;963.1027,-7.028076;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;14;-950.9475,50.93952;Inherit;True;Property;_LCD;LCD;7;1;[HDR];Create;True;0;0;0;False;0;False;-1;None;3a96738698136c14c97093fafb655053;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;26;-845.6205,-547.9048;Inherit;False;Property;_Color;Color;8;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.9150943,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;-850.6205,-733.9048;Inherit;False;Constant;_White;White;8;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-763.6205,-302.9048;Inherit;False;Property;_ColorMask;ColorMask;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;30;-34.28112,-387.8445;Inherit;False;Constant;_Blue;Blue;10;1;[HDR];Create;True;0;0;0;False;0;False;0,0,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;29;-30.26881,-581.7741;Inherit;False;Constant;_Green;Green;10;1;[HDR];Create;True;0;0;0;False;0;False;0,1,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;28;-26.25647,-795.7649;Inherit;False;Constant;_Red;Red;10;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;38;263.0181,-40.7065;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;39;284.1172,111.0237;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;266.7303,-195.2508;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1119.548,13.83948;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1297.125,247.2775;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-871.9825,412.0446;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;18;-690.5461,477.4009;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1060.893,343.7593;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1257.619,-58.14021;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;53;-1247.697,580.6714;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;52;-536.3694,527.539;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;-305.2653,323.5578;Inherit;True;Property;_Texture1;Texture;2;1;[HDR];Create;True;0;0;0;False;0;False;-1;None;9cbdb96d1e7f9f4449741724b957ef92;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1332.392,-2.469666;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;LCD;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;1115.208,23.93837;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;44;842.2086,119.938;Inherit;False;Property;_LCDStrength;LCDStrength;1;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1853.947,680.9398;Inherit;False;Property;_TilingY;TilingY;6;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1857.947,600.9398;Inherit;False;Property;_TilingX;TilingX;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2336.376,490.9861;Inherit;False;Property;_PixelationAmount;PixelationAmount;0;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-2048.452,435.0275;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1566.947,-151.1316;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;7;1;77;0
WireConnection;5;0;4;0
WireConnection;5;1;7;0
WireConnection;4;0;2;0
WireConnection;4;1;3;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;23;0;25;0
WireConnection;23;1;26;0
WireConnection;23;2;27;0
WireConnection;32;0;23;0
WireConnection;32;1;29;0
WireConnection;33;0;23;0
WireConnection;33;1;30;0
WireConnection;31;0;23;0
WireConnection;31;1;28;0
WireConnection;34;0;31;0
WireConnection;34;1;37;0
WireConnection;35;0;32;0
WireConnection;35;1;38;0
WireConnection;36;0;33;0
WireConnection;36;1;39;0
WireConnection;41;0;34;0
WireConnection;41;1;35;0
WireConnection;42;0;41;0
WireConnection;42;1;36;0
WireConnection;14;1;13;0
WireConnection;38;1;22;2
WireConnection;38;2;14;2
WireConnection;39;1;22;3
WireConnection;39;2;14;3
WireConnection;37;1;22;1
WireConnection;37;2;14;1
WireConnection;13;0;12;0
WireConnection;13;1;10;0
WireConnection;17;0;16;0
WireConnection;17;1;53;0
WireConnection;18;0;17;0
WireConnection;16;0;15;0
WireConnection;16;1;10;0
WireConnection;12;0;11;0
WireConnection;12;1;5;0
WireConnection;53;0;5;0
WireConnection;52;0;18;0
WireConnection;52;1;53;0
WireConnection;22;1;52;0
WireConnection;0;2;43;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;77;0;6;0
ASEEND*/
//CHKSM=0C0681027515B4834DF8BC0E462D5DD5EED02BFB