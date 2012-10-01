/*
 Thanks to Andreas BÊrentzen for the shader and helpful code:
 http://www2.imm.dtu.dk/~jab/Wireframe/
*/
uniform vec3 WIRE_COL;                                                        
uniform vec3 FILL_COL;
                                                                              
varying vec3 dist;                                                            
varying vec4 vertColor;
                                                                              
void main(void)                                                               
{ 
    // Undo perspective correction.
    vec3 dist_vec = dist * gl_FragCoord.w;

    // Compute the shortest distance to the edge
    float d =min(dist_vec[0],min(dist_vec[1],dist_vec[2]));

    // Compute line intensity and then fragment color
    float I = exp2(-2.0*d*d);
    gl_FragColor.xyz = I*WIRE_COL + (1.0 - I)*FILL_COL;
    //gl_FragColor = vertColor;
    gl_FragColor *= vertColor;
    gl_FragColor.w = 1.0;
}
