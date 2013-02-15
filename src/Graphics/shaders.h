/*
 Thanks to Andreas BÊrentzen for the shader and helpful code:
 http://www2.imm.dtu.dk/~jab/Wireframe/
*/


#ifndef SHADERS_H
#define SHADERS_H


#include <iostream>
#include "src/Resources.h"
#include "cinder/app/App.h"
#include "cinder/app/AppBasic.h"
#include "cinder/gl/GlslProg.h"

namespace ShShaders {
	
	extern GLint p0_attrib;	  // Vertex attribute
	extern GLint p1_attrib;   // Vertex attribute
	extern GLint p2_attrib;   // Vertex attribute
	extern GLint pickingAttrib; // Picking Vertex Attribute
	extern float kFillRatio;
	extern float kWireRatio;
	
    void loadShaders(cinder::app::AppBasic* app);
	
	void bindPhong();
	void unbindPhong();
	
	void bindWireframe();
	void unbindWireframe();
	
	void setPicking(bool picking);
	
	void bindPicking();
	void unbindPicking();
	
	namespace detail {
		
#ifdef __APPLE__
		void loadPhongShader(cinder::DataSourceRef phongVert, cinder::DataSourceRef phongFrag);
	
		/* Setup for single pass wireframe rendering. This function installs the 
		 required shaders, sets up uniforms and compiles the entire rendering 
		 into a display list. */
        void setupSinglePass(cinder::DataSourceRef wireframeVert, cinder::DataSourceRef wireframeFrag,
                             int width, int height);
		
		void loadPicking(cinder::DataSourceRef pickingVert, cinder::DataSourceRef pickingFrag);
#elif __LINUX__
        void loadPhongShader();
        void setupSinglePass(int width, int height);
        void loadPicking();
#endif
		extern GLhandleARB Prog;
		extern cinder::gl::GlslProg wireframeShader; // The Single Pass Wireframe shader
		extern cinder::gl::GlslProg phongShader;
		extern cinder::gl::GlslProg pickingShader;
    }
}

#endif // SHADERS_H

