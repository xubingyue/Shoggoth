uniform sampler2D tDiffuse;
varying vec2 vUv;
varying vec4 a_variable;
vec4 frag_variable;
vec4 fragColor;
void main()
{
    frag_variable = a_variable;
    fragColor = texture2D(tDiffuse, vUv);
    fragColor = vec4(distance(frag_variable.x, fragColor.x), distance(frag_variable.y, fragColor.y), distance(frag_variable.z, fragColor.z), distance(frag_variable.w, fragColor.w)) * vec4(-0.01, -0.1, -0.01, -0.01) + fragColor;
    fragColor = sign(frag_variable * fragColor - gl_FragCoord);
    fragColor = fragColor * frag_variable;
    fragColor = fragColor + frag_variable;
    fragColor = fragColor + -0.06535433070866142;
    fragColor = radians(fragColor * ceil(fragColor));
    fragColor = fragColor + -0.019685039370078733;
    fragColor = fragColor + -0.05433070866141732;
    fragColor = vec4(cross(gl_FragCoord.xyz, fragColor.xyz), 1);
    fragColor = fragColor + -0.046456692913385826;
    fragColor = pow(frag_variable, pow(frag_variable, fragColor));
    fragColor = acos(fragColor);
    fragColor = vec4(cross(fragColor.xyz, frag_variable.xyz), 1);
    fragColor = fragColor / inversesqrt(vec4(1, 1, 1, 1) / exp2(fragColor)) - frag_variable;
    fragColor = vec4(distance(frag_variable.x, fragColor.x), distance(frag_variable.y, fragColor.y), distance(frag_variable.z, fragColor.z), distance(frag_variable.w, fragColor.w)) * vec4(-0.01, -0.1, -0.01, -0.01) + fragColor;
    gl_FragColor = vec4(1, 1, 1, 1) - mod(fragColor + texture2DProj(tDiffuse, normalize(fragColor) - (vec4(vUv, vUv))) - (gl_FragColor), gl_FragColor);
}
