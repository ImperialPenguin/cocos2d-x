/****************************************************************************
Copyright (c) 2010 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/

#ifndef __CC_EGLVIEW_IPHONE_H__
#define __CC_EGLVIEW_IPHONE_H__

#include "CCGeometry.h"
#include "CCCommon.h"

namespace   cocos2d {
class CCSet;
class CCTouch;
class EGLTouchDelegate;
class CCSize;

class CC_DLL CCEGLView
{
public:
    CCEGLView();
   ~CCEGLView();

    bool    Create(int ww, int wh, int w, int h);
    void    setDeviceOrientation(int eOritation);
    CCSize  getSize();
    bool    isOpenGLReady();
    bool    canSetContentScaleFactor();
    void    setContentScaleFactor(float contentScaleFactor);
    
    float   getScaledX(float x);
    float   getScaledY(float y);    
    
    // keep compatible
    void    release();
    void    setTouchDelegate(EGLTouchDelegate * pDelegate);
    void    swapBuffers();
    void    resize(int width, int height);
    void    setViewPortInPoints(float x, float y, float w, float h);
    void    setScissorInPoints(float x, float y, float w, float h);
	void	setNeedsDisplay(bool flag);

    void touchesBegan(CCSet *set);
    void touchesMoved(CCSet *set);
    void touchesEnded(CCSet *set);

    void touchesCancelled(CCSet *set);
    
    void setIMEKeyboardState(bool bOpen);
    //set multitouch mask
	void setMultiTouchMask(bool mask);
    static CCEGLView& sharedOpenGLView();
        
private:
    EGLTouchDelegate *m_pDelegate;
    
    float               m_fScreenScaleFactor;
    CCRect              m_rcViewPort;
    
	CCSize  			m_sSizeInPixel;
	CCSize 			 	m_sSizeInPoint;
	
};
	
}   // end of namespace   cocos2d

#endif	// end of __CC_EGLVIEW_IPHONE_H__
