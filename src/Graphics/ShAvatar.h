#ifndef SHAVATAR_H
#define SHAVATAR_H

#include <string>
#include <deque>

#include "boost/thread/shared_mutex.hpp"
#include "boost/container/map.hpp"
#include "cinder/Vector.h"
#include "cinder/gl/Vbo.h"
#include "cinder/Text.h"
#include "cinder/gl/Texture.h"
#include "cinder/gl/TextureFont.h"
#include "cinder/app/AppBasic.h"
#include "cinder/Surface.h"
#include "cinder/Quaternion.h"
#include "cinder/gl/Material.h"

class ShAvatar;

class ShAvatarMap
{
public:

    ShAvatarMap();
    ~ShAvatarMap();

    void add(std::string avatar, cinder::Vec3f pos);
    void move(std::string avatar, cinder::Vec3f pos);
    void rotate(std::string avatar, cinder::Quatf rot);
    void setPosX(std::string avatar, float x);
    void setPosY(std::string avatar, float y);
    void setPosZ(std::string avatar, float z);
    void setRotX(std::string avatar, float x);
    void setRotY(std::string avatar, float y);
    void setRotZ(std::string avatar, float z);
    void setRotW(std::string avatar, float w);
    void remove(std::string avatar);
    bool contains(std::string avatar);
    void draw();
    void drawName();
    void clear();
    void update();

    typedef boost::container::map<std::string, ShAvatar*>::iterator avatarIter;

private:

    std::deque<std::string> deletionQueue;
    boost::shared_mutex mMutex;
    boost::container::map<std::string, ShAvatar*> mAvatarMap;
};

class ShAvatar
{
public:

    ShAvatar(std::string userName, cinder::Vec3f pos, int id);

    void setPos(cinder::Vec3f pos);
    void setRot(cinder::Quatf rot);
    void setPosX(float x);
    void setPosY(float y);
    void setPosZ(float z);
    void setRotX(float x);
    void setRotY(float y);
    void setRotZ(float z);
    void setRotW(float w);
    cinder::Vec3f getPos();
    void update();
    void draw();
    void drawName();

    static ShAvatarMap avatarMap;
    static void createMesh();
    static cinder::gl::VboMesh mesh;
    static cinder::gl::Material material;

    std::string mUserName;
    bool nameTextureGenerated;

    static const unsigned int NUM_SEGMENTS = 30;
    static cinder::gl::VboMesh MESH[ShAvatar::NUM_SEGMENTS];
    static std::vector<cinder::Vec3f> positions[ShAvatar::NUM_SEGMENTS];
    static std::vector<cinder::Vec3f> normals[ShAvatar::NUM_SEGMENTS];
    static std::vector<cinder::ColorA> colors[ShAvatar::NUM_SEGMENTS];

private:

    void createNameTexture();

    enum ColorMode
    {
        BLACK_AVATAR = 0,
        RED_AVATAR,
        WHITE_AVATAR
    };

    std::deque<cinder::Vec3f> mPositions;
    cinder::Vec3f mPos, mCubeSize;
    cinder::Vec4f mRotHolder;
    cinder::gl::Texture nameTexture;
    cinder::Quatf mRot;
    int mID;
    ColorMode colorMode;
    boost::shared_mutex mMutex;
};

#endif // SHAVATAR_H
