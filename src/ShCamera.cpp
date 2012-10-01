/*
 *  ShCamera.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 1/21/12.
 *
 */

// System includes
#include <iostream>

// Local includes
#include "src/ShCamera.h"
#include "src/shmath.h"



using namespace cinder;
using namespace gl;

ShCamera::ShCamera(Vec3f pos) :
	mEye(pos),
	mYaw(0.0f),
	mPitch(0.0f),
	mRoll(0.0f),
	mRotationSpeed(0.0015f),
	mMoveSpeed(10.0f),
	mMinMoveSpeed(15.0f),
    mMaxMoveSpeed(60.0f)
{
	
}

ShCamera::~ShCamera()
{

}

void ShCamera::keyboardInput(bool w, bool a, bool s, bool d, bool q, bool e, bool shift)
{
    Vec3f moveVector(0, 0, 0);
	
	if(w) 
	{
        moveVector += Vec3f(0, 0, -1);
	}
	
	if(a) 
	{
        moveVector += Vec3f(-1, 0, 0);
	}
	
	if(s) 
	{
        moveVector += Vec3f(0, 0, 1);
	}
	
	if(d) 
	{
        moveVector += Vec3f(1, 0, 0);
	}
	
	if(q)
	{
		rollCamera(0.03f);
	}
	
	else if(e)
	{
		rollCamera(-0.03f);
	}
	
	if(shift)
	{
		if(mMoveSpeed < mMaxMoveSpeed)
		{
			mMoveSpeed += 10.0f;
		}
	}
	
	else 
	{
		if(mMoveSpeed > mMinMoveSpeed)
		{
			mMoveSpeed -= 10.0f;
		}
	}


	
	if(w || a || s || d || q || e)
	{
		addToCameraPosition(moveVector);
	}
}

void ShCamera::mouseInput(Vec2f mouseVec)
{
	/*
	if(mouseVec.x > 0)
		mYaw = mRotationSpeed * -1;
	else if(mouseVec.x < 0)
		mYaw = mRotationSpeed * 1;
	else 
		mYaw = 0;

	
	
	if(mouseVec.y > 0)
		mPitch = mRotationSpeed * -1;
	else if(mouseVec.y < 0)
		mPitch = mRotationSpeed * 1;
	else 
		mPitch = 0;*/
	
    //std::cout << "Mouse Move: " << mouseVec << std::endl;
    mYaw = mRotationSpeed * mouseVec.x * -1;
    mPitch = mRotationSpeed * mouseVec.y * -1;

    pitchCamera(mPitch);
    yawCamera(mYaw);
	updateViewMatrix();
    mYaw = 0;
    mPitch = 0;
}

void ShCamera::moveBy(Vec3f mov)
{

}

void ShCamera::moveTo(Vec3f pos)
{

}

void ShCamera::update()
{
	updateViewMatrix();
}

void ShCamera::setup(float windowAspectRatio)
{
	GLfloat distance = 100000.0f;
    mCam.setPerspective(60.0f, windowAspectRatio, 0.1f, distance);
    mUp = Vec3f::yAxis();
    mRight = Vec3f::xAxis();
    mForward = Vec3f::zAxis();
    //mCameraRotation = Quatf(Vec3f(1, 0, 0), mPitch).normalized() *
    //					Quatf(Vec3f(0, 1, 0), mYaw).normalized() *
    //					Quatf(Vec3f(0, 0, -1), mRoll).normalized();
    //mCam.lookAt(Vec3f(6,4,4),Vec3f(0,0,2),Vec3f(0,0,1));
	updateViewMatrix();
}

const CameraPersp& ShCamera::getCam()
{
	return mCam;
}

cinder::Quatf ShCamera::getRotation()
{
	return mCameraRotation;
}

cinder::Vec3f ShCamera::getRotationVector()
{
    //return Vec3f(mCameraRotation[1], mCameraRotation[2], mCameraRotation[3]);
    //return Vec3f(mCameraRotation.getPitch(), mCameraRotation.getYaw(), mCameraRotation.getRoll());
    return mCam.getViewDirection();
}

cinder::Vec3f ShCamera::getEye()
{
	return mEye;
}

void ShCamera::updateViewMatrix()
{
    Vec3f cameraOriginalTarget = Vec3f(0, 0, -1);
    Vec3f cameraRotatedTarget = mCameraRotation * cameraOriginalTarget;
    Vec3f cameraFinalTarget = mEye + cameraRotatedTarget;
    mCam.lookAt(mEye, cameraFinalTarget, mUp);
    //cinder::gl::setMatrices(mCam);
}

void ShCamera::addToCameraPosition(Vec3f vectorToAdd)
{
    Vec3f rotatedVector = mCameraRotation * vectorToAdd;
    mEye += mMoveSpeed * rotatedVector;
	//updateViewMatrix();
}

void ShCamera::pitchCamera(float pitch)
{
    mCameraRotation *= Quatf(mRight, pitch).normalized();
    mUp = Vec3f::yAxis() * mCameraRotation;
    mForward = Vec3f::zAxis() * mCameraRotation;
}

void ShCamera::yawCamera(float yaw)
{
    mCameraRotation *= Quatf(mUp, yaw).normalized();
    mRight = Vec3f::xAxis() * mCameraRotation;
    mForward = Vec3f::zAxis() * mCameraRotation;
}

void ShCamera::rollCamera(float roll)
{
    // mEuler.roll(roll);
    // mCameraRotation = mEuler.toQuaternion();
    mCameraRotation *= Quatf(mForward, roll).normalized();
    mUp = Vec3f::yAxis() * mCameraRotation;
    mRight = Vec3f::xAxis() * mCameraRotation;
}
