varying vec4 a_variable;
varying vec2 vUv;
vec4 position;
vec4 newPosition;
void main()
{
    vUv = uv;
    position = ftransform();
    a_variable = vec4(position, 1);
    newPosition = vec4(position, 1);
    gl_Position = position;
}
