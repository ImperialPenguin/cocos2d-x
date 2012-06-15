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
#include "EAGLView_mac.h"
#include "CCDirectorCaller.h"
#include "CCEGLView_mac.h"
#include "CCSet.h"
#include "ccMacros.h"
#include "CCDirector.h"
#include "CCTouch.h"
#include "CCTouchDispatcher.h"

namespace cocos2d {

static CCEGLView * s_pMainWindow;    
    
CCEGLView::CCEGLView()
: m_pDelegate(0)
{
    m_sSizeInPoint.width = m_sSizeInPoint.height = 0;
    s_pMainWindow = NULL;
}

CCEGLView::~CCEGLView()
{

}
    
bool CCEGLView::Create(int ww, int wh, int w, int h)
{
    bool bRet = false;

    m_sSizeInPixel.width = ww;
    m_sSizeInPixel.height = wh;
    
    do 
    {        
        m_sSizeInPoint.width = (float)w;
        m_sSizeInPoint.height = (float)h;   
        
        resize(w, h);
                
        s_pMainWindow = this;
        bRet = true;
    } while (0);
    
    // calculate the factor and the rect of viewport	
    m_fScreenScaleFactor =  MIN((float)m_sSizeInPixel.width / m_sSizeInPoint.width,
                                (float)m_sSizeInPixel.height / m_sSizeInPoint.height);
    
    int viewPortW = (int)(m_sSizeInPoint.width * m_fScreenScaleFactor);
    int viewPortH = (int)(m_sSizeInPoint.height * m_fScreenScaleFactor);
    
    m_rcViewPort.origin.x = (m_sSizeInPixel.width - viewPortW) / 2;
    m_rcViewPort.origin.y = (m_sSizeInPixel.height - viewPortH) / 2;
    m_rcViewPort.size.width = viewPortW;
    m_rcViewPort.size.height = viewPortH;
    
    return bRet;
}    
    
    
void CCEGLView::setDeviceOrientation(int eOritation)
{    
    if (eOritation == CCDeviceOrientationPortrait || eOritation == CCDeviceOrientationPortraitUpsideDown)
    {
        int width = MIN(m_sSizeInPixel.width, m_sSizeInPixel.height);
        m_sSizeInPixel.height = MAX(m_sSizeInPixel.width, m_sSizeInPixel.height);
        m_sSizeInPixel.width = width;
        width = MIN(m_sSizeInPoint.width, m_sSizeInPoint.height);
        m_sSizeInPoint.height = MAX(m_sSizeInPoint.width, m_sSizeInPoint.height);
        m_sSizeInPoint.width = width;
        resize(m_sSizeInPoint.width, m_sSizeInPoint.height);
    }
    else
    {
        int width = MAX(m_sSizeInPixel.width, m_sSizeInPixel.height);
        m_sSizeInPixel.height = MIN(m_sSizeInPixel.width, m_sSizeInPixel.height);
        m_sSizeInPixel.width = width;
        width = MAX(m_sSizeInPoint.width, m_sSizeInPoint.height);
        m_sSizeInPoint.height = MIN(m_sSizeInPoint.width, m_sSizeInPoint.height);
        m_sSizeInPoint.width = width;
        resize(m_sSizeInPoint.width, m_sSizeInPoint.height);
    }
}    

CCSize CCEGLView::getSize()
{
    return CCSize(m_sSizeInPoint.width, m_sSizeInPoint.height);
}

bool CCEGLView::isOpenGLReady()
{
    return [EAGLView sharedEGLView] != NULL;
}
    
bool CCEGLView::canSetContentScaleFactor()
{
	return true;
//   return [[EAGLView sharedEGLView] respondsToSelector:@selector(setContentScaleFactor:)]
//		   && [[NSScreen mainScreen] scale] != 1.0;
}

void CCEGLView::setContentScaleFactor(float contentScaleFactor)
{
//	NSView * view = [EAGLView sharedEGLView];
//	view.contentScaleFactor = contentScaleFactor;
//	[view setNeedsLayout];
}

void CCEGLView::release()
{
	[CCDirectorCaller destroy];
    s_pMainWindow = NULL;
	
	// destroy EAGLView
//	[[EAGLView sharedEGLView] removeFromSuperview];
    
	_exit(0);
}

void CCEGLView::setTouchDelegate(EGLTouchDelegate * pDelegate)
{
    m_pDelegate = pDelegate;
}

void CCEGLView::swapBuffers()
{
	[[EAGLView sharedEGLView] swapBuffers];
}
	
void CCEGLView::setNeedsDisplay(bool flag)
{
	[[EAGLView sharedEGLView] setNeedsDisplay:flag];
}
    
float CCEGLView::getScaledX(float x) {
    return (x - m_rcViewPort.origin.x) / m_fScreenScaleFactor;
}
    
float CCEGLView::getScaledY(float y) {
    return (y - m_rcViewPort.origin.y) / m_fScreenScaleFactor;
}
	
void CCEGLView::touchesBegan(CCSet *set)
{
	if (m_pDelegate) {
		m_pDelegate->touchesBegan(set, NULL);
	}
}

void CCEGLView::touchesMoved(CCSet *set)
{
	if (m_pDelegate) {
		m_pDelegate->touchesMoved(set, NULL);
	}
}

void CCEGLView::touchesEnded(CCSet *set)
{
	if (m_pDelegate) {
		m_pDelegate->touchesEnded(set, NULL);
	}
}

void CCEGLView::touchesCancelled(CCSet *set)
{
	if (m_pDelegate) {
		m_pDelegate->touchesCancelled(set, NULL);
	}
}

void CCEGLView::setViewPortInPoints(float x, float y, float w, float h)
{
    float factor = m_fScreenScaleFactor / CC_CONTENT_SCALE_FACTOR();
    glViewport((GLint)(x * factor) + m_rcViewPort.origin.x,
               (GLint)(y * factor) + m_rcViewPort.origin.y,
               (GLint)(w * factor),
               (GLint)(h * factor));
}

void CCEGLView::setScissorInPoints(float x, float y, float w, float h)
{
    float factor = m_fScreenScaleFactor / CC_CONTENT_SCALE_FACTOR();
    glScissor((GLint)(x * factor) + m_rcViewPort.origin.x,
               (GLint)(y * factor) + m_rcViewPort.origin.y,
               (GLint)(w * factor),
               (GLint)(h * factor));
}

void CCEGLView::setIMEKeyboardState(bool bOpen)
{
    if (bOpen)
    {
        [[EAGLView sharedEGLView] becomeFirstResponder];
    }
    else
    {
        [[EAGLView sharedEGLView] resignFirstResponder];
    }
}
    
void CCEGLView::resize(int width, int height)
{
    // calculate the factor and the rect of viewport	
    m_fScreenScaleFactor =  MIN((float)m_sSizeInPixel.width / m_sSizeInPoint.width,
                                (float)m_sSizeInPixel.height / m_sSizeInPoint.height);
    
    int viewPortW = (int)(m_sSizeInPoint.width * m_fScreenScaleFactor);
    int viewPortH = (int)(m_sSizeInPoint.height * m_fScreenScaleFactor);
    
    m_rcViewPort.origin.x = (m_sSizeInPixel.width - viewPortW) / 2;
    m_rcViewPort.origin.y = (m_sSizeInPixel.height - viewPortH) / 2;
    m_rcViewPort.size.width = viewPortW;
    m_rcViewPort.size.height = viewPortH;
}    

void CCEGLView::setMultiTouchMask(bool mask)
{
#if 0
	EAGLView *glView = [EAGLView sharedEGLView];
	glView.multipleTouchEnabled = mask ? YES : NO;
#endif
}

CCEGLView& CCEGLView::sharedOpenGLView()
{
    CC_ASSERT(s_pMainWindow);
    return *s_pMainWindow;
}

} // end of namespace cocos2d;
