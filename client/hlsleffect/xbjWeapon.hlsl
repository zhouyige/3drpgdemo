// part of the Irrlicht Engine Shader example.
// These simple Direct3D9 pixel and vertex shaders will be loaded by the shaders
// example. Please note that these example shaders don't do anything really useful. 
// They only demonstrate that shaders can be used in Irrlicht.

//-----------------------------------------------------------------------------
// Global variables
//-----------------------------------------------------------------------------
float4x4 mWorldViewProj;  // World * View * Projection transformation
float4x4 mInvWorld;       // Inverted world matrix
float4x4 mTransWorld;     // Transposed world matrix
float3 mLightPos;         // Light position
float4 mLightColor;       // Light color
float mAlpha;	//͸���� 0-1

// Vertex shader output structure
struct VS_OUTPUT
{
	float4 Position   : POSITION;   // vertex position 
	float4 Diffuse    : COLOR0;     // vertex diffuse color
	float2 TexCoord   : TEXCOORD0;  // tex coords
};


VS_OUTPUT vertexMain( in float4 vPosition : POSITION,
                    in float3 vNormal   : NORMAL,
                      float2 texCoord     : TEXCOORD0 )
{
	VS_OUTPUT Output;

	// transform position to clip space 
	Output.Position = mul(vPosition, mWorldViewProj);

	// transform normal 
	float3 normal = mul(vNormal, mInvWorld);
	
	// renormalize normal 
	normal = normalize(normal);
	
	// position in world coodinates
	float3 worldpos = mul(mTransWorld, vPosition);
	
	// calculate light vector, vtxpos - lightpos
	float3 lightVector = worldpos - mLightPos;
	
	// normalize light vector 
	lightVector = normalize(lightVector);
	
	// calculate light color  
	float3 tmp2 = dot(-lightVector, normal);
	tmp2 = lit(tmp2.x, tmp2.y, 1.0);

	float3 tmp = mLightColor * mAlpha*(1.2-tmp2);
	Output.Diffuse = float4(tmp.x*2, tmp.y*2, tmp.z*2, 0);
	Output.TexCoord = texCoord;
	
	return Output;
}



// Pixel shader output structure
struct PS_OUTPUT
{
    float4 RGBColor : COLOR0;  // Pixel color    
};


sampler2D tex0;
	
PS_OUTPUT pixelMain( float2 TexCoord : TEXCOORD0,
                     float4 Position : POSITION,
                     float4 Diffuse  : COLOR0 ) 
{ 
	PS_OUTPUT Output;

	float4 col = tex2D( tex0, TexCoord );  // sample color map
	
	// multiply with diffuse and do other senseless operations
	Output.RGBColor =   col*Diffuse;
	Output.RGBColor *= 2.0;

	return Output;
}

