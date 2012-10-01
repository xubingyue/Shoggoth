/*                                                                            

	Thanks to Andreas BÊrentzen for the shader and helpful code:
	http://www2.imm.dtu.dk/~jab/Wireframe/

	
	Input: The vertex position and vertex attributes p1_3d and p2_3d which       
	are the positions of neighbouring vertices.                                  
                                                                              
	Output:   dist a vector of distances from the vertex to the three edges of   
	the triangle. Clearly only one of these distance is non-zero. For vertex 0   
	in a triangle dist = (distance to opposite edge, 0, 0) on exit. The distance 
	is multiplied by w. This is to negate perspective correction.                
*/                                                                            
uniform vec2 WIN_SCALE;

// ADDED so we can use this with a VBO and without a Vec4f position. 
attribute float p0_swizz;                                                       
attribute vec4 p1_3d;                                                         
attribute vec4 p2_3d;
																			                                                         
varying vec3 dist;
varying vec4 vertColor;

void main(void)                                            
{
    // We store the vertex id (0,1, or 2) in the w coord of the vertex
    // which then has to be restored to w=1.
    //float swizz = gl_Vertex.w;  // removed and replaced with another attribute
    vec4 pos = gl_Vertex;
    pos.w = 1.0;
    float swizz = p0_swizz;

    // Compute the vertex position in the usual fashion.
    gl_Position = gl_ModelViewProjectionMatrix * pos;

    // p0 is the 2D position of the current vertex.
    vec2 p0 = gl_Position.xy/gl_Position.w;

    // Project p1 and p2 and compute the vectors v1 = p1-p0
    // and v2 = p2-p0
    vec4 p1_3d_ = gl_ModelViewProjectionMatrix * p1_3d;
    vec2 v1 = WIN_SCALE*(p1_3d_.xy / p1_3d_.w - p0);

    vec4 p2_3d_ = gl_ModelViewProjectionMatrix * p2_3d;
    vec2 v2 = WIN_SCALE*(p2_3d_.xy / p2_3d_.w - p0);

    // Compute 2D area of triangle.
    float area2 = abs(v1.x*v2.y - v1.y * v2.x);

    // Compute distance from vertex to line in 2D coords
    float h = area2/length(v1-v2);
    //h += (cos(h) * 4.0); // THIS ADDS AN INTERESTING SHINY LOOK

    // ---
    // The swizz variable tells us which of the three vertices
    // we are dealing with. The ugly comparisons would not be needed if
    // swizz was an int.

    if(swizz<0.1)
            dist = vec3(h,0,0);
    else if(swizz<1.1)
            dist = vec3(0,h,0);
    else
            dist = vec3(0,0,h);

    // ----
    // Quick fix to defy perspective correction
    dist *= gl_Position.w;
    vertColor = gl_Color;
}
