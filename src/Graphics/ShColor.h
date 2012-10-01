/*
 *  ShColor.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/15/12.
 *
 */
#pragma once

#include "cinder/Color.h"

namespace shcolor {
	
	inline cinder::Color charToColor(unsigned char r, unsigned char g, unsigned char b)
	{
		return cinder::Color(r / 255.0f, g / 255.0f, b / 255.0f);
	}
	
	inline unsigned int charToInt(unsigned char r, unsigned char g, unsigned char b)
	{
		return b + (g << 8) + (r << 16);
	}
	
	inline cinder::Color intToColor(unsigned int i)
	{
		unsigned char r = (i >> 16) & 0xff;
		unsigned char g = (i >> 8 ) & 0xff;
		unsigned char b = (i >> 0 ) & 0xff;
		return charToColor(r, g, b);
	}
	
	inline unsigned int colorToInt(const cinder::Color& color)
	{
		unsigned char r = (unsigned char) (color.r * 255);
		unsigned char g = (unsigned char) (color.g * 255);
		unsigned char b = (unsigned char) (color.b * 255);
		return charToInt(r, g, b);
	}
	
	
	inline cinder::ColorA charToColorA(unsigned char r, unsigned char g, unsigned char b)
	{
		return cinder::ColorA(r / 255.0f, g / 255.0f, b / 255.0f, 1);
	}
	
	inline cinder::ColorA intToColorA(unsigned int i)
	{
		unsigned char r = (i >> 16) & 0xff;
		unsigned char g = (i >> 8 ) & 0xff;
		unsigned char b = (i >> 0 ) & 0xff;
		return charToColorA(r, g, b);
	}
	
	inline unsigned int colorAToInt(const cinder::ColorA& color)
	{
		unsigned char r = (unsigned char) (color.r * 255);
		unsigned char g = (unsigned char) (color.g * 255);
		unsigned char b = (unsigned char) (color.b * 255);
		return charToInt(r, g, b);
	}
	
	inline cinder::Vec3f charToVec3f(unsigned char r, unsigned char g, unsigned char b)
	{
		return cinder::Vec3f(r / 255.0f, g / 255.0f, b / 255.0f);
	}
	
	inline cinder::Vec3f intToVec3f(unsigned int i)
	{
		unsigned char r = (i >> 16) & 0xff;
		unsigned char g = (i >> 8 ) & 0xff;
		unsigned char b = (i >> 0 ) & 0xff;
		return charToVec3f(r, g, b);
	}
	
	inline unsigned int vec3fToInt(const cinder::Vec3f& vec)
	{
		unsigned char r = (unsigned char) (vec.x * 255);
		unsigned char g = (unsigned char) (vec.y * 255);
		unsigned char b = (unsigned char) (vec.z * 255);
		return charToInt(r, g, b);
	}
	
	inline cinder::Vec4f intToVec4f(unsigned int i)
	{
		unsigned char r = (i >> 16) & 0xff;
		unsigned char g = (i >> 8 ) & 0xff;
		unsigned char b = (i >> 0 ) & 0xff;
		return cinder::Vec4f(charToVec3f(r, g, b), 1);
	}
};