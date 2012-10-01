/*
 *  Resources.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 2/10/12.
 *
 */



#pragma once
#include "cinder/CinderResources.h"

#define RES_WIREFRAME_VERT	CINDER_RESOURCE( ../Resources, wireframe_vert.glsl, 128, GLSL )
#define RES_WIREFRAME_FRAG	CINDER_RESOURCE( ../Resources, wireframe_frag.glsl, 129, GLSL )
#define RES_PHONG_VERT	CINDER_RESOURCE( ../Resources, phong_vert.glsl, 130, GLSL )
#define RES_PHONG_FRAG	CINDER_RESOURCE( ../Resources, phong_frag.glsl, 131, GLSL )
#define RES_PICKING_VERT	CINDER_RESOURCE( ../Resources, picking_vert.glsl, 132, GLSL )
#define RES_PICKING_FRAG	CINDER_RESOURCE( ../Resources, picking_frag.glsl, 133, GLSL )
#define TEXT_TEXTURE	CINDER_RESOURCE( ./, OCRAEXT.ttf, 134, TTF )
#define TIME_QUAKE_TEXT	CINDER_RESOURCE( ./, allusedup.ttf, 135, TTF )
