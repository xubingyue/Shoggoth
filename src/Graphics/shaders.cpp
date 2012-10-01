/*
 Thanks to Andreas BÊrentzen for the wireframe shader and helpful code:
 http://www2.imm.dtu.dk/~jab/Wireframe/
 */

#include "src/Graphics/shaders.h"
#include "cinder/CinderResources.h"

using namespace ShShaders;

GLint ShShaders::p0_attrib;	  // Vertex attribute
GLint ShShaders::p1_attrib;   // Vertex attribute
GLint ShShaders::p2_attrib;   // Vertex attribute
GLint ShShaders::pickingAttrib; // Picking Vertex Attribute
GLint ShShaders::color;   // Vertex color attribute
cinder::gl::GlslProg ShShaders::detail::phongShader; // phong shader
cinder::gl::GlslProg ShShaders::detail::wireframeShader; // Single Pass wireframe + fill shader
cinder::gl::GlslProg ShShaders::detail::pickingShader; // Shader for rendering picking colors
GLhandleARB ShShaders::detail::Prog;
float ShShaders::kFillRatio = 1;
float ShShaders::kWireRatio = 0.25;

void ShShaders::loadShaders(cinder::app::AppBasic* app)
{
    std::cout << "LOADING SHADERS!!!!!!!!!!!!!!!!!!!!" << std::endl;
	detail::loadPhongShader(app->loadResource(RES_PHONG_VERT), app->loadResource(RES_PHONG_FRAG));
    detail::setupSinglePass(app->loadResource(RES_WIREFRAME_VERT), app->loadResource(RES_WIREFRAME_FRAG),
                             app->getWindowWidth(), app->getWindowHeight());
	detail::loadPicking(app->loadResource(RES_PICKING_VERT), app->loadResource(RES_PICKING_FRAG));
}

void ShShaders::bindPhong()
{
	detail::phongShader.bind();
}

void ShShaders::unbindPhong()
{
    detail::phongShader.unbind();
}

void ShShaders::bindWireframe()
{
	detail::wireframeShader.bind();
}

void ShShaders::unbindWireframe()
{
	detail::wireframeShader.unbind();
}

void ShShaders::setPicking(bool picking)
{
	if(picking)
	{
		detail::wireframeShader.uniform("pickingFlagFrag", 1.0f);
		detail::wireframeShader.uniform("pickingFlagVert", 1.0f);
	}
	
	else
	{
		detail::wireframeShader.uniform("pickingFlagFrag", 0.0f);
		detail::wireframeShader.uniform("pickingFlagVert", 0.0f);
	}
}

void ShShaders::bindPicking()
{
	detail::pickingShader.bind();
}

void ShShaders::unbindPicking()
{
	detail::pickingShader.unbind();
}

void ShShaders::detail::loadPhongShader(cinder::DataSourceRef phongVert, cinder::DataSourceRef phongFrag)
{
	try {
        detail::phongShader = cinder::gl::GlslProg(phongVert, phongFrag);
	}
	catch( cinder::gl::GlslProgCompileExc &exc ) {
		std::cout << "Phong Shader compile error: " << std::endl;
		std::cout << exc.what();
	}
	catch( ... ) {
		std::cout << "Unable to load Phong shader" << std::endl;
	}
}

/* Setup for single pass wireframe rendering. This function installs the 
 required shaders, sets up uniforms and compiles the entire rendering 
 into a display list. */
void ShShaders::detail::setupSinglePass(cinder::DataSourceRef wireframeVert, cinder::DataSourceRef wireframeFrag, 
										 int width, int height)
{	
	try {
        ShShaders::detail::wireframeShader = cinder::gl::GlslProg(wireframeVert, wireframeFrag);
		
		ShShaders::p0_attrib = detail::wireframeShader.getAttribLocation("p0_swizz");
		ShShaders::p1_attrib = detail::wireframeShader.getAttribLocation("p1_3d");
		ShShaders::p2_attrib = detail::wireframeShader.getAttribLocation("p2_3d");
		detail::wireframeShader.bind();
        detail::wireframeShader.uniform("WIN_SCALE", cinder::Vec2f(width/3, height/3));
		detail::wireframeShader.uniform("WIRE_COL", cinder::Vec3f(kWireRatio, kWireRatio, kWireRatio));
        detail::wireframeShader.uniform("FILL_COL", cinder::Vec3f(kFillRatio, kFillRatio, kFillRatio));
        //detail::wireframeShader.uniform("WIRE_COL", cinder::Vec3f(0.5, 0.5,0.5));
        //detail::wireframeShader.uniform("FILL_COL", cinder::Vec3f(2,2,2));
	}
	catch( cinder::gl::GlslProgCompileExc &exc ) {
		std::cout << "Wireframe Shader compile error: " << std::endl;
		std::cout << exc.what();
	}
	catch( ... ) {
		std::cout << "Unable to load Wireframe shader" << std::endl;
	}
}

void ShShaders::detail::loadPicking(cinder::DataSourceRef pickingVert, cinder::DataSourceRef pickingFrag)
{
	try {
        ShShaders::detail::pickingShader = cinder::gl::GlslProg(pickingVert, pickingFrag);
		ShShaders::pickingAttrib = detail::pickingShader.getAttribLocation("pickingAttrib");
	}
	catch( cinder::gl::GlslProgCompileExc &exc ) {
		std::cout << "Picking Shader compile error: " << std::endl;
		std::cout << exc.what();
	}
	catch( ... ) {
		std::cout << "Unable to load Picking shader" << std::endl;
	}
}
