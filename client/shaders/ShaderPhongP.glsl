//
// Translator library functions
//

float xlat_lib_saturate( float x) {
  return clamp( x, 0.0, 1.0);
}

vec2 xlat_lib_saturate( vec2 x) {
  return clamp( x, 0.0, 1.0);
}

vec3 xlat_lib_saturate( vec3 x) {
  return clamp( x, 0.0, 1.0);
}

vec4 xlat_lib_saturate( vec4 x) {
  return clamp( x, 0.0, 1.0);
}

mat2 xlat_lib_saturate(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}

mat3 xlat_lib_saturate(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}

mat4 xlat_lib_saturate(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}



//
// Global variable definitions
//

uniform sampler2D tex0;

//
// Function declarations
//

vec4 pixelMain( in vec3 Light, in vec3 Norm, in vec3 View, in vec2 TexCo );

//
// Function definitions
//

vec4 pixelMain( in vec3 Light, in vec3 Norm, in vec3 View, in vec2 TexCo ) {
    vec4 diffuse;
    vec4 diff;
    vec3 Reflect;
    vec4 specular;

    diffuse = texture2D( tex0, TexCo);
    diff = vec4( xlat_lib_saturate( dot( Norm, Light) ));
    Reflect = ((vec3( (2.00000 * diff)) * Norm) - Light);
    specular = vec4( pow( xlat_lib_saturate( dot( Reflect, View) ), 8.00000));
    return ((diffuse * diff) + specular);
}


//
// User varying
//
varying vec4 xlat_varying_TEXCOORD0;
varying vec4 xlat_varying_TEXCOORD1;
varying vec4 xlat_varying_TEXCOORD2;
varying vec4 xlat_varying_TEXCOORD3;

//
// Translator's entry point
//
void main() {
    vec4 xlat_retVal;

    xlat_retVal = pixelMain( vec3(xlat_varying_TEXCOORD0), vec3(xlat_varying_TEXCOORD1), vec3(xlat_varying_TEXCOORD2), vec2(xlat_varying_TEXCOORD3));

    gl_FragData[0] = vec4( xlat_retVal);
}


 