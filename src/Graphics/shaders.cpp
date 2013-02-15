/*
 Thanks to Andreas BÊrentzen for the wireframe shader and helpful code:
 http://www2.imm.dtu.dk/~jab/Wireframe/
 */

#include <iostream>
#include <fstream>
#include <streambuf>
#include <string>
#include "src/Graphics/shaders.h"
#include "cinder/CinderResources.h"
#include "cinder/DataSource.h"

namespace ShShaders {

GLint p0_attrib;	  // Vertex attribute
GLint p1_attrib;   // Vertex attribute
GLint p2_attrib;   // Vertex attribute
GLint pickingAttrib; // Picking Vertex Attribute
GLint color;   // Vertex color attribute
#ifdef __LINUX__
std::string phongVertString, phongFragString;
std::string singlePassVertString, singlePassFragString;
std::string pickingVertString, pickingFragString;
#ifdef PURE_GL_SHADER_SETUP
GLuint phongVertexShader, phongFragShader, singlePassVertShader, singlePassFragShader;
GLuint pickingVertShader, pickingFragShader;
GLuint phongProgram, singlePassProgram, pickingProgram;
#endif // PURE_GL_SHADER_SETUP
#endif // __LINUX__
cinder::gl::GlslProg detail::phongShader; // phong shader
cinder::gl::GlslProg detail::wireframeShader; // Single Pass wireframe + fill shader
cinder::gl::GlslProg detail::pickingShader; // Shader for rendering picking colors
GLhandleARB detail::Prog;
float kFillRatio = 1;
float kWireRatio = 0.25;

/*
#define RES_WIREFRAME_VERT	CINDER_RESOURCE( ./resources, wireframe_vert.glsl, 128, GLSL )
#define RES_WIREFRAME_FRAG	CINDER_RESOURCE( ./resources, wireframe_frag.glsl, 129, GLSL )
#define RES_PHONG_VERT	CINDER_RESOURCE( ./resources, phong_vert.glsl, 130, GLSL )
#define RES_PHONG_FRAG	CINDER_RESOURCE( ./resources, phong_frag.glsl, 131, GLSL )
#define RES_PICKING_VERT	CINDER_RESOURCE( ./resources, picking_vert.glsl, 132, GLSL )
#define RES_PICKING_FRAG	CINDER_RESOURCE( ./resources, picking_frag.glsl, 133, GLSL )
#define TEXT_TEXTURE	CINDER_RESOURCE( ./resources, OCRAEXT.ttf, 134, TTF )
#define TIME_QUAKE_TEXT	CINDER_RESOURCE( ./resources, allusedup.ttf, 135, TTF )*/

void loadFile(std::string name, std::string* contents)
{
    std::ifstream fileStream(name.c_str());

    fileStream.seekg(0, std::ios::end);
    contents->reserve(fileStream.tellg());
    fileStream.seekg(0, std::ios::beg);

    contents->assign((std::istreambuf_iterator<char>(fileStream)),
                              (std::istreambuf_iterator<char>()));
}

void loadShaders(cinder::app::AppBasic* app)
{
    std::cout << "LOADING SHADERS!!!!!!!!!!!!!!!!!!!!" << std::endl;
#ifdef __APPLE__
    detail::loadPhongShader(app->loadResource(RES_PHONG_VERT), app->loadResource(RES_PHONG_FRAG));
    detail::setupSinglePass(app->loadResource(RES_WIREFRAME_VERT), app->loadResource(RES_WIREFRAME_FRAG),
                             app->getWindowWidth(), app->getWindowHeight());
    detail::loadPicking(app->loadResource(RES_PICKING_VERT), app->loadResource(RES_PICKING_FRAG));
#else
    // Instead load const char* from File.
    loadFile("./resources/phong_vert.glsl", &phongVertString);
    loadFile("./resources/phong_frag.glsl", &phongFragString);
    loadFile("./resources/wireframe_vert.glsl", &singlePassVertString);
    loadFile("./resources/wireframe_frag.glsl", &singlePassFragString);
    loadFile("./resources/picking_vert.glsl", &pickingVertString);
    loadFile("./resources/picking_frag.glsl", &pickingFragString);

    detail::loadPhongShader();
    detail::setupSinglePass(app->getWindowWidth(), app->getWindowHeight());
    detail::loadPicking();

#endif
}

#ifndef PURE_GL_SHADER_SETUP

void bindPhong()
{
    detail::phongShader.bind();
}

void unbindPhong()
{
    detail::phongShader.unbind();
}

void bindWireframe()
{
	detail::wireframeShader.bind();
}

void unbindWireframe()
{
	detail::wireframeShader.unbind();
}

void setPicking(bool picking)
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

void bindPicking()
{
    detail::pickingShader.bind();
}

void unbindPicking()
{
    detail::pickingShader.unbind();
}

#else
void bindPhong()
{
    glUseProgram(phongProgram);
}

void unbindPhong()
{
    glUseProgram(0);
}

void bindWireframe()
{
    glUseProgram(singlePassProgram);
}

void unbindWireframe()
{
    glUseProgram(0);
}

void setPicking(bool picking)
{

}

void bindPicking()
{
    glUseProgram(pickingProgram);
}

void unbindPicking()
{
    glUseProgram(0);
}

void loadShaderProgram(GLuint* program, GLuint* vertexShader, GLuint* fragmentShader,
                       std::string& vertSource, std::string& fragSource)
{
    try
    {
        *vertexShader = glCreateShader(GL_VERTEX_SHADER);
        *fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);

        int vertLength = vertSource.length();
        int fragLength = fragSource.length();
        const char* vertString = vertSource.c_str();
        const char* fragString = fragSource.c_str();

        glShaderSourceARB(*vertexShader, 1, &vertString, &vertLength);
        glShaderSourceARB(*fragmentShader, 1, &fragString, &fragLength);
        glCompileShader(*vertexShader);
        glCompileShader(*fragmentShader);

        *program = glCreateProgram();
        glAttachShader(*program, *vertexShader);
        glAttachShader(*program, *fragmentShader);
        glLinkProgram(*program);
    }

