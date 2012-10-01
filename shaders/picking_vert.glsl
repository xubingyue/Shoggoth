attribute vec4 pickingAttrib;

varying vec4 pickingColor;

void main()
{
	/*
	pickingColor = pickingColorAttrib;
	// Set the front color to the color passed through with glColor*f
	//gl_FrontColor = gl_Color;
	// Set the position of the current vertex 
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;*/
	
	//vertColor = pickingColorAttribute;
	pickingColor = pickingAttrib;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
