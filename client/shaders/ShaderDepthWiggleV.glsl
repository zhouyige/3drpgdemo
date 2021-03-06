//
// Structure definitions
//

struct VS_OUTPUT {
    vec4 Position;
    vec4 UV;
};


//
// Global variable definitions
//

uniform float MaxD;
uniform float Timer;
uniform mat4 mWorldViewProj;

//
// Function declarations
//

VS_OUTPUT vertexMain( in vec3 Position, in vec4 UV, in vec4 Tangent, in vec4 Binormal, in vec4 Normal );

//
// Function definitions
//

VS_OUTPUT vertexMain( in vec3 Position, in vec4 UV, in vec4 Tangent, in vec4 Binormal, in vec4 Normal ) {
    vec4 Po;
    float iny;
    float wiggleX;
    float wiggleY;
    VS_OUTPUT OUT;

    float timeNow = (Timer);
    Po = vec4( Position.xyz , 1.00000);
    iny = ((Po.y  * 0.500000) + timeNow);
    wiggleX = (sin( iny ) * 0.500000);
    wiggleY = (cos( iny ) * 0.500000);
    Po.x  = (Po.x  + wiggleX);
    OUT.Position = ( mWorldViewProj * Po  );
    OUT.UV = vec4( (OUT.Position.z  / MaxD));
    return OUT;
}


//
// Attributes
//
attribute vec4 xlat_attrib_tangent;
attribute vec4 xlat_attrib_binorm;

//
// User varying
//
varying vec4 xlat_varying_COLOR0;

//
// Translator's entry point
//
void main() {
    VS_OUTPUT xlat_retVal;

    xlat_retVal = vertexMain( vec3(gl_Vertex), vec4(gl_MultiTexCoord0), vec4(xlat_attrib_tangent), vec4(xlat_attrib_binorm), vec4(gl_Normal, 0.0));

    gl_Position = vec4( xlat_retVal.Position);
    xlat_varying_COLOR0 = vec4( xlat_retVal.UV);
}


 