    catch(std::exception& e)
    {
        std::cout << "Error loading shader:" << std::endl;
        std::cout << e.what();
    }
}

#endif

#ifdef __APPLE__
void detail::loadPhongShader(cinder::DataSourceRef phongVert, cinder::DataSourceRef phongFrag)
{
    std::cout << "Phong Vert file path: " << phongVert->getFilePath() << std::endl;
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

void initSinglePass(int width, int height)
{
    p0_attrib = detail::wireframeShader.getAttribLocation("p0_swizz");
    p1_attrib = detail::wireframeShader.getAttribLocation("p1_3d");
    p2_attrib = detail::wireframeShader.getAttribLocation("p2_3d");
    detail::wireframeShader.bind();
    detail::wireframeShader.uniform("WIN_SCALE", cinder::Vec2f(width/3, height/3));
    detail::wireframeShader.uniform("WIRE_COL", cinder::Vec3f(kWireRatio, kWireRatio, kWireRatio));
    detail::wireframeShader.uniform("FILL_COL", cinder::Vec3f(kFillRatio, kFillRatio, kFillRatio));
}

/* Setup for single pass wireframe rendering. This function installs the 
 required shaders, sets up uniforms and compiles the entire rendering 
 into a display list. */
void detail::setupSinglePass(cinder::DataSourceRef wireframeVert, cinder::DataSourceRef wireframeFrag,
										 int width, int height)
{	
	try {
        detail::wireframeShader = cinder::gl::GlslProg(wireframeVert, wireframeFrag);
        initSinglePass(width, height);
	}
	catch( cinder::gl::GlslProgCompileExc &exc ) {
		std::cout << "Wireframe Shader compile error: " << std::endl;
		std::cout << exc.what();
	}
	catch( ... ) {
		std::cout << "Unable to load Wireframe shader" << std::endl;
	}
}

void detail::loadPicking(cinder::DataSourceRef pickingVert, cinder::DataSourceRef pickingFrag)
{
	try {
        detail::pickingShader = cinder::gl::GlslProg(pickingVert, pickingFrag);
        pickingAttrib = detail::pickingShader.getAttribLocation("pickingAttrib");
	}
	catch( cinder::gl::GlslProgCompileExc &exc ) {
		std::cout << "Picking Shader compile error: " << std::endl;
		std::cout << exc.what();
	}
	catch( ... ) {
		std::cout << "Unable to load Picking shader" << std::endl;
	}
}

#elif PURE_GL_SHADER_SETUP
void detail::loadPhongShader()
{
    loadShaderProgram(&phongProgram, &phongVertexShader, &phongFragShader,
                      phongVertString, phongFragString);
}

void detail::setupSinglePass(int width, int height)
{
    loadShaderProgram(&singlePassProgram, &singlePassVertShader, &singlePassFragShader,
                      singlePassVertString, singlePassFragString);

    initSinglePass(width, height);
}

void detail::loadPicking()
{
    loadShaderProgram(&pickingProgram, &pickingVertShader, &pickingFragShader,
                      pickingVertString, pickingFragString);

    // pickingAttrib = detail::pickingShader.getAttribLocation("pickingAttrib");
    glBindAttribLocationARB(pickingProgram, 16, "pickingAttrib");
    pickingAttrib = 16;
}
#elif __LINUX__
void detail::loadPhongShader()
{
    std::cout << "Phong Vert file path: " << phongVertString << std::endl;
    try {
        detail::phongShader = cinder::gl::GlslProg(phongVertString.c_str(), phongFragString.c_str());
    }
    catch( cinder::gl::GlslProgCompileExc &exc ) {
        std::cout << "Phong Shader compile error: " << std::endl;
        std::cout << exc.what();
    }
    catch( ... ) {
        std::cout << "Unable to load Phong shader" << std::endl;
    }
}

void initSinglePass(int width, int height)
{
    p0_attrib = detail::wireframeShader.getAttribLocation("p0_swizz");
    p1_attrib = detail::wireframeShader.getAttribLocation("p1_3d");
    p2_attrib = detail::wireframeShader.getAttribLocation("p2_3d");
    detail::wireframeShader.bind();
    detail::wireframeShader.uniform("WIN_SCALE", cinder::Vec2f(width/3, height/3));
    detail::wireframeShader.uniform("WIRE_COL", cinder::Vec3f(kWireRatio, kWireRatio, kWireRatio));
    detail::wireframeShader.uniform("FILL_COL", cinder::Vec3f(kFillRatio, kFillRatio, kFillRatio));
}

/* Setup for single pass wireframe rendering. This function installs the
 required shaders, sets up uniforms and compiles the entire rendering
 into a display list. */
void detail::setupSinglePass(int width, int height)
{
    try {
        detail::wireframeShader = cinder::gl::GlslProg(singlePassVertString.c_str(),
                                                       singlePassFragString.c_str());
        initSinglePass(width, height);
    }
    catch( cinder::gl::GlslProgCompileExc &exc ) {
        std::cout << "Wireframe Shader compile error: " << std::endl;
        std::cout << exc.what();
    }
    catch( ... ) {
        std::cout << "Unable to load Wireframe shader" << std::endl;
    }
}

void detail::loadPicking()
{
    try {
        detail::pickingShader = cinder::gl::GlslProg(pickingVertString.c_str(), pickingFragString.c_str());
        pickingAttrib = detail::pickingShader.getAttribLocation("pickingAttrib");
    }
    catch( cinder::gl::GlslProgCompileExc &exc ) {
        std::cout << "Picking Shader compile error: " << std::endl;
        std::cout << exc.what();
    }
    catch( ... ) {
        std::cout << "Unable to load Picking shader" << std::endl;
    }
}
#endif

} // ShShaders namespace